//
//  UpdateObserver.swift
//  Adwaita
//
//  Created by david-swift on 10.09.23.
//

import GTUI

/// A widget which executes a custom code when being updated.
struct UpdateObserver: Widget {

    /// The function.
    var onUpdate: () -> Void
    /// The content.
    var content: View

    /// Get the content's container.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The content's container.
    func container(modifiers: [(View) -> View]) -> ViewStorage {
        onUpdate()
        return content.storage(modifiers: modifiers)
    }

    /// Update the content.
    /// - Parameters:
    ///     - storage: The content's storage.
    ///     - modifiers: Modify views before being updated.
    func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        onUpdate()
        content.updateStorage(storage, modifiers: modifiers)
    }

}

extension View {

    /// Run a function when the view gets an update.
    /// - Parameter onUpdate: The function.
    /// - Returns: A view.
    public func onUpdate(_ onUpdate: @escaping () -> Void) -> View {
        UpdateObserver(onUpdate: onUpdate, content: self)
    }

}
