//
//  Clamp.swift
//  Adwaita
//
//  Created by david-swift on 12.10.23.
//

import GTUI

/// A horizontal AdwClamp equivalent.
struct Clamp: Widget {

    /// The content.
    var content: View
    /// The maximum size.
    var maxSize: Int

    /// Update a view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let clamp = storage.view as? GTUI.Clamp {
            _ = clamp.maximumSize(maxSize)
        }
        if let storage = storage.content[.mainContent]?[safe: 0] {
            content.widget(modifiers: modifiers).update(storage, modifiers: modifiers)
        }
    }

    /// Get a view storage.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The view storage.
    func container(modifiers: [(View) -> View]) -> ViewStorage {
        let container = content.storage(modifiers: modifiers)
        let clamp: GTUI.Clamp = .init(container.view)
        _ = clamp.maximumSize(maxSize)
        return .init(clamp, content: [.mainContent: [container]])
    }

}

extension View {

    /// Set the view's maximal size.
    /// - Parameter maxSize: The maximal size.
    /// - Returns: A view.
    public func frame(maxSize: Int? = nil) -> View {
        Clamp(content: self, maxSize: maxSize ?? -1)
    }

}
