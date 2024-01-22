//
//  SwitchRow+.swift
//  Adwaita
//
//  Created by david-swift on 20.01.24.
//

/// A row representing a boolean state.
extension SwitchRow {

    /// Initialize a switch row.
    /// - Parameters:
    ///     - title: The row's title.
    ///     - isOn: Whether the switch is on.
    public init(_ title: String, isOn: Binding<Bool>) {
        self.init()
        self = self.title(title)
        self = self.active(isOn)
    }

}
