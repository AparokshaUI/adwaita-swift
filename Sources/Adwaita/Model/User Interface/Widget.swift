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
    func container() -> ViewStorage
    /// Update the stored content.
    /// - Parameter storage: The storage to update.
    func update(_ storage: ViewStorage)

}

extension Widget {

    /// A widget's view is empty.
    public var view: Body { [] }

}
