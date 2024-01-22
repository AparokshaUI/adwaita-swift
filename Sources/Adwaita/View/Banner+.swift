//
//  Banner+.swift
//  Adwaita
//
//  Created by david-swift on 17.01.24.
//

import CAdw

extension Banner {

    /// Initialize a text widget.
    /// - Parameters:
    ///     - title: The content.
    ///     - visible: Whether the banner is visible.
    public init(_ title: String, visible: Bool) {
        self.init(title: title)
        self = self.revealed(visible)
    }

    /// Configure the banner's button.
    /// - Parameters:
    ///     - label: The button's title.
    ///     - handler: The button's handler.
    /// - Returns: The banner.
    public func button(_ label: String, handler: @escaping () -> Void) -> Self {
        buttonLabel(label)
            .buttonClicked {
                handler()
            }
    }

}
