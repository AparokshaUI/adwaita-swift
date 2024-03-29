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
            if let child = g_list_nth_data(gtk_flow_box_get_selected_children(storage.pointer), 0) {
                let element = gtk_flow_box_child_get_child(child.cast())
                return elements[safe: storage.content[.mainContent]?.firstIndex { $0.pointer?.cast() == element }]?.id
            }
            return nil
        }
        if let selection {
            appearFunctions.append { storage, _ in
                storage.fields[Self.selectionField] = selection
                storage.connectSignal(name: "selected_children_changed", id: Self.selectionField) {
                    if let binding = storage.fields[Self.selectionField] as? Binding<Element.ID>,
                    let elements = storage.fields[Self.elementsField] as? [Element],
                    let id = id(storage, elements) {
                        binding.wrappedValue = id
                    }
                }
            }
            updateFunctions.append { storage, _, _ in
                if selection.wrappedValue != id(storage, elements),
                let index = elements.firstIndex(where: { $0.id == selection.wrappedValue })?.cInt {
                    gtk_flow_box_select_child(storage.pointer, gtk_flow_box_get_child_at_index(storage.pointer, index))
                }
            }
        } else {
            appearFunctions.append { storage, _ in
                gtk_flow_box_set_selection_mode(storage.pointer, GTK_SELECTION_NONE)
            }
        }
    }

}
