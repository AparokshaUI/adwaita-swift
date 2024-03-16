//
//  Window.swift
//  Adwaita
//
//  Created by david-swift on 14.09.23.
//

// swiftlint:disable discouraged_optional_collection

import CAdw
import Foundation

/// A structure representing an application window type.
///
/// Note that multiple instances of a window can be opened at the same time.
public struct Window: WindowScene {

    /// The window's identifier.
    public var id: String
    /// The window's content.
    var content: (GTUIApplicationWindow) -> Body
    /// Whether an instance of the window type should be opened when the app is starting up.
    public var `open`: Int
    /// The identifier of the window's parent.
    public var parentID: String?
    /// The keyboard shortcuts.
    var shortcuts: [String: (GTUIApplicationWindow) -> Void] = [:]
    /// The keyboard shortcuts on the app level.
    public var appShortcuts: [String: (GTUIApp) -> Void] = [:]
    /// The window's title.
    var title: String?
    /// Whether the window is resizable.
    var resizable = true
    /// Whether the window is deletable.
    var deletable = true
    /// The signals for the importers and exporters.
    var signals: [Signal] = []
    /// The binding for the window's width.
    var width: Binding<Int>?
    /// The binding for the window's height.
    var height: Binding<Int>?
    /// Whether to update the default size.
    var setDefaultSize = false
    /// Whether the window is maximized.
    var maximized: Binding<Bool>?

    /// Create a window type with a certain identifier and user interface.
    /// - Parameters:
    ///   - id: The identifier.
    ///   - open: The number of instances of the window type when the app is starting.
    ///   - content: The window's content.
    public init(id: String, `open`: Int = 1, @ViewBuilder content: @escaping (GTUIApplicationWindow) -> Body) {
        self.content = content
        self.id = id
        self.open = open
    }

    /// Get the storage for the window.
    /// - Parameter app: The application.
    /// - Returns: The storage.
    public func createWindow(app: GTUIApp) -> WindowStorage {
        let window = createGTUIWindow(app: app)
        let storage = getViewStorage(window: window)
        let windowStorage = WindowStorage(id: id, window: window, view: storage)
        window.observeHide {
            windowStorage.destroy = true
        }
        windowStorage.parentID = parentID
        return windowStorage
    }

    /// Get the window.
    /// - Parameter app: The application.
    /// - Returns: The window.
    func createGTUIWindow(app: GTUIApp) -> GTUIApplicationWindow {
        let window = GTUIApplicationWindow(app: app)
        updateAppShortcuts(app: app)
        window.show()
        return window
    }

    /// Get the storage of the content view.
    /// - Parameter window: The window.
    /// - Returns: The storage of the content of the window.
    func getViewStorage(window: GTUIApplicationWindow) -> ViewStorage {
        let content = content(window)
        let template = getTemplate(content: content)
        let storage = content.widget(modifiers: []).container(modifiers: [])
        window.setChild(storage.pointer)
        setProperties(window: window, template: template)
        updateShortcuts(window: window, template: template)
        window.setDefaultSize(width: template.width?.wrappedValue, height: template.height?.wrappedValue)
        return storage
    }

    /// Update a window storage's content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - app: The GTUI app.
    ///     - force: Whether to force update all the views.
    public func update(_ storage: WindowStorage, app: GTUIApp, force: Bool) {
        if let window = storage.window as? GTUIApplicationWindow {
            let content = content(window)
            let template = getTemplate(content: content)
            if let view = storage.view {
                content.widget(modifiers: []).updateStorage(view, modifiers: [], updateProperties: force)
            }
            setProperties(window: window, template: template)
            updateShortcuts(window: window, template: template)
            updateAppShortcuts(app: app)
        }
        for signal in signals where signal.update {
            Task {
                app.showWindow(signal.id.uuidString)
            }
        }
    }

    /// Get the actual window template.
    /// - Parameter content: The content view.s
    /// - Returns: The window.
    func getTemplate(content: Body) -> Self {
        var windowTemplate = self
        if let view = content.first as? WindowView {
            windowTemplate = view.window(windowTemplate)
        }
        return windowTemplate
    }

    /// Set some general propreties of the window.
    /// - Parameters:
    ///     - window: The window.
    ///     - template: The window template.
    func setProperties(window: GTUIApplicationWindow, template: Self) {
        if let title = template.title {
            window.setTitle(title)
        }
        window.setResizability(template.resizable)
        window.setDeletability(template.deletable)
        if !(template.maximized?.wrappedValue ?? false) {
            gtk_window_unmaximize(window.pointer)
        } else {
            gtk_window_maximize(window.pointer)
        }
        var storage = window.fields["storage"] as? ViewStorage
        if storage == nil {
            storage = .init(window.pointer?.opaque())
            window.fields["storage"] = storage
        }
        if template.setDefaultSize {
            window.setDefaultSize(width: template.width?.wrappedValue, height: template.height?.wrappedValue)
        }
        if template.width != nil {
            storage?.notify(name: "default-width") {
                updateSize(window: window, template: template)
            }
        }
        if template.height != nil {
            storage?.notify(name: "default-height") {
                updateSize(window: window, template: template)
            }
        }
        if template.maximized != nil {
            storage?.notify(name: "maximized") {
                updateSize(window: window, template: template)
            }
        }
    }

