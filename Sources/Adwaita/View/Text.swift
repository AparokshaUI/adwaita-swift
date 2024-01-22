//
//  Text.swift
//  Adwaita
//
//  Created by david-swift on 23.08.23.
//

/// A text widget.
public typealias Text = Label

extension Text {

    /// Initialize a text widget.
    /// - Parameter text: The content.
    public init(_ text: String) {
        self.init(label: text)
    }

}
