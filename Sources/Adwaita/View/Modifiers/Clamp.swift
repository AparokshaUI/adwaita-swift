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
    /// - Parameter storage: The view storage.
    func update(_ storage: ViewStorage) {
        if let clamp = storage.view as? GTUI.Clamp {
            _ = clamp.maximumSize(maxSize)
        }
        if let storage = storage.content[.mainContent]?[safe: 0] {
            content.widget().update(storage)
        }
    }

    /// Get a view storage.
    /// - Returns: The view storage.
    func container() -> ViewStorage {
        let container = content.storage()
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
