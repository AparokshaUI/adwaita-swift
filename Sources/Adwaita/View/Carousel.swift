//
//  Carousel.swift
//  Adwaita
//
//  Created by david-swift on 01.01.24.
//

import Libadwaita

/// A carousel view.
public struct Carousel<Element>: View where Element: Identifiable {

    /// The elements.
    var elements: [Element]
    /// The content.
    var content: (Element) -> Body

    /// The view.
    public var view: Body {
        Container(elements, content: content) {
            Libadwaita.Carousel()
        }
    }

    /// Initialize `Carousel`.
    /// - Parameters:
    ///   - elements: The elements.
    ///   - content: The view for an element.
    public init(
        _ elements: [Element],
        @ViewBuilder content: @escaping (Element) -> Body
    ) {
        self.content = content
        self.elements = elements
    }

}
