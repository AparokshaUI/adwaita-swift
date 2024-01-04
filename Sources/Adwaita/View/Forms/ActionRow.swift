//
//  ActionRow.swift
//  Adwaita
//
//  Created by david-swift on 03.01.24.
//

import Libadwaita

/// A form content row showing a title and optionally a subtitle and widgets.
public struct ActionRow: Widget {

    /// The title.
    var title: String
    /// The subtitle.
    var subtitle = ""
    /// The prefix.
    var prefix: Body = []
    /// The suffix.
    var suffix: Body = []

    /// The identifier for the prefix content.
    let prefixID = "prefix"
    /// The identifier for the suffix content.
    let suffixID = "suffix"

    /// Initialize an action row.
    /// - Parameter title: The row's title.
    public init(_ title: String) {
        self.title = title
    }

    /// Update a view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let row = storage.view as? Libadwaita.ActionRow {
            update(row: row)
        }
        if let prefixStorage = storage.content[prefixID]?.first {
            prefix.widget(modifiers: modifiers).update(prefixStorage, modifiers: modifiers)
        }
        if let suffixStorage = storage.content[suffixID]?.first {
            suffix.widget(modifiers: modifiers).update(suffixStorage, modifiers: modifiers)
        }
    }

    /// Get a view storage.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let row: Libadwaita.ActionRow = .init(title: title, subtitle: subtitle)
        let prefixContent = prefix.widget(modifiers: modifiers).container(modifiers: modifiers)
        let suffixContent = suffix.widget(modifiers: modifiers).container(modifiers: modifiers)
        if !prefix.isEmpty {
            _ = row.addPrefix(prefixContent.view)
        }
        if !suffix.isEmpty {
            _ = row.addSuffix(suffixContent.view)
        }
        return .init(row, content: [prefixID: [prefixContent], suffixID: [suffixContent]])
    }

    /// Update the action row.
    /// - Parameter row: The action row.
    func update(row: Libadwaita.ActionRow) {
        _ = row.title(title)
        _ = row.subtitle(subtitle)
    }

    /// Set the action row's subtitle.
    /// - Parameter subtitle: The subtitle.
    /// - Returns: The action row.
    public func subtitle(_ subtitle: String) -> Self {
        var newSelf = self
        newSelf.subtitle = subtitle
        return newSelf
    }

    /// Set the action row's prefix view.
    /// - Parameter prefix: The prefix.
    /// - Returns: The action row.
    public func prefix(@ViewBuilder _ prefix: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.prefix = prefix()
        return newSelf
    }

    /// Set the action row's suffix view.
    /// - Parameter suffix: The suffix.
    /// - Returns: The action row.
    public func suffix(@ViewBuilder _ suffix: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.suffix = suffix()
        return newSelf
    }

}
