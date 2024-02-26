//
//  WindowView.swift
//  Adwaita
//
//  Created by david-swift on 26.02.24.
//

/// A special view that can access the window of the current instance
/// if located as the first view directly inside a window.
public protocol WindowView: View {

    /// Modify the window.
    /// - Parameter window: The window.
    /// - Returns: The window.
    func window(_ window: Window) -> Window

}
