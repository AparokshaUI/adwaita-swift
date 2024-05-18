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
    /// Whether the linked style should be used.
    var linked = false

    /// The view's body.
    public var view: Body {
        VStack(horizontal: true, content: content)
            .linked(linked)
    }

    /// Initialize a `HStack`.
    /// - Parameter content: The view content.
    public init(@ViewBuilder content: @escaping () -> Body) {
        self.content = content
    }

    /// Link the children.
    public func linked(_ active: Bool = true) -> Self {
        var newSelf = self
        newSelf.linked = active
        return newSelf
    }

}
