//
//  ViewStack.swift
//  Adwaita
//
//  Created by david-swift on 30.12.23.
//

import CAdw

/// A widget holding multiple children but only displaying one.
public struct ViewStack: AdwaitaWidget {

    /// The stack's active content.
    var content: Body
    /// The stack's active identifier.
    var id: CustomStringConvertible
    /// Whether the view stack allocates the same height and width for all children.
    var homogeneous: Bool?

    /// Initialize the stack.
    /// - Parameters:
    ///     - id: The identifier of the current view.
    ///     - view: The current view.
    public init<Identifier>(
        id: Identifier,
        @ViewBuilder view: @escaping (Identifier) -> Body
    ) where Identifier: CustomStringConvertible {
        content = view(id)
        self.id = id
    }

    /// Initialize the stack.
    /// - Parameters:
    ///     - element: The current identifiable element.
    ///     - view: The current view.
    public init<Element>(
        element: Element,
        @ViewBuilder view: @escaping (Element) -> Body
    ) where Element: Identifiable, Element.ID: CustomStringConvertible {
        content = view(element)
        self.id = element.id
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(
        data: WidgetData,
        type: Data.Type
    ) -> ViewStorage where Data: ViewRenderData {
        let stack = gtk_stack_new()
        let storage = ViewStorage(stack?.opaque())
        update(storage, data: data, updateProperties: true, type: type)
        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The type of the app storage.
    public func update<Data>(
        _ storage: ViewStorage,
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        if let view = storage.content[id.description]?.first {
            content.updateStorage(view, data: data, updateProperties: updateProperties, type: type)
        } else {
            let view = content.storage(data: data, type: type)
            gtk_stack_add_named(storage.opaquePointer, view.opaquePointer?.cast(), id.description)
            storage.content[id.description] = [view]
        }
        if let visibleView = storage.content[id.description]?.first {
            if let transition = visibleView.fields[.transition] as? Transition {
                gtk_stack_set_transition_type(storage.opaquePointer, transition.cTransition)
            }
            if (storage.previousState as? Self)?.id.description != id.description {
                gtk_stack_set_visible_child_name(storage.opaquePointer, id.description)
            }
        }
        if let homogeneous, homogeneous != (storage.previousState as? Self)?.homogeneous {
            gtk_stack_set_vhomogeneous(storage.opaquePointer, homogeneous.cBool)
            gtk_stack_set_hhomogeneous(storage.opaquePointer, homogeneous.cBool)
        }
        storage.previousState = self
    }

    /// Whether the view stack allocates the same height and width for all children.
    /// - Parameter homogeneous: Whether this is enabled.
    /// - Returns: The stack.
    public func homogeneous(_ homogeneous: Bool? = nil) -> Self {
        modify { $0.homogeneous = homogeneous }
    }

}
