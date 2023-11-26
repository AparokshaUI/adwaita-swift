//
//  Button.swift
//  Adwaita
//
//  Created by david-swift on 10.09.23.
//

import Libadwaita

/// A button widget.
public struct Button: Widget {

    /// The button's label.
    var label: String?
    /// The button's icon.
    var icon: Icon?
    /// The button's action handler.
    var handler: () -> Void

    // swiftlint:disable function_default_parameter_at_end
    /// Initialize a button.
    /// - Parameters:
    ///   - label: The button's label.
    ///   - icon: The button's icon.
    ///   - handler: The button's action handler.
    public init(_ label: String? = nil, icon: Icon, handler: @escaping () -> Void) {
        self.label = label
        self.icon = icon
        self.handler = handler
    }
    // swiftlint:enable function_default_parameter_at_end

    /// Initialize a button.
    /// - Parameters:
    ///   - label: The buttons label.
    ///   - handler: The button's action handler.
    public init(_ label: String, handler: @escaping () -> Void) {
        self.label = label
        self.handler = handler
    }

    /// Update a button's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let button = storage.view as? Libadwaita.Button {
            let content = button.getContent()
            if let label {
                if icon == nil {
                  button.setLabel(label)
                } else {
                  content?.setLabel(label)
                }
            }
            if let icon {
                content?.setIcon(icon)
            }
        }
    }

    /// Get a button's view storage.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The button's view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        if let icon {
            return .init(Libadwaita.Button(label, icon: icon).handler(handler))
        } else {
            return .init(Libadwaita.Button(label ?? .init()).handler(handler))
        }
    }

    /// Create a keyboard shortcut for an application window from a button.
    ///
    /// Note that the keyboard shortcut is available after the view has been visible for the first time.
    /// - Parameters:
    ///     - shortcut: The keyboard shortcut.
    ///     - window: The application window.
    /// - Returns: The button.
    public func keyboardShortcut(_ shortcut: String, window: GTUIApplicationWindow) -> Self {
        window.addKeyboardShortcut(shortcut, id: shortcut, handler: handler)
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
        app.addKeyboardShortcut(shortcut, id: shortcut, handler: handler)
        return self
    }

}
