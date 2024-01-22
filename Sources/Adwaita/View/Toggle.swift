//
//  Toggle.swift
//  Adwaita
//
//  Created by david-swift on 19.12.23.
//

/// A toggle button widget.
public typealias Toggle = ToggleButton

/// A toggle button widget.
extension Toggle {

    // swiftlint:disable function_default_parameter_at_end
    /// Initialize a toggle button.
    /// - Parameters:
    ///   - label: The button's label.
    ///   - icon: The button's icon.
    ///   - isOn: Whether the toggle is on.
    public init(_ label: String? = nil, icon: Icon? = nil, isOn: Binding<Bool>) {
        self = self.child {
            ButtonContent()
                .label(label)
                .iconName(icon?.string)
        }
        self.active = isOn
    }
    // swiftlint:enable function_default_parameter_at_end

    /// Initialize a toggle button.
    /// - Parameters:
    ///   - label: The buttons label.
    ///   - isOn: Whether the toggle is on.
    public init(_ label: String, isOn: Binding<Bool>) {
        self.label = label
        self.active = isOn
    }

    /// Use the check button style.
    /// - Returns: The toggle.
    public func checkButton() -> CheckButton {
        if let child {
            return .init()
                .active(active)
                .child(child)
        } else {
            return .init()
                .active(active)
                .label(label)
        }
    }

}
