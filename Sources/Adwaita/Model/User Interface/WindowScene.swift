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
    /// Get the storage for the window.
    /// - Parameter app: The application.
    /// - Returns: The storage.
    func createWindow(app: GTUIApp) -> WindowStorage
    /// Update a window storage's content.
    /// - Parameter storage: The storage to update.
    func update(_ storage: WindowStorage)

}

extension WindowScene {

    /// The window scene's body is itself.
    @SceneBuilder public var scene: Scene { self }

}
