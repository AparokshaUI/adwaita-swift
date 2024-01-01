//
//  Container.swift
//  Adwaita
//
//  Created by david-swift on 01.01.24.
//

import LevenshteinTransformations
import Libadwaita

/// A container widget.
public struct Container<Type, Element>: Widget
where Element: Identifiable, Type: InsertableContainer, Type: NativeWidgetPeer {

    /// The elements.
    var elements: [Element]
    /// The content.
    var content: (Element) -> Body
    /// Get the container for initialization.
    var container: () -> Type

    /// The identifier of the elements storage.
    let elementsID = "elements"

    /// Initialize `Container`.
    /// - Parameters:
    ///   - elements: The elements.
    ///   - content: The view for an element.
    ///   - container: Get the initial Libadwaita container widget.
    public init(
        _ elements: [Element],
        @ViewBuilder content: @escaping (Element) -> Body,
        container: @escaping () -> Type
    ) {
        self.content = content
        self.elements = elements
        self.container = container
    }

    /// Update a view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let container = storage.view as? Type {
            var content: [ViewStorage] = storage.content[.mainContent] ?? []
            updateContainer(container, content: .init { content } set: { content = $0 }, modifiers: modifiers)
            storage.content[.mainContent] = content
            for (index, element) in elements.enumerated() {
                self.content(element).widget(modifiers: modifiers).update(content[index], modifiers: modifiers)
            }
        }
    }

    /// Get a view storage.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let container = self.container()
        var content: [ViewStorage] = []
        updateContainer(container, content: .init { content } set: { content = $0 }, modifiers: modifiers)
        return .init(container, content: [.mainContent: content])
    }

    /// Update the container's content.
    /// - Parameters:
    ///     - container: The container.
    ///     - content: The content's view storage.
    ///     - modifiers: The view modifiers.
    func updateContainer(_ container: Type, content: Binding<[ViewStorage]>, modifiers: [(View) -> View]) {
        let old = container.fields[elementsID] as? [Element] ?? []
        old.identifiableTransform(
            to: elements,
            functions: .init { index, element in
                let widget = getWidget(element: element, modifiers: modifiers)
                _ = container.removeWidgets([content.wrappedValue[index].view])
                _ = container.insert(widget.view, at: index)
                content.wrappedValue.remove(at: index)
                content.wrappedValue.insert(widget, at: index)
            } delete: { index in
                _ = container.removeWidgets([content.wrappedValue[index].view])
                content.wrappedValue.remove(at: index)
            } insert: { index, element in
                let widget = getWidget(element: element, modifiers: modifiers)
                _ = container.insert(widget.view, at: index)
                content.wrappedValue.insert(widget, at: index)
            }
        )
        container.fields[elementsID] = elements
    }

    /// Get the view storage of an element.
    /// - Parameters:
    ///     - element: The element.
    ///     - modifiers: The modifiers.
    /// - Returns: The view storage.
    func getWidget(element: Element, modifiers: [(View) -> View]) -> ViewStorage {
        self.content(element).widget(modifiers: modifiers).container(modifiers: modifiers)
    }

}
