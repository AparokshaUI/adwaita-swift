//
//  EntryRow.swift
//  Adwaita
//
//  Created by david-swift on 04.01.24.
//

import Libadwaita

/// A form content row accepting text input.
public struct EntryRow: Widget {

    /// The title.
    var title: String
    /// The text.
    @Binding var text: String
    /// The prefix.
    var prefix: Body = []
    /// The suffix.
    var suffix: Body = []
    /// The handler that gets executed when the user submits the content.
    var onSubmit: (() -> Void)?
    /// Whether the password entry row should be used.
    var password = false

    /// The identifier for the prefix content.
    let prefixID = "prefix"
    /// The identifier for the suffix content.
    let suffixID = "suffix"

    /// Initialize an entry row.
    /// - Parameters:
    ///     - title: The row's title.
    ///     - text: The text.
    public init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }

    /// Update a view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let row = storage.view as? Libadwaita.EntryRow {
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
        let row: Libadwaita.EntryRow
        if password {
            row = PasswordEntryRow(title: title)
        } else {
            row = .init(title: title)
        }
        let prefixContent = prefix.widget(modifiers: modifiers).container(modifiers: modifiers)
        let suffixContent = suffix.widget(modifiers: modifiers).container(modifiers: modifiers)
        if !prefix.isEmpty {
            _ = row.addPrefix(prefixContent.view)
        }
        if !suffix.isEmpty {
            _ = row.addSuffix(suffixContent.view)
        }
        _ = row.changeHandler {
            text = row.contents()
        }
        update(row: row)
        return .init(row, content: [prefixID: [prefixContent], suffixID: [suffixContent]])
    }

    /// Update the entry row.
    /// - Parameter row: The entry row.
    func update(row: Libadwaita.EntryRow) {
        _ = row.title(title)
        if row.contents() != text {
            row.setContents(text)
        }
        if let onSubmit {
            _ = row.submitHandler(onSubmit)
        }
    }

    /// Set the entry row's subtitle.
    /// - Parameter subtitle: The subtitle.
    /// - Returns: The entry row.
    public func onSubmit(_ onSubmit: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.onSubmit = onSubmit
        return newSelf
    }

    /// Set the entry row's prefix view.
    /// - Parameter prefix: The prefix.
    /// - Returns: The entry row.
    public func prefix(@ViewBuilder _ prefix: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.prefix = prefix()
        return newSelf
    }

    /// Set the entry row's suffix view.
    /// - Parameter suffix: The suffix.
    /// - Returns: The entry row.
    public func suffix(@ViewBuilder _ suffix: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.suffix = suffix()
        return newSelf
    }

    /// Let the user securely enter private text.
    /// - Returns: The entry row.
    public func secure() -> Self {
        var newSelf = self
        newSelf.password = true
        return newSelf
    }

}
