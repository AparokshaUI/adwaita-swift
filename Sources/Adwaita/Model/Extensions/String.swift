//
//  String.swift
//  Adwaita
//
//  Created by david-swift on 09.09.23.
//

extension String {

    /// A label for main content in a view storage.
    static var mainContent: Self { "main" }
    /// A label for the transition data in a GTUI widget's fields.
    static var transition: Self { "transition" }
    /// A label for the navigation label in a GTUI widget's fields.
    static var navigationLabel: Self { "navigation-label" }

    /// Add the Ctrl key to a shortcut.
    /// - Returns: The shortcut.
    public func ctrl() -> String { "<Ctrl>\(self)" }

    /// Add the Shift key to a shortcut.
    /// - Returns: The shortcut.
    public func shift() -> String { "<Shift>\(self)" }

    /// Add the Alt key to a shortcut.
    /// - Returns: The shortcut.
    public func alt() -> String { "<Alt>\(self)" }

    /// Add the Meta key to a shortcut.
    /// - Returns: The shortcut.
    public func meta() -> String { "<Meta>\(self)" }

    /// Add the Super key to a shortcut.
    /// - Returns: The shortcut.
    public func `super`() -> String { "<Super>\(self)" }

    /// Add the Hyper key to a shortcut.
    /// - Returns: The shortcut.
    public func hyper() -> String { "<Hyper>\(self)" }

}
