//
//  ScrollView.swift
//  Adwaita
//
//  Created by david-swift on 26.09.23.
//

import Libadwaita

/// A GtkScrolledWindow equivalent.
public struct ScrollView: Widget {

    /// The content.
    var content: () -> Body

    /// Initialize a `ScrollView`.
    /// - Parameter content: The view content.
    public init(@ViewBuilder content: @escaping () -> Body) {
        self.content = content
    }

    /// Update a view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let first = storage.content[.mainContent]?.first {
          content().widget(modifiers: modifiers).update(first, modifiers: modifiers)
        }
    }

    /// Get a view storage.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let container = content().widget(modifiers: modifiers).container(modifiers: modifiers)
        return .init(Scrolled().setChild(container.view), content: [.mainContent: [container]])
    }

}
