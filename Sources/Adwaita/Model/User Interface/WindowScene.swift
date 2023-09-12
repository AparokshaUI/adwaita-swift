//
//  WindowScene.swift
//  Adwaita
//
//  Created by david-swift on 05.08.23.
//

import GTUI

/// A structure conforming to `WindowScene` can be added to an app's `scene`.
public protocol WindowScene: View { }

/// `Scene` is an array of windows.
public typealias Scene = [WindowScene]
/// A builder for the `Scene`
public typealias SceneBuilder = ArrayBuilder<WindowScene>
