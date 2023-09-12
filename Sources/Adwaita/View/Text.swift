//
//  HeaderBar.swift
//  Adwaita
//
//  Created by david-swift on 23.08.23.
//

import GTUI

/// A text widget.
public struct Text: Widget {

    /// The content.
    var text: String

    /// Initialize a text widget.
    /// - Parameter text: The content.
    public init(_ text: String) {
        self.text = text
    }

    /// Update the view storage of the text widget.
    /// - Parameter storage: The view storage.
    public func update(_ storage: ViewStorage) {
        if let label = storage.view as? MarkupLabel {
            label.setText(text)
        }
    }

    /// Get the container of the text widget.
    /// - Returns: The view storage.
    public func container() -> ViewStorage {
        .init(MarkupLabel(self.text))
    }

}
