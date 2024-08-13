//
//  Button+.swift
//  Adwaita
//
//  Created by david-swift on 15.01.24.
//

import CAdw

/// A button widget.
extension Button {

    // swiftlint:disable function_default_parameter_at_end
    /// Initialize a button.
    /// - Parameters:
    ///   - label: The button's label.
    ///   - icon: The button's icon.
    ///   - handler: The button's action handler.
    public init(_ label: String? = nil, icon: Icon, handler: @escaping () -> Void) {
        self.init()
        self = self.child {
            ButtonContent()
                .label(label)
                .iconName(icon.string)
        }
        self = self.clicked(handler)
    }
    // swiftlint:enable function_default_parameter_at_end

    /// Initialize a button.
    /// - Parameters:
    ///   - label: The buttons label.
    ///   - handler: The button's action handler.
    public init(_ label: String, handler: @escaping () -> Void) {
        self.init()
        self = self.label(label)
        self = self.clicked(handler)
    }

    /// Create a keyboard shortcut for an application window from a button.
    ///
    /// Note that the keyboard shortcut is available after the view has been visible for the first time.
    /// - Parameters:
    ///     - shortcut: The keyboard shortcut.
    ///     - window: The application window.
    ///     - active: Whether the keyboard shortcut is active.
    /// - Returns: The button.
    public func keyboardShortcut(_ shortcut: String, window: AdwaitaWindow, active: Bool = true) -> AnyView {
        onUpdate {
            if active {
                window.app.addKeyboardShortcut(shortcut, id: shortcut, window: window) { self.clicked?() }
            } else {
                window.app.removeKeyboardShortcut(id: shortcut, window: window)
            }
        }
    }

    /// Create a keyboard shortcut for an application from a button.
    ///
    /// Note that the keyboard shortcut is available after the view has been visible for the first time.
    /// - Parameters:
    ///     - shortcut: The keyboard shortcut.
    ///     - window: The application.
    ///     - active: Whether the keyboard shortcut is active.
    /// - Returns: The button.
    public func keyboardShortcut(_ shortcut: String, app: AdwaitaApp, active: Bool = true) -> AnyView {
        onUpdate {
            if active {
                app.addKeyboardShortcut(shortcut, id: shortcut) { self.clicked?() }
            } else {
                app.removeKeyboardShortcut(id: shortcut)
            }
        }
    }

}
