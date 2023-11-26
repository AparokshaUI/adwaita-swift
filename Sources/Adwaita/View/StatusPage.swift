//
//  StatusPage.swift
//  Adwaita
//
//  Created by david-swift on 25.09.23.
//

import Libadwaita

/// A status page widget.
public struct StatusPage: Widget {

    /// The title.
    var title: String
    /// The description.
    var description: String
    /// The icon.
    var icon: Icon
    /// Additional content.
    var content: Body

    /// Initialize a status page widget.
    /// - Parameters:
    ///   - title: The title.
    ///   - icon: The icon.
    ///   - description: Additional details.
    ///   - content: Additional content.
    public init(
        _ title: String,
        icon: Icon? = nil,
        description: String = "",
        @ViewBuilder content: () -> Body = { [] }
    ) {
        self.title = title
        self.description = description
        self.icon = icon ?? .custom(name: "")
        self.content = content()
    }

    /// Update the view storage of the text widget.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let statusPage = storage.view as? Libadwaita.StatusPage {
            _ = statusPage.title(title).description(description).icon(icon)
        }
        if let storage = storage.content[.mainContent]?.first {
            content.widget(modifiers: modifiers).update(storage, modifiers: modifiers)
        }
    }

    /// Get the container of the text widget.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let child = content.widget(modifiers: []).container(modifiers: modifiers)
        return .init(
            Libadwaita.StatusPage().title(title).description(description).icon(icon).child(child.view),
            content: [.mainContent: [child]]
        )
    }

}
