//
//  CheckButton+.swift
//  Adwaita
//
//  Created by david-swift on 18.05.24.
//

/// A button widget.
extension CheckButton {

    /// Apply the selection mode style class.
    /// - Parameter active: Whether it is applied.
    /// - Returns: A view.
    public func selectionMode(_ active: Bool = true) -> AnyView {
        style("selection-mode", active: active)
    }

}
