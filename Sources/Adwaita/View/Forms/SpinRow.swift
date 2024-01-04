//
//  SpinRow.swift
//  Adwaita
//
//  Created by david-swift on 04.01.24.
//

import Libadwaita

/// A spin row lets the user select an integer in a certain range.
public struct SpinRow: Widget {

    /// The title.
    var title: String
    /// The selected value.
    @Binding var value: Int
    /// The minimum value.
    var min: Int
    /// The maximum value.
    var max: Int
    /// The increase/decrease step.
    var step = 1
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

    /// The identifier of the configuration field.
    let configID = "config"

    /// Initialize a spin row.
    /// - Parameters:
    ///     - title: The row's title.
    ///     - value: The selected value.
    ///     - min: The minimum value.
    ///     - max: The maximum value.
    public init(_ title: String, value: Binding<Int>, min: Int, max: Int) {
        self.title = title
        self._value = value
        self.min = min
        self.max = max
    }

    /// Update a view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let row = storage.view as? Libadwaita.SpinRow {
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
        let row: Libadwaita.SpinRow = .init(
            title: title,
            subtitle: subtitle,
            min: .init(min),
            max: .init(max),
            step: .init(step)
        )
        row.fields[configID] = (min, max, step)
        let prefixContent = prefix.widget(modifiers: modifiers).container(modifiers: modifiers)
        let suffixContent = suffix.widget(modifiers: modifiers).container(modifiers: modifiers)
        if !prefix.isEmpty {
            _ = row.addPrefix(prefixContent.view)
        }
        if !suffix.isEmpty {
            _ = row.addSuffix(suffixContent.view)
        }
        _ = row.onChange {
            let value = Int(row.getValue().rounded())
            if self.value != value {
                self.value = value
            }
        }
        update(row: row)
        return .init(row, content: [prefixID: [prefixContent], suffixID: [suffixContent]])
    }

    // swiftlint:disable large_tuple
    /// Update the spin row.
    /// - Parameter row: The spin row.
    func update(row: Libadwaita.SpinRow) {
        _ = row.title(title)
        _ = row.subtitle(subtitle)
        if row.fields[configID] as? (Int, Int, Int) ?? (0, 0, 0) != (min, max, step) {
            _ = row.configuration(min: .init(min), max: .init(max), step: .init(step))
            row.fields[configID] = (min, max, step)
        }
        if row.getValue() != .init(value) {
            row.setValue(.init(value))
        }
    }
    // swiftlint:enable large_tuple

    /// Set the spin row's subtitle.
    /// - Parameter subtitle: The subtitle.
    /// - Returns: The spin row.
    public func subtitle(_ subtitle: String) -> Self {
        var newSelf = self
        newSelf.subtitle = subtitle
        return newSelf
    }

    /// Set the spin row's prefix view.
    /// - Parameter prefix: The prefix.
    /// - Returns: The spin row.
    public func prefix(@ViewBuilder _ prefix: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.prefix = prefix()
        return newSelf
    }

    /// Set the spin row's suffix view.
    /// - Parameter suffix: The suffix.
    /// - Returns: The spin row.
    public func suffix(@ViewBuilder _ suffix: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.suffix = suffix()
        return newSelf
    }

    /// Set the difference a single click on the increase/decrease buttons makes.
    /// - Parameter step: The increase/decrease step.
    /// - Returns: The spin row.
    public func step(_ step: Int) -> Self {
        var newSelf = self
        newSelf.step = step
        return newSelf
    }

}
