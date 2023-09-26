//
//  StatusPage.swift
//  Adwaita
//
//  Created by david-swift on 25.09.23.
//

import GTUI

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
    public init(_ title: String, icon: Icon, description: String = "", @ViewBuilder content: () -> Body = { [] }) {
        self.title = title
        self.description = description
        self.icon = icon
        self.content = content()
    }

    /// Update the view storage of the text widget.
    /// - Parameter storage: The view storage.
    public func update(_ storage: ViewStorage) {
        if let statusPage = storage.view as? GTUI.StatusPage {
            _ = statusPage.title(title).description(description).icon(icon)
        }
        if let storage = storage.content[.mainContent]?.first {
            content.widget().update(storage)
        }
    }

    /// Get the container of the text widget.
    /// - Returns: The view storage.
    public func container() -> ViewStorage {
        let child = content.widget().container()
        return .init(
            GTUI.StatusPage().title(title).description(description).icon(icon).child(child.view),
            content: [.mainContent: [child]]
        )
    }

}
