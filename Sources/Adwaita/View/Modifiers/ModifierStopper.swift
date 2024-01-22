//
//  ModifierStopper.swift
//  Adwaita
//
//  Created by david-swift on 11.11.23.
//

/// Remove all of the content modifiers for the wrapped views.
struct ModifierStopper: Widget {

    /// The wrapped view.
    var content: View

    /// Get the content's container.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The content's container.
    func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = content.storage(modifiers: [])
        return storage
    }

    /// Update the content.
    /// - Parameters:
    ///     - storage: The content's storage.
    ///     - modifiers: Modify views before being updated.
    func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        content.updateStorage(storage, modifiers: [])
    }

}

extension View {

    /// Remove all of the content modifiers for the wrapped views.
    /// - Returns: A view.
    public func stopModifiers() -> View {
        ModifierStopper(content: self)
    }

}
