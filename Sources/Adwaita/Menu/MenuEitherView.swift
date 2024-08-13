//
//  MenuEitherView.swift
//  Adwaita
//
//  Created by david-swift on 06.08.2024.
//

/// Show one of two views depending on a condition.
public struct MenuEitherView: Meta.EitherView, SimpleView {

    /// The view.
    public var view: Body

    /// Initialize an either view.
    /// - Parameters:
    ///     - condition: The condition.
    ///     - view1: The first view.
    ///     - view2: The second view.
    public init(_ condition: Bool, view1: () -> Body, else view2: () -> Body) {
        self.view = condition ? view1() : view2()
    }

}
