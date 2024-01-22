//
//  HStack.swift
//  Adwaita
//
//  Created by david-swift on 26.09.23.
//

/// A horizontal GtkBox equivalent.
public struct HStack: View {

    /// The content.
    var content: () -> Body

    /// The view's body.
    public var view: Body {
        VStack(horizontal: true, content: content)
    }

    /// Initialize a `HStack`.
    /// - Parameter content: The view content.
    public init(@ViewBuilder content: @escaping () -> Body) {
        self.content = content
    }

}
