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
/// Note that it may be possible to open multiple instances of a window at the same time.
public struct Window: AdwaitaSceneElement {

    /// The window's identifier.
    public var id: String
    /// The window's content.
    var content: (AdwaitaWindow) -> Body
    /// Whether an instance of the window type should be opened when the app is starting up.
    var `open`: Int
    /// The keyboard shortcuts.
    var shortcuts: [String: (AdwaitaWindow) -> Void] = [:]
    /// The keyboard shortcuts on the app level.
    var appShortcuts: [String: (AdwaitaApp) -> Void] = [:]
    /// The window's title.
    var title: String?
    /// Whether the window is resizable.
    var resizable: Bool?
    /// Whether the window is deletable.
    var deletable: Bool?
    /// The binding for the window's width.
    var width: Binding<Int>?
    /// The binding for the window's height.
    var height: Binding<Int>?
    /// The window's default width.
    var defaultWidth: Int?
    /// The window's default height.
    var defaultHeight: Int?
    /// Whether the window is maximized.
    var maximized: Binding<Bool>?
    /// Whether the window uses the development style.
    var devel: Bool?

    /// Create a window type with a certain identifier and user interface.
    /// - Parameters:
    ///   - id: The identifier.
    ///   - open: The number of instances of the window type when the app is starting.
    ///   - content: The window's content.
    public init(id: String, `open`: Int = 1, @ViewBuilder content: @escaping (AdwaitaWindow) -> Body) {
        self.content = content
        self.id = id
        self.open = open
    }

    /// An AdwApplicationWindow.
    public class AdwaitaWindow {

        /// The pointer to the window.
        let pointer: UnsafeMutablePointer<AdwApplicationWindow>?
        /// Fields for storing signal data.
        var signals: [String: SignalData] = [:]
        /// The App.
        let app: AdwaitaApp

        /// Initialize the application window.
        /// - Parameter app: The application.
        init(app: AdwaitaApp) {
            self.app = app
            pointer = adw_application_window_new(app.pointer)?.cast()
        }

