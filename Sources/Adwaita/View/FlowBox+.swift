//
//  FlowBox+.swift
//  Adwaita
//
//  Created by david-swift on 12.02.24.
//

import CAdw

extension FlowBox {

    /// The ID for the field storing the selection value.
    static var selectionField: String { "selection" }
    /// The ID for the field storing the elements.
    static var elementsField: String { "element" }

    /// Initialize `FlowBox`.
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
            if let child = g_list_nth_data(gtk_flow_box_get_selected_children(storage.opaquePointer), 0) {
                let element = gtk_flow_box_child_get_child(child.cast())
                return elements[safe: storage.content[.mainContent]?
                    .firstIndex { $0.opaquePointer?.cast() == element }]?.id
            }
            return nil
        }
        if let selection {
            updateFunctions.append { storage, _, _ in
                storage.connectSignal(name: "selected_children_changed", id: Self.selectionField) {
                    if let elements = storage.fields[Self.elementsField] as? [Element],
                    let id = id(storage, elements) {
                        selection.wrappedValue = id
                    }
                }
                if selection.wrappedValue != id(storage, elements),
                let index = elements.firstIndex(where: { $0.id == selection.wrappedValue })?.cInt {
                    gtk_flow_box_select_child(
                        storage.opaquePointer,
                        gtk_flow_box_get_child_at_index(storage.opaquePointer, index)
                    )
                }
            }
        } else {
            appearFunctions.append { storage, _ in
                gtk_flow_box_set_selection_mode(storage.opaquePointer, GTK_SELECTION_NONE)
            }
        }
    }

}
