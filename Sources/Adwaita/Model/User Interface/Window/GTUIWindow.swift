//
//  GTUIWindow.swift
//  Adwaita
//
//  Created by david-swift on 12.10.23.
//

import Libadwaita

/// A GTUI window.
public typealias GTUIWindow = Libadwaita.Window

extension GTUIWindow: WindowType {

    /// Set the window's parent window.
    /// - Parameter parent: The parent window.
    public func setParentWindow(_ parent: WindowType) {
        if let window = parent as? GTUIWindow {
            self.setParent(window)
        }
    }

}
