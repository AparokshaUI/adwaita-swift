//
//  GTUIWindowRepresentable.swift
//  Adwaita
//
//  Created by david-swift on 09.12.23.
//

/// A window type.
public protocol WindowType {

    /// A dictionary for custom data.
    var fields: [String: Any] { get set }
    /// Set a parent window.
    /// - Parameter parent: The parent window.
    func setParentWindow(_ parent: WindowType)
    /// Show the window.
    func show()

}
