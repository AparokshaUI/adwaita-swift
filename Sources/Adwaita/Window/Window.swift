//
//  Window.swift
//  Adwaita
//
//  Created by david-swift on 14.09.23.
//

import GTUI

/// A structure representing a simple window type.
///
/// Note that multiple instances of a window can be opened at the same time.
public struct Window: WindowScene {

    /// The window's identifier.
    public var id: String
    /// The window's content.
    var content: (GTUI.Window) -> Body
    /// Whether an instance of the window type should be opened when the app is starting up.
    public var `open`: Int

    /// Create a window type with a certain identifier and user interface.
    /// - Parameters:
    ///   - id: The identifier.
    ///   - open: The number of instances of the window type when the app is starting.
    ///   - content: The window's content.
    public init(id: String, `open`: Int = 1, @ViewBuilder content: @escaping (GTUI.Window) -> Body) {
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
    func createGTUIWindow(app: GTUIApp) -> GTUI.Window {
        let window = GTUI.Window(app: app)
        window.show()
        return window
    }

    /// Get the storage of the content view.
    /// - Parameter window: The window.
    /// - Returns: The storage of the content of the window.
    func getViewStorage(window: GTUI.Window) -> ViewStorage {
        let storage = content(window).widget().container()
        window.setChild(storage.view)
        return storage
    }

    /// Update a window storage's content.
    /// - Parameter storage: The storage to update.
    public func update(_ storage: WindowStorage) {
        content(storage.window).widget().updateStorage(storage.view)
    }

}
