//
//  View+.swift
//  Adwaita
//
//  Created by david-swift on 03.01.24.
//

extension View {

    /// Wrap the view in a vertical stack and center vertically.
    /// - Returns: The view.
    public func verticalCenter() -> View {
        VStack { self }
            .valign(.center)
    }

    /// Wrap the view in a horizontal stack and center horizontally.
    /// - Returns: The view.
    public func horizontalCenter() -> View {
        HStack { self }
            .halign(.center)
    }

}
