//
//  Menu+.swift
//  Adwaita
//
//  Created by david-swift on 21.10.23.
//

import CAdw

// An extension
extension Menu {

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
        @MenuBuilder content: @escaping () -> MenuContent
    ) {
        self.init()
        self = self
            .child {
                ButtonContent()
                    .iconName(icon.string)
                    .label(label)
            }
            .menuModel(app: app, window: window, content)
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
        self.init()
    }

}
