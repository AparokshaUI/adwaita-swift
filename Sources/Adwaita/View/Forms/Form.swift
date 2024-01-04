//
//  Form.swift
//  Adwaita
//
//  Created by david-swift on 03.01.24.
//

import Libadwaita

/// A list with no dynamic content styled as a boxed list.
public struct Form: Widget {

    /// The content.
    var content: () -> Body

    /// Initialize a `Form`.
    /// - Parameter content: The view content, usually different kind of rows.
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
        let form: ListBox = .init()
        _ = form
            .noSelection()
            .addStyle("boxed-list")
        var content: [ViewStorage] = []
        for element in self.content() {
            let widget = element.storage(modifiers: modifiers)
            _ = form.append(widget.view)
            content.append(widget)
        }
        return .init(form, content: [.mainContent: content])
    }

}
