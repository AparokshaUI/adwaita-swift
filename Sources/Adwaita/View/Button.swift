//
//  Button.swift
//  Adwaita
//
//  Created by david-swift on 10.09.23.
//

import GTUI

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
    /// - Parameter storage: The view storage.
    public func update(_ storage: ViewStorage) {
        if let button = storage.view as? GTUI.Button {
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
    /// - Returns: The button's view storage.
    public func container() -> ViewStorage {
        if let icon {
            return .init(GTUI.Button(label, icon: icon).handler(handler))
        } else {
            return .init(GTUI.Button(label ?? .init()).handler(handler))
        }
    }

}
