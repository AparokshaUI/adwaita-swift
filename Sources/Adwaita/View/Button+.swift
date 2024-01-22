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
    /// - Returns: The button.
    public func keyboardShortcut(_ shortcut: String, window: GTUIApplicationWindow) -> Self {
        window.addKeyboardShortcut(shortcut, id: shortcut) { self.clicked?() }
        return self
    }

    /// Create a keyboard shortcut for an application from a button.
    ///
    /// Note that the keyboard shortcut is available after the view has been visible for the first time.
    /// - Parameters:
    ///     - shortcut: The keyboard shortcut.
    ///     - window: The application.
    /// - Returns: The button.
    public func keyboardShortcut(_ shortcut: String, app: GTUIApp) -> Self {
        app.addKeyboardShortcut(shortcut, id: shortcut) { self.clicked?() }
        return self
    }

}
