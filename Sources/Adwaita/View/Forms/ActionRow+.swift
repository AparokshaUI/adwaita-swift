//
//  ActionRow+.swift
//  Adwaita
//
//  Created by david-swift on 20.01.24.
//

/// A form content row showing a title and optionally a subtitle and widgets.
extension ActionRow {

    /// Initialize an action row.
    /// - Parameter title: The row's title.
    public init(_ title: String) {
        self = self.title(title)
    }

}
