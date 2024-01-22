//
//  MenuButton.swift
//  Adwaita
//
//  Created by david-swift on 22.10.23.
//

import CAdw

/// A button widget for menus.
public struct MenuButton: MenuItem {

    /// The button's label.
    var label: String
    /// The button's action handler.
    var handler: () -> Void
    /// The keyboard shortcut.
    var shortcut = ""
    /// Whether to prefer adding the action to the application window.
    var preferApplicationWindow: Bool

    /// The action label.
    var filteredLabel: String { label.filter { $0.isLetter || $0.isNumber || $0 == "-" || $0 == "." } }

    /// Initialize a menu button.
    /// - Parameters:
    ///   - label: The buttons label.
    ///   - window: Whether to prefer adding the action to the application window.
    ///   - handler: The button's action handler.
    public init(_ label: String, window: Bool = true, handler: @escaping () -> Void) {
        self.label = label
        preferApplicationWindow = window
        self.handler = handler
    }

    /// Add the button to a menu.
    /// - Parameters:
    ///   - menu: The menu.
    ///   - app: The application containing the menu.
    ///   - window: The application window containing the menu.
    public func addMenuItem(menu: OpaquePointer?, app: GTUIApp, window: GTUIApplicationWindow?) {
        if let window, preferApplicationWindow {
            window.addKeyboardShortcut(shortcut, id: filteredLabel, handler: handler)
            g_menu_append(menu, label, "win." + filteredLabel)
        } else {
            app.addKeyboardShortcut(shortcut, id: filteredLabel, handler: handler)
            g_menu_append(menu, label, "app." + filteredLabel)
        }
    }

    /// Create a keyboard shortcut for an application from a button.
    ///
    /// Note that the keyboard shortcut is available after the view has been visible for the first time.
    /// - Parameters:
    ///     - shortcut: The keyboard shortcut.
    /// - Returns: The button.
    public func keyboardShortcut(_ shortcut: String) -> Self {
        var newSelf = self
        newSelf.shortcut = shortcut
        return newSelf
    }

}
