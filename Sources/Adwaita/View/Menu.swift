//
//  Menu.swift
//  Adwaita
//
//  Created by david-swift on 21.10.23.
//

import Libadwaita

/// A menu button widget.
public struct Menu: Widget {

    /// The button's label.
    var label: String?
    /// The button's icon.
    var icon: Icon?
    /// The menu's content.
    var content: MenuContent
    /// The application.
    var app: GTUIApp
    /// The window.
    var window: GTUIApplicationWindow?

    // swiftlint:disable function_default_parameter_at_end
    /// Initialize a menu button.
    /// - Parameters:
    ///   - label: The button's label.
    ///   - icon: The button's icon.
    ///   - app: The application.
    ///   - window: The application window.
    ///   - content: The menu's content.
    public init(
        _ label: String? = nil,
        icon: Icon,
        app: GTUIApp,
        window: GTUIApplicationWindow?,
        @MenuBuilder content: () -> MenuContent
    ) {
        self.label = label
        self.icon = icon
        self.app = app
        self.window = window
        self.content = content()
    }
    // swiftlint:enable function_default_parameter_at_end

    /// Initialize a menu button.
    /// - Parameters:
    ///   - label: The buttons label.
    ///   - app: The application.
    ///   - window: The application window.
    ///   - content: The menu's content.
    public init(
        _ label: String,
        app: GTUIApp,
        window: GTUIApplicationWindow?,
        @MenuBuilder content: () -> MenuContent
    ) {
        self.label = label
        self.app = app
        self.window = window
        self.content = content()
    }

    /// Update a button's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let button = storage.view as? Libadwaita.MenuButton {
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
        let button: Libadwaita.MenuButton
        if let icon {
            button = .init(label, icon: icon)
        } else {
            button = .init(label ?? .init())
        }
        for element in content {
            element.addMenuItems(menu: button.getMenu(), app: app, window: window)
        }
        return .init(button)
    }

}
