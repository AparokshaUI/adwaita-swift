//
//  SceneStorage.swift
//  Adwaita
//
//  Created by david-swift on 31.08.23.
//

import GTUI

/// A storage for an app's window.
class WindowStorage {

    /// The GTUI window.
    var window: Window
    /// The content's storage.
    var view: ViewStorage

    /// Initialize a window storage.
    /// - Parameters:
    ///   - window: The GTUI window.
    ///   - view: The content's storage.
    init(window: Window, view: ViewStorage) {
        self.window = window
        self.view = view
    }

}
