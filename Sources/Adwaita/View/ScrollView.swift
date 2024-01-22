//
//  ScrollView.swift
//  Adwaita
//
//  Created by david-swift on 26.09.23.
//

/// A GtkScrolledWindow equivalent.
public typealias ScrollView = ScrolledWindow

extension ScrollView {

    /// Initialize a `ScrollView`.
    /// - Parameter content: The view content.
    public init(@ViewBuilder content: @escaping () -> Body) {
        self.init()
        self = self.child(content)
    }

}
