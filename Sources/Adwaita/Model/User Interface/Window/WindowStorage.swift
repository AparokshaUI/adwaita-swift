//
//  SceneStorage.swift
//  Adwaita
//
//  Created by david-swift on 31.08.23.
//

import GTUI

/// A storage for an app's window.
public class WindowStorage {

    /// The window's identifier.
    public var id: String
    /// The identifier of the window's parent window.
    public var parentID: String?
    /// Whether the reference to the window should disappear in the next update.
    public var destroy = false
    /// The GTUI window.
    public var window: GTUIWindow
    /// The content's storage.
    public var view: ViewStorage

    /// Initialize a window storage.
    /// - Parameters:
    ///   - id: The window's identifier.
    ///   - window: The GTUI window.
    ///   - view: The content's storage.
    public init(id: String, window: GTUIWindow, view: ViewStorage) {
        self.id = id
        self.window = window
        self.view = view
    }

}
