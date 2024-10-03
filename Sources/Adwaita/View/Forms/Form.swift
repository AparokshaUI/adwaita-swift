//
//  Form.swift
//  Adwaita
//
//  Created by david-swift on 03.01.24.
//

import CAdw

/// A list with no dynamic content styled as a boxed list.
public struct Form: SimpleView {

    /// The content.
    var content: Body

    /// The view's body.
    public var view: Body {
        List([Int](content.indices), selection: nil) { index in content[index] }
            .style("boxed-list")
    }

    /// Initialize a `Form`.
    /// - Parameter content: The view content, usually different kind of rows.
    public init(@ViewBuilder content: @escaping () -> Body) {
        self.content = content()
    }

}
