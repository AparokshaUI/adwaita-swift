//
//  ViewStack.swift
//  Adwaita
//
//  Created by david-swift on 30.12.23.
//

import CAdw

/// A widget holding multiple children but only displaying one.
public struct ViewStack: Widget {

    /// The stack's active content.
    var content: Body
    /// The stack's active identifier.
    var id: CustomStringConvertible

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

    /// Get a stack's view storage.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The stack's view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let stack = gtk_stack_new()
        let storage = ViewStorage(.init(stack))
        update(storage, modifiers: modifiers, updateProperties: true)
        return storage
    }

    /// Update a stack's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    ///     - updateProperties: Whether to update properties.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
        let widget = content.widget(modifiers: modifiers)
        if let view = storage.content[id.description]?.first {
            widget.updateStorage(view, modifiers: modifiers, updateProperties: updateProperties)
        } else {
            let view = widget.storage(modifiers: modifiers)
            gtk_stack_add_named(storage.pointer, view.pointer?.cast(), id.description)
            storage.content[id.description] = [view]
        }
        if let visibleView = storage.content[id.description]?.first {
            if let transition = visibleView.fields[.transition] as? Transition {
                gtk_stack_set_transition_type(storage.pointer, transition.cTransition)
            }
            gtk_stack_set_visible_child_name(storage.pointer, id.description)
        }
    }

}
