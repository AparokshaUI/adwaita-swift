//
//  ArrayBuilder.swift
//  Adwaita
//
//  Created by david-swift on 05.08.23.
//
//  Thanks to Jaden Geller for the GitHub Gist:
//  "ArrayBuilder.swift"
//  https://gist.github.com/JadenGeller/c375fc15ad5900a0ddac4ed8ba8307a9
//

import Foundation

/// The ``ArrayBuilder`` is a simple result builder that outputs an array of any type.
///
/// You can define any array using Swift's DSL:
/// ```swift
/// @ArrayBuilder<String> var string: [String] {
///     "Hello, "
///     if bool {
///         "world!"
///     } else {
///         "colibri!"
///     }
///     for x in 0...10 {
///         "\nIteration Number \(x)"
///     }
/// }
/// ```
@resultBuilder
public enum ArrayBuilder<Element> {

    /// A component used in the ``ArrayBuilder``.
    public enum Component {

        /// An element as a component.
        case element(_: Element)
        /// An array of components as a component.
        case components(_: [Self])

    }

    /// Build combined results from statement blocks.
    /// - Parameter components: The components.
    /// - Returns: The components in a component.
    public static func buildBlock(_ elements: Component...) -> Component {
        .components(elements)
    }

    /// Translate an element into an ``ArrayBuilder.Component``.
    /// - Parameter element: The element to translate.
    /// - Returns: A component created from the element.
    public static func buildExpression(_ element: Element) -> Component {
        .element(element)
    }

    /// Translate an array of elements into an ``ArrayBuilder.Component``.
    /// - Parameter elements: The elements to translate.
    /// - Returns: A component created from the element.
    public static func buildExpression(_ elements: [Element]) -> Component {
        var components: [Component] = []
        for element in elements {
            components.append(.element(element))
        }
        return .components(components)
    }

    /// Fetch a component.
    /// - Parameter component: A component.
    /// - Returns: The component.
    public static func buildExpression(_ component: Component) -> Component {
        component
    }

    /// Enables support for `if` statements without an `else`.
    /// - Parameter component: An optional component.
    /// - Returns: A nonoptional component.
    public static func buildOptional(_ component: Component?) -> Component {
        component ?? .components([])
    }

    /// Enables support for `if`-`else` and `switch` statements.
    /// - Parameter component: A component.
    /// - Returns: The component.
    public static func buildEither(first component: Component) -> Component {
        component
    }

    /// Enables support for `if`-`else` and `switch` statements.
    /// - Parameter component: A component.
    /// - Returns: The component.
    public static func buildEither(second component: Component) -> Component {
        component
    }

    /// Enables support for `for..in` loops.
    /// - Parameter components: The components as a two dimensional array.
    /// - Returns: The components as a one dimensional array.
    public static func buildArray(_ components: [Component]) -> Component {
        .components(components)
    }

    /// Convert a component to an array of elements.
    /// - Parameter component: The component to convert.
    /// - Returns: The generated array of elements.
    public static func buildFinalResult(_ component: Component) -> [Element] {
        switch component {
        case let .element(element):
            return [element]
        case let .components(components):
            return components.flatMap { buildFinalResult($0) }
        }
    }

}
