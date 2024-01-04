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
    /// Whether long swipes are allowed.
    var allowLongSwipes = false

    /// The view.
    public var view: Body {
        Container(elements, content: content) {
            Libadwaita.Carousel()
        }
        .inspect { _ = ($0 as? Libadwaita.Carousel)?.longSwipes(allowLongSwipes) }
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

    /// Set whether long swipes are allowed or not.
    /// - Parameter longSwipes: Whether long swipes are allowed.
    /// - Returns: The carousel.
    public func longSwipes(_ longSwipes: Bool = true) -> Self {
        var newSelf = self
        newSelf.allowLongSwipes = longSwipes
        return newSelf
    }

}
