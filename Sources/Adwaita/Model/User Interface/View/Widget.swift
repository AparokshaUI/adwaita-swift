//
//  Widget.swift
//  Adwaita
//
//  Created by david-swift on 16.08.23.
//

import GTUI

/// A widget is a view that know about its GTUI widget.
public protocol Widget: View {

    /// The view storage.
    /// - Parameter modifiers: Modify views before being updated.
    func container(modifiers: [(View) -> View]) -> ViewStorage
    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    func update(_ storage: ViewStorage, modifiers: [(View) -> View])

}

extension Widget {

    /// A widget's view is empty.
    public var view: Body { [] }

}
