//
//  List.swift
//  Adwaita
//
//  Created by david-swift on 25.09.23.
//

import CAdw
import Meta

/// A list box widget.
public typealias List = ListBox

extension List {

    /// The ID for the field storing the selection value.
    static var selectionField: String { "selection" }
    /// The ID for the field storing the elements.
    static var elementsField: String { "element" }

    /// Initialize `List`.
    /// - Parameters:
    ///   - elements: The elements.
    ///   - selection: The identifier of the selected element. Selection disabled if `nil`.
    ///   - content: The view for an element.
    public init(
        _ elements: [Element],
        selection: Binding<Element.ID>?,
        @ViewBuilder content: @escaping (Element) -> Body
    ) {
        self.init(elements, content: content)
        let id: (ViewStorage, [Element]) -> Element.ID? = { storage, elements in
            if let row = gtk_list_box_get_selected_row(storage.opaquePointer) {
                return elements[safe: .init(gtk_list_box_row_get_index(row))]?.id
            }
            return nil
        }
        if let selection {
            updateFunctions.append { storage, _, _ in
                storage.connectSignal(name: "selected_rows_changed", id: Self.selectionField) {
                    if let elements = storage.fields[Self.elementsField] as? [Element],
                       let id = id(storage, elements),
                       selection.wrappedValue != id {
                        selection.wrappedValue = id
                    }
                }
                if selection.wrappedValue != id(storage, elements),
                let index = elements.firstIndex(where: { $0.id == selection.wrappedValue })?.cInt {
                    gtk_list_box_select_row(
                        storage.opaquePointer,
                        gtk_list_box_get_row_at_index(storage.opaquePointer, index)
                    )
                }
            }
        } else {
            appearFunctions.append { storage, _ in
                gtk_list_box_set_selection_mode(storage.opaquePointer, GTK_SELECTION_NONE)
            }
        }
    }

    /// Add the "navigation-sidebar" style class.
    /// - Parameter active: Whether the style is applied.
    /// - Returns: A view.
    public func sidebarStyle(_ active: Bool = true) -> AnyView {
        style("navigation-sidebar", active: active)
    }

    /// Apply the boxed list style class.
    /// - Parameter active: Whether the style is applied.
    /// - Returns: A view.
    public func boxedList(_ active: Bool = true) -> AnyView {
        style("boxed-list", active: active)
    }

}
