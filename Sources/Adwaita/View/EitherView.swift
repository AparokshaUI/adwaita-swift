//
//  ViewStack.swift
//  Adwaita
//
//  Created by david-swift on 30.12.23.
//

import CAdw

/// A widget showing one of two widgets based on a condition.
public struct EitherView: SimpleView, Meta.EitherView {

    /// Whether the first view is visible.
    var condition: Bool
    /// The first view.
    var view1: Body
    /// The second view.
    var view2: Body

    /// The view's content.
    public var view: Body {
        if condition {
            return [ViewStack(id: true) { _ in view1 }.homogeneous(false)]
        } else {
            return [ViewStack(id: false) { _ in view2 }.homogeneous(false)]
        }
    }

    /// Initialize the either view.
    /// - Parameters:
    ///     - condition: Whether the first view is visible-
    ///     - view1: The first view, visible if true.
    ///     - view2: The second view, visible if false.
    public init(
        _ condition: Bool,
        @ViewBuilder view1: () -> Body,
        @ViewBuilder else view2: () -> Body
    ) {
        self.condition = condition
        self.view1 = view1()
        self.view2 = view2()
    }

}