    /// Update the window's size.
    /// - Parameters:
    ///     - window: The window.
    ///     - template: The window template.
    func updateSize(window: GTUIApplicationWindow, template: Self) {
        var width: Int32 = 0
        var height: Int32 = 0
        gtk_window_get_default_size(window.pointer, &width, &height)
        let maximized = gtk_window_is_maximized(window.pointer) != 0
        if width != template.width?.wrappedValue ?? -1 {
            template.width?.wrappedValue = .init(width)
        }
        if height != template.height?.wrappedValue ?? -1 {
            template.height?.wrappedValue = .init(height)
        }
        if maximized != template.maximized?.wrappedValue {
            template.maximized?.wrappedValue = maximized
        }
    }

    /// Add windows that overlay the last instance of this window if presented.
    /// - Parameter windows: The windows.
    /// - Returns: The new windows and this window.
    public func overlay(@SceneBuilder windows: () -> [WindowSceneGroup]) -> [WindowScene] {
        windows().windows().map { window in
            var newWindow = window
            newWindow.parentID = id
            return newWindow
        } + [self]
    }

    /// Add an importer file dialog to the window.
    /// - Parameters:
    ///     - signal: The signal for opening the dialog.
    ///     - initialFolder: The URL to the folder open when being opened.
    ///     - extensions: The accepted file extensions.
    ///     - folders: Whether folders are accepted.
    ///     - onOpen: Run this when a file for importing has been chosen.
    ///     - onClose: Run this when the user cancelled the action.
    public func fileImporter(
        _ signal: Signal,
        initialFolder: URL? = nil,
        extensions: [String]? = nil,
        onOpen: @escaping (URL) -> Void,
        onClose: @escaping () -> Void
    ) -> Scene {
        var newSelf = self
        newSelf.signals.append(signal)
        return newSelf
            .overlay {
                FileDialog(
                    importer: signal.id.uuidString,
                    initialFolder: initialFolder,
                    extensions: extensions,
                    onOpen: onOpen,
                    onClose: onClose
                )
            }
    }

    /// Add an exporter file dialog to the window.
    /// - Parameters:
    ///     - signal: The signal for opening the dialog.
    ///     - initialFolder: The URL to the folder open when being opened.
    ///     - initialName: The default file name.
    ///     - onSave: Run this when a path for exporting has been chosen.
    ///     - onClose: Run this when the user cancelled the action.
    public func fileExporter(
        _ signal: Signal,
        initialFolder: URL? = nil,
        initialName: String? = nil,
        onSave: @escaping (URL) -> Void,
        onClose: @escaping () -> Void
    ) -> Scene {
        var newSelf = self
        newSelf.signals.append(signal)
        return newSelf
            .overlay {
                FileDialog(
                    exporter: signal.id.uuidString,
                    initialFolder: initialFolder,
                    initialName: initialName,
                    onSave: onSave,
                    onClose: onClose
                )
            }
    }

    /// Add a keyboard shortcut.
    /// - Parameters:
    ///     - shortcut: The keyboard shortcut.
    ///     - action: The closure to execute when the keyboard shortcut is pressed.
    /// - Returns: The window.
    public func keyboardShortcut(_ shortcut: String, action: @escaping (GTUIApplicationWindow) -> Void) -> Self {
        var newSelf = self
        newSelf.shortcuts[shortcut] = action
        return newSelf
    }

    /// Update the keyboard shortcuts.
    /// - Parameters: window: The application window.
    func updateShortcuts(window: GTUIApplicationWindow, template: Self) {
        for shortcut in template.shortcuts {
            window.addKeyboardShortcut(shortcut.key, id: shortcut.key) { shortcut.value(window) }
        }
    }

    /// Add the shortcut "<Ctrl>w" which closes the window.
    /// - Returns: The window.
    public func closeShortcut() -> Self {
        keyboardShortcut("w".ctrl()) { $0.close() }
    }

    /// Set the window's default size.
    /// - Parameters:
    ///     - width: The window's width.
    ///     - height: The window's height.
    /// - Returns: The window.
    public func defaultSize(width: Int, height: Int) -> Self {
        var newSelf = self
        newSelf.width = .constant(width)
        newSelf.height = .constant(height)
        newSelf.setDefaultSize = true
        return newSelf
    }

    /// Set the window's title.
    /// - Parameter title: The title.
    /// - Returns: The window.
    public func title(_ title: String) -> Self {
        var newSelf = self
        newSelf.title = title
        return newSelf
    }

    /// Set whether the window is resizable.
    /// - Parameter resizable: The resizability.
    /// - Returns: The window.
    public func resizable(_ resizable: Bool) -> Self {
        var newSelf = self
        newSelf.resizable = resizable
        return newSelf
    }

    /// Set whether the window is deletable.
    /// - Parameter resizable: The deletability.
    /// - Returns: The window.
    public func deletable(_ deletable: Bool) -> Self {
        var newSelf = self
        newSelf.deletable = deletable
        return newSelf
    }

    /// Get the window's width and height.
    /// - Parameters:
    ///     - width: The window's actual width.
    ///     - height: The window's actual height.
    /// - Returns: The window.
    public func size(width: Binding<Int>? = nil, height: Binding<Int>? = nil) -> Self {
        var newSelf = self
        newSelf.width = width
        newSelf.height = height
        return newSelf
    }

    /// Get and set whether the window is maximized.
    /// - Parameter maximized: Whether the window is maximized.
    /// - Returns: The window.
    public func maximized(_ maximized: Binding<Bool>) -> Self {
        var newSelf = self
        newSelf.maximized = maximized
        return newSelf
    }

}

// swiftlint:enable discouraged_optional_collection
