//
//  FormSection.swift
//  Adwaita
//
//  Created by david-swift on 03.01.24.
//

import Libadwaita

/// A section usually groups forms.
public struct FormSection: Widget {

    /// The title.
    var title: String
    /// The content.
    var content: Body
    /// The description.
    var description = ""
    /// The suffix.
    var suffix: Body = []

    /// The identifier for the suffix content.
    let suffixID = "suffix"

    /// Initialize a form section.
    /// - Parameters:
    ///     - title: The title.
    ///     - content: The content, usually one or more forms.
    public init(_ title: String, @ViewBuilder content: () -> Body) {
        self.title = title
        self.content = content()
    }

    /// Update a view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let group = storage.view as? Libadwaita.PreferencesGroup {
            update(group: group)
        }
        if let storage = storage.content[.mainContent]?.first {
            content.widget(modifiers: modifiers).update(storage, modifiers: modifiers)
        }
        if let suffixStorage = storage.content[suffixID]?.first {
            suffix.widget(modifiers: modifiers).update(suffixStorage, modifiers: modifiers)
        }
    }

    /// Get a view storage.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let group: Libadwaita.PreferencesGroup = .init(name: title, description: description)
        let content = content.widget(modifiers: modifiers).container(modifiers: modifiers)
        let suffixContent = suffix.widget(modifiers: modifiers).container(modifiers: modifiers)
        group.add(content.view)
        if !suffix.isEmpty {
            _ = group.headerSuffix(suffixContent.view)
        }
        return .init(group, content: [.mainContent: [content], suffixID: [suffixContent]])
    }

    /// Update the form section.
    /// - Parameter group: The form section.
    func update(group: Libadwaita.PreferencesGroup) {
        _ = group.title(title)
        _ = group.description(description)
    }

    /// Set the form section's description.
    /// - Parameter description: The description.
    /// - Returns: The form section.
    public func description(_ description: String) -> Self {
        var newSelf = self
        newSelf.description = description
        return newSelf
    }

    /// Set the form section's suffix view.
    /// - Parameter suffix: The suffix.
    /// - Returns: The form section.
    public func suffix(@ViewBuilder _ suffix: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.suffix = suffix()
        return newSelf
    }

}
