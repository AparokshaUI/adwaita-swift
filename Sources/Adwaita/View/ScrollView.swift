//
//  ScrollView.swift
//  Adwaita
//
//  Created by david-swift on 26.09.23.
//

import GTUI

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
    /// - Parameter storage: The view storage.
    public func update(_ storage: ViewStorage) {
        if let first = storage.content[.mainContent]?.first {
          content().widget().update(first)
        }
    }

    /// Get a view storage.
    /// - Returns: The view storage.
    public func container() -> ViewStorage {
        let container = content().widget().container()
        return .init(Scrolled().setChild(container.view), content: [.mainContent: [container]])
    }

}
