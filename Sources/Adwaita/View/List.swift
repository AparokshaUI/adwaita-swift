//
//  List.swift
//  Adwaita
//
//  Created by david-swift on 25.09.23.
//

import LevenshteinTransformations
import Libadwaita

/// A list box widget.
public struct List<Element>: Widget where Element: Identifiable {

    /// The elements.
    var elements: [Element]
    /// The content.
    var content: (Element) -> Body
    /// The identifier of the selected element.
    @Binding var selection: Element.ID

    /// The identifier of the elements storage.
    let elementsID = "elements"

    /// Initialize `List`.
    /// - Parameters:
    ///   - elements: The elements.
    ///   - selection: The identifier of the selected element.
    ///   - content: The view for an element.
    public init(
        _ elements: [Element],
        selection: Binding<Element.ID>,
        @ViewBuilder content: @escaping (Element) -> Body
    ) {
        self.content = content
        self.elements = elements
        self._selection = selection
    }

    /// Update a view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let box = storage.view as? ListBox {
            var content: [ViewStorage] = storage.content[.mainContent] ?? []
            updateList(box: box, content: .init { content } set: { content = $0 }, modifiers: modifiers)
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
        let box: ListBox = .init()
        var content: [ViewStorage] = []
        updateList(box: box, content: .init { content } set: { content = $0 }, modifiers: modifiers)
        _ = box.handler {
            let selection = box.getSelectedRow()
            if let id = (box.fields[elementsID] as? [Element] ?? elements)[safe: selection]?.id {
                self.selection = id
            }
        }
        return .init(box, content: [.mainContent: content])
    }

    /// Update the list's content and selection.
    /// - Parameters:
    ///     - box: The list box.
    ///     - content: The content's view storage.
    ///     - modifiers: The view modifiers.
    func updateList(box: ListBox, content: Binding<[ViewStorage]>, modifiers: [(View) -> View]) {
        let old = box.fields[elementsID] as? [Element] ?? []
        old.identifiableTransform(
            to: elements,
            functions: .init { index, element in
                let widget = getWidget(element: element, modifiers: modifiers)
                _ = box.remove(at: index)
                _ = box.insert(widget.view, at: index)
                content.wrappedValue.remove(at: index)
                content.wrappedValue.insert(widget, at: index)
            } delete: { index in
                _ = box.remove(at: index)
                content.wrappedValue.remove(at: index)
                updateSelection(box: box)
            } insert: { index, element in
                let widget = getWidget(element: element, modifiers: modifiers)
                _ = box.insert(widget.view, at: index)
                content.wrappedValue.insert(widget, at: index)
            }
        )
        box.fields[elementsID] = elements
        updateSelection(box: box)
    }

    /// Update the list's selection.
    /// - Parameter box: The list box.
    func updateSelection(box: ListBox) {
        if let index = elements.firstIndex(where: { $0.id == selection }) {
            box.selectRow(at: index)
        }
    }

    /// Get the view storage of an element.
    /// - Parameters:
    ///     - element: The element.
    ///     - modifiers: The modifiers.
    /// - Returns: The view storage.
    func getWidget(element: Element, modifiers: [(View) -> View]) -> ViewStorage {
        self.content(element).widget(modifiers: modifiers).container(modifiers: modifiers)
    }

    /// Add the "navigation-sidebar" style class.
    public func sidebarStyle() -> View {
        style("navigation-sidebar")
    }

}
