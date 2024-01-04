//
//  ComboRow.swift
//  Adwaita
//
//  Created by david-swift on 04.01.24.
//

import Libadwaita

/// A row for selecting an element out of a list of elements.
public struct ComboRow<Element>: Widget
where Element: CustomStringConvertible, Element: Identifiable, Element: Equatable {

    /// The title.
    var title: String
    /// The selected element.
    @Binding var selection: Element.ID
    /// The content.
    var content: [Element]
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

    /// The identifier for the elements.
    let elementsID = "elements"

    /// Initialize a combo row.
    /// - Parameters:
    ///     - title: The row's title.
    ///     - selection: The selected value.
    ///     - values: The available values.
    public init(_ title: String, selection: Binding<Element.ID>, values: [Element]) {
        self.title = title
        self._selection = selection
        content = values
    }

    /// Update a view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let row = storage.view as? Libadwaita.ComboRow {
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
        let row: Libadwaita.ComboRow = .init(title: title, subtitle: subtitle)
        let prefixContent = prefix.widget(modifiers: modifiers).container(modifiers: modifiers)
        let suffixContent = suffix.widget(modifiers: modifiers).container(modifiers: modifiers)
        if !prefix.isEmpty {
            _ = row.addPrefix(prefixContent.view)
        }
        if !suffix.isEmpty {
            _ = row.addSuffix(suffixContent.view)
        }
        update(row: row)
        _ = row.onChange {
            if let element = content.first(where: { $0.description == row.selected() }) {
                selection = element.id
            }
        }
        return .init(row, content: [prefixID: [prefixContent], suffixID: [suffixContent]])
    }

    /// Update the combo row.
    /// - Parameter row: The combo row.
    func update(row: Libadwaita.ComboRow) {
        _ = row.title(title)
        _ = row.subtitle(subtitle)
        let oldElements = row.fields[elementsID] as? [Element] ?? []
        if oldElements != content {
            for element in oldElements {
                row.remove(at: 0)
            }
            for element in content {
                row.append(element.description)
            }
        }
        let index = content.firstIndex { $0.id == selection } ?? 0
        if row.selected() != content[safe: index]?.description {
            row.select(at: index)
        }
        row.fields[elementsID] = content
    }

    /// Set the combo row's subtitle.
    /// - Parameter subtitle: The subtitle.
    /// - Returns: The combo row.
    public func subtitle(_ subtitle: String) -> Self {
        var newSelf = self
        newSelf.subtitle = subtitle
        return newSelf
    }

    /// Set the combo row's prefix view.
    /// - Parameter prefix: The prefix.
    /// - Returns: The combo row.
    public func prefix(@ViewBuilder _ prefix: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.prefix = prefix()
        return newSelf
    }

    /// Set the combo row's suffix view.
    /// - Parameter suffix: The suffix.
    /// - Returns: The combo row.
    public func suffix(@ViewBuilder _ suffix: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.suffix = suffix()
        return newSelf
    }

}
