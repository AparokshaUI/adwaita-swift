//
//  Text.swift
//  Adwaita
//
//  Created by david-swift on 23.08.23.
//

import Libadwaita

/// A text widget.
public struct Text: Widget {

    /// The content.
    var text: String
    /// Whether line wrapping is allowed.
    var lineWrapping = false

    /// Initialize a text widget.
    /// - Parameter text: The content.
    public init(_ text: String) {
        self.text = text
    }

    /// Update the view storage of the text widget.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let label = storage.view as? MarkupLabel {
            label.setText(text)
            _ = label.wrap(lineWrapping)
        }
    }

    /// Get the container of the text widget.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        .init(MarkupLabel(self.text).wrap(lineWrapping))
    }

    /// Line wrapping allows the text view to span multiple lines if the width is narrow.
    /// - Parameter wrap: Whether to allow line wrapping.
    /// - Returns: The text.
    public func wrap(_ wrap: Bool = true) -> Self {
        var newSelf = self
        newSelf.lineWrapping = wrap
        return newSelf
    }

}
