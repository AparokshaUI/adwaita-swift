//
//  Window.swift
//  Adwaita
//
//  Created by david-swift on 14.09.23.
//

import GTUI

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
    /// The keyboard shortcuts.
    var shortcuts: [String: (GTUIApplicationWindow) -> Void] = [:]
    /// The keyboard shortcuts on the app level.
    public var appShortcuts: [String: (GTUIApp) -> Void] = [:]

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
            return false
        }
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
        let storage = content.widget().container()
        window.setChild(storage.view)
        updateShortcuts(window: window)
        return storage
    }

    /// Update a window storage's content.
    /// - Parameter storage: The storage to update.
    public func update(_ storage: WindowStorage, app: GTUIApp) {
        if let window = storage.window as? GTUIApplicationWindow {
            let content = content(window)
            content.widget().updateStorage(storage.view)
            updateShortcuts(window: window)
            updateAppShortcuts(app: app)
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
    /// - Parameter window: The application window.
    func updateShortcuts(window: GTUIApplicationWindow) {
        for shortcut in shortcuts {
            window.addKeyboardShortcut(shortcut.key, id: shortcut.key) { shortcut.value(window) }
        }
    }

    /// Add the shortcut "<Ctrl>w" which closes the window.
    /// - Returns: The window.
    public func closeShortcut() -> Self {
        keyboardShortcut("w".ctrl()) { $0.close() }
    }

}
