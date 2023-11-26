//
//  HStack.swift
//  Adwaita
//
//  Created by david-swift on 26.09.23.
//

import Libadwaita

/// A horizontal GtkBox equivalent.
public struct HStack: Widget {

    /// The content.
    var content: () -> Body

    /// Initialize a `HStack`.
    /// - Parameter content: The view content.
    public init(@ViewBuilder content: @escaping () -> Body) {
        self.content = content
    }

    /// Update a view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        content().update(storage.content[.mainContent] ?? [], modifiers: modifiers)
    }

    /// Get a view storage.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let box: Box = .init(horizontal: true)
        var content: [ViewStorage] = []
        for element in self.content() {
            let widget = element.storage(modifiers: modifiers)
            _ = box.append(widget.view)
            content.append(widget)
        }
        return .init(box, content: [.mainContent: content])
    }

}
