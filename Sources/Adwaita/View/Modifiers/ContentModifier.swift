//
//  ContentModifier.swift
//  Adwaita
//
//  Created by david-swift on 11.11.23.
//

/// A widget which replaces views of a specific type in its content.
struct ContentModifier<Content>: Widget where Content: View {

    /// The wrapped view.
    var content: View
    /// The closure for the modification.
    var modify: (Content) -> View

    /// Get the content's container.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The content's container.
    func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = content.storage(modifiers: modifiers + [modifyView])
        return storage
    }

    /// Update the content.
    /// - Parameters:
    ///     - storage: The content's storage.
    ///     - modifiers: Modify views before being updated.
    ///     - updateProperties: Whether to update properties.
    func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
        content.updateStorage(storage, modifiers: modifiers + [modifyView], updateProperties: updateProperties)
    }

    /// Apply the modifier to a view.
    /// - Parameter view: The view.
    func modifyView(_ view: View) -> View {
        if let view = view as? Content {
            return modify(view).stopModifiers()
        } else {
            return view
        }
    }

}

extension View {

    /// Replace every occurrence of a certain view type in the content.
    /// - Parameters:
    ///     - type: The view type.
    ///     - modify: Modify the view.
    /// - Returns: A view.
    public func modifyContent<Content>(
        _ type: Content.Type,
        modify: @escaping (Content) -> View
    ) -> View where Content: View {
        ContentModifier(content: self, modify: modify)
    }

}
