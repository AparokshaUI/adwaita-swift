//
//  Text.swift
//  Adwaita
//
//  Created by david-swift on 23.08.23.
//

import CAdw

/// A text widget.
public typealias Text = Label

extension Text {

    /// Initialize a text widget.
    /// - Parameter text: The content.
    public init(_ text: String) {
        self.init(label: text)
    }

    /// Set whether the text should ellipsize at the end.
    /// - Parameter ellipsize: Whether it should ellipsize.
    /// - Returns: The text widget.
    public func ellipsize(_ ellipsize: Bool = true) -> AnyView {
        inspect { storage, _ in gtk_label_set_ellipsize(storage.opaquePointer, PANGO_ELLIPSIZE_END) }
    }

}