        /// Close the window.
        public func close() {
            gtk_window_close(pointer?.cast())
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

    /// Set up the initial scene storages.
    /// - Parameter app: The app storage.
    public func setupInitialContainers<Storage>(app: Storage) where Storage: AppStorage {
        for _ in 0..<open {
            let container = container(app: app)
            container.show()
            app.storage.sceneStorage.append(container)
        }
    }

    /// The scene storage.
    /// - Parameter app: The app storage.
    public func container<Storage>(app: Storage) -> SceneStorage where Storage: AppStorage {
        guard let app = app as? AdwaitaApp else {
            return .init(id: id, pointer: nil) { }
        }
        let window = AdwaitaWindow(app: app)
        let content = content(window)
        let storage = SceneStorage(id: id, pointer: window) {
            gtk_window_present(window.pointer?.cast())
        }
        let viewStorage = content.storage(modifiers: [], type: AdwaitaMainView.self)
        adw_application_window_set_content(window.pointer?.cast(), viewStorage.opaquePointer?.cast())
        storage.content[.mainContent] = [viewStorage]
        let data = SignalData {
            storage.destroy = true
        }
        let observeID = "destroy"
        data.connect(pointer: window.pointer, signal: observeID)
        window.signals[observeID] = data
        let template = getTemplate(content: content)
        let width = template.width?.wrappedValue ?? template.defaultWidth ?? -1
        let height = template.height?.wrappedValue ?? template.defaultHeight ?? -1
        gtk_window_set_default_size(window.pointer?.cast(), .init(width), .init(height))
        update(storage, app: app, updateProperties: true)
        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - app: The app storage.
    ///     - updateProperties: Whether to update the view's properties.
    public func update<Storage>(
        _ storage: SceneStorage,
        app: Storage,
        updateProperties: Bool
    ) where Storage: AppStorage {
        if Thread.isMainThread {
            privateUpdate(storage, app: app, updateProperties: updateProperties)
        } else {
            Idle {
                privateUpdate(storage, app: app, updateProperties: updateProperties)
            }
        }
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - app: The app storage.
    ///     - updateProperties: Whether to update the view's properties.
    private func privateUpdate<Storage>(
        _ storage: SceneStorage,
        app: Storage,
        updateProperties: Bool
    ) where Storage: AppStorage {
        guard let window = storage.pointer as? AdwaitaWindow,
              let viewStorage = storage.content[.mainContent]?.first else {
            return
        }
        let content = content(window)
        content
            .updateStorage(viewStorage, modifiers: [], updateProperties: updateProperties, type: AdwaitaMainView.self)
        let template = getTemplate(content: content)
        if let app = app as? AdwaitaApp {
            for shortcut in template.shortcuts {
                app.addKeyboardShortcut(shortcut.key, id: shortcut.key, window: window) { shortcut.value(window) }
            }
            for shortcut in template.appShortcuts {
                app.addKeyboardShortcut(shortcut.key, id: shortcut.key) { shortcut.value(app) }
            }
        }
        if template.width != nil {
            storage.notify(name: "default-width", pointer: window.pointer?.opaque()) {
                template.width?.wrappedValue = getDefaultSize(window: window).width
            }
        }
        if template.height != nil {
            storage.notify(name: "default-height", pointer: window.pointer?.opaque()) {
                template.height?.wrappedValue = getDefaultSize(window: window).height
            }
        }
        if template.maximized != nil {
            storage.notify(name: "maximized", pointer: window.pointer?.opaque()) {
                template.maximized?.wrappedValue = gtk_window_is_maximized(window.pointer?.cast()) != 0
            }
        }
        if updateProperties {
            template.updateProperties(storage: storage, window: window)
        }
    }

    /// Update the properties of the windows.
    /// - Parameters:
    ///     - storage: The scene storage.
    ///     - window: The window.
    func updateProperties(storage: SceneStorage, window: AdwaitaWindow) {
        let previousState = storage.previousState as? Self
        if let title, previousState?.title != title {
            gtk_window_set_title(window.pointer?.cast(), title)
        }
        if let resizable, previousState?.resizable != resizable {
            gtk_window_set_resizable(window.pointer?.cast(), resizable.cBool)
        }
        if let deletable, previousState?.deletable != deletable {
            gtk_window_set_deletable(window.pointer?.cast(), deletable.cBool)
        }
        if let devel, previousState?.devel != devel {
            if devel {
                gtk_widget_add_css_class(window.pointer?.cast(), "devel")
            } else {
                gtk_widget_remove_css_class(window.pointer?.cast(), "devel")
            }
        }
        if width != nil || height != nil {
            gtk_window_set_default_size(
                window.pointer?.cast(),
                .init(width?.wrappedValue ?? -1),
                .init(height?.wrappedValue ?? -1)
            )
        }
        if let maximized = maximized?.wrappedValue {
            if maximized {
                gtk_window_maximize(window.pointer?.cast())
            } else {
                gtk_window_unmaximize(window.pointer?.cast())
            }
        }
        storage.previousState = self
    }

    /// Get the window's default size.
    /// - Parameter window: The window.
    /// - Returns: The dimensions.
    func getDefaultSize(window: AdwaitaWindow) -> (width: Int, height: Int) {
        var width: Int32 = 0
        var height: Int32 = 0
        gtk_window_get_default_size(window.pointer?.cast(), &width, &height)
        return (width: .init(width), height: .init(height))
    }

    /// Add a keyboard shortcut.
    /// - Parameters:
    ///     - shortcut: The keyboard shortcut.
    ///     - action: The closure to execute when the keyboard shortcut is pressed.
    /// - Returns: The window.
    public func keyboardShortcut(_ shortcut: String, action: @escaping (AdwaitaWindow) -> Void) -> Self {
        var newSelf = self
        newSelf.shortcuts[shortcut] = action
        return newSelf
    }

    /// Add the shortcut "<Ctrl>w" which closes the window.
    /// - Returns: The window.
    public func closeShortcut() -> Self {
        keyboardShortcut("w".ctrl()) { $0.close() }
    }

    /// Add a keyboard shortcut for the whole application.
    /// - Parameters:
    ///     - shortcut: The keyboard shortcut.
    ///     - action: The closure to execute when the keyboard shortcut is pressed.
    /// - Returns: The window.
    public func appKeyboardShortcut(_ shortcut: String, action: @escaping (AdwaitaApp) -> Void) -> Self {
        var newSelf = self
        newSelf.appShortcuts[shortcut] = action
        return newSelf
    }

    /// Add the shortcut "<Ctrl>q" which quits the application.
    /// - Returns: The window.
    public func quitShortcut() -> Self {
        appKeyboardShortcut("q".ctrl()) { $0.quit() }
    }

    /// Set the window's default size.
    /// - Parameters:
    ///     - width: The window's width.
    ///     - height: The window's height.
    /// - Returns: The window.
    public func defaultSize(width: Int? = nil, height: Int? = nil) -> Self {
        var newSelf = self
        newSelf.defaultWidth = width
        newSelf.defaultHeight = height
        return newSelf
    }

    /// Set the window's title.
    /// - Parameter title: The title.
    /// - Returns: The window.
    public func title(_ title: String?) -> Self {
        var newSelf = self
        newSelf.title = title
        return newSelf
    }

    /// Set whether the window is resizable.
    /// - Parameter resizable: The resizability.
    /// - Returns: The window.
    public func resizable(_ resizable: Bool?) -> Self {
        var newSelf = self
        newSelf.resizable = resizable
        return newSelf
    }

    /// Set whether the window is deletable.
    /// - Parameter resizable: The deletability.
    /// - Returns: The window.
    public func deletable(_ deletable: Bool?) -> Self {
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
    public func maximized(_ maximized: Binding<Bool>?) -> Self {
        var newSelf = self
        newSelf.maximized = maximized
        return newSelf
    }

    /// Whether the window used the development style.
    /// - Parameter active: Whether the style is active.
    /// - Returns: The window.
    public func devel(_ active: Bool? = true) -> Self {
        var newSelf = self
        newSelf.devel = active
        return newSelf
    }

}

// swiftlint:enable discouraged_optional_collection

/// An AdwApplicationWindow.
public typealias AdwaitaWindow = Window.AdwaitaWindow
