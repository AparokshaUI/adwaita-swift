//
//  WindowScene.swift
//  Adwaita
//
//  Created by david-swift on 05.08.23.
//

import GTUI

/// A structure representing the content for a certain window type.
public protocol WindowScene: WindowSceneGroup {

    /// The window type's identifier.
    var id: String { get }
    /// The number of instances of the window at the startup.
    var `open`: Int { get }
    /// The keyboard shortcuts on the application's level.
    var appShortcuts: [String: (GTUIApp) -> Void] { get set }
    /// Get the storage for the window.
    /// - Parameter app: The application.
    /// - Returns: The storage.
    func createWindow(app: GTUIApp) -> WindowStorage
    /// Update a window storage's content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - app: The application.
    func update(_ storage: WindowStorage, app: GTUIApp)

}

extension WindowScene {

    /// The window scene's body is itself.
    @SceneBuilder public var scene: Scene { self }

    /// Add a keyboard shortcut that is available for the whole app.
    /// - Parameters:
    ///     - shortcut: The keyboard shortcut.
    ///     - The closure to execute.
    public func appKeyboardShortcut(_ shortcut: String, action: @escaping (GTUIApp) -> Void) -> Self {
        var newSelf = self
        newSelf.appShortcuts[shortcut] = action
        return newSelf
    }

    /// Update the app shortcuts.
    ///
    /// Call this function in types of window scene.
    public func updateAppShortcuts(app: GTUIApp) {
        for shortcut in appShortcuts {
            app.addKeyboardShortcut(shortcut.key, id: shortcut.key) { shortcut.value(app) }
        }
    }

    /// Add the shortcut "<Ctrl>q" which terminates the application.
    /// - Returns: The app.
    public func quitShortcut() -> Self {
        appKeyboardShortcut("q".ctrl()) { $0.quit() }
    }

}
