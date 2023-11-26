//
//  VStack.swift
//  Adwaita
//
//  Created by david-swift on 23.08.23.
//

import Libadwaita

/// A GtkBox equivalent.
public struct VStack: Widget {

    /// The content.
    var content: () -> Body

    /// Initialize a `VStack`.
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
        let box: Box = .init(horizontal: false)
        var content: [ViewStorage] = []
        for element in self.content() {
            let widget = element.storage(modifiers: modifiers)
            _ = box.append(widget.view)
            content.append(widget)
        }
        return .init(box, content: [.mainContent: content])
    }

}
