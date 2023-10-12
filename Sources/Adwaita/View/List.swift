//
//  List.swift
//  Adwaita
//
//  Created by david-swift on 25.09.23.
//

import GTUI

/// A list box widget.
public struct List<Element>: Widget where Element: Identifiable {

    /// The elements.
    var elements: [Element]
    /// The content.
    var content: (Element) -> Body
    /// The identifier of the selected element.
    @Binding var selection: Element.ID

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
    /// - Parameter storage: The view storage.
    public func update(_ storage: ViewStorage) {
        if let box = storage.view as? ListBox {
            updateSelection(box: box)
        }
    }

    /// Get a view storage.
    /// - Returns: The view storage.
    public func container() -> ViewStorage {
        let box: ListBox = .init()
        var content: [ViewStorage] = []
        for element in elements {
            let widget = self.content(element).widget().container()
            _ = box.append(widget.view)
            content.append(widget)
        }
        _ = box.handler {
            let selection = box.getSelectedRow()
            if let id = elements[safe: selection]?.id {
                self.selection = id
            }
        }
        updateSelection(box: box)
        return .init(box, content: [.mainContent: content])
    }

    /// Update the list's selection.
    /// - Parameter box: The list box.
    func updateSelection(box: ListBox) {
        if let index = elements.firstIndex(where: { $0.id == selection }) {
            box.selectRow(at: index)
        }
    }

    /// Add the "navigation-sidebar" style class.
    public func sidebarStyle() -> View {
        style("navigation-sidebar")
    }

}
