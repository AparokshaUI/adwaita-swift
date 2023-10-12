//
//  WindowSceneGroup.swift
//  Adwaita
//
//  Created by david-swift on 14.09.23.
//

/// A structure conforming to `WindowScene` can be added to an app's `scene`.
public protocol WindowSceneGroup {

    /// The group's content.
    @SceneBuilder var scene: Scene { get }

}

extension WindowSceneGroup {

    /// Get the windows described by the group.
    /// - Returns: The windows.
    func windows() -> [WindowScene] {
        var content: [WindowScene] = []
        for element in scene {
            if let window = element as? WindowScene {
                content.append(window)
            } else {
                content += element.windows()
            }
        }
        return content
    }

    /// Update the windows described by the group.
    /// - Parameter storage: The window's storage.
    func update(_ storage: [WindowStorage]) {
        for (index, window) in windows().enumerated() {
            if let storage = storage[safe: index] {
                window.update(storage)
            }
        }
    }

}

/// `Scene` is an array of windows.
public typealias Scene = [WindowSceneGroup]
/// A builder for the `Scene`
public typealias SceneBuilder = ArrayBuilder<WindowSceneGroup>
