//
//  SwitchRow.swift
//  Adwaita
//
//  Created by david-swift on 04.01.24.
//

import Libadwaita

/// A row representing a boolean state.
public struct SwitchRow: Widget {

    /// The title.
    var title: String
    /// Whether the switch is activated.
    @Binding var isOn: Bool
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

    /// Initialize a switch row.
    /// - Parameters:
    ///     - title: The row's title.
    ///     - isOn: Whether the switch is on.
    public init(_ title: String, isOn: Binding<Bool>) {
        self.title = title
        self._isOn = isOn
    }

    /// Update a view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let row = storage.view as? Libadwaita.SwitchRow {
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
        let row: Libadwaita.SwitchRow = .init(title: title, subtitle: subtitle)
        let prefixContent = prefix.widget(modifiers: modifiers).container(modifiers: modifiers)
        let suffixContent = suffix.widget(modifiers: modifiers).container(modifiers: modifiers)
        if !prefix.isEmpty {
            _ = row.addPrefix(prefixContent.view)
        }
        if !suffix.isEmpty {
            _ = row.addSuffix(suffixContent.view)
        }
        _ = row.onChange {
            isOn = row.getActive()
        }
        update(row: row)
        return .init(row, content: [prefixID: [prefixContent], suffixID: [suffixContent]])
    }

    /// Update the switch row.
    /// - Parameter row: The switch row.
    func update(row: Libadwaita.SwitchRow) {
        _ = row.title(title)
        _ = row.subtitle(subtitle)
        if row.getActive() != isOn {
            row.setActive(isOn)
        }
    }

    /// Set the switch row's subtitle.
    /// - Parameter subtitle: The subtitle.
    /// - Returns: The switch row.
    public func subtitle(_ subtitle: String) -> Self {
        var newSelf = self
        newSelf.subtitle = subtitle
        return newSelf
    }

    /// Set the switch row's prefix view.
    /// - Parameter prefix: The prefix.
    /// - Returns: The switch row.
    public func prefix(@ViewBuilder _ prefix: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.prefix = prefix()
        return newSelf
    }

    /// Set the switch row's suffix view.
    /// - Parameter suffix: The suffix.
    /// - Returns: The switch row.
    public func suffix(@ViewBuilder _ suffix: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.suffix = suffix()
        return newSelf
    }

}
