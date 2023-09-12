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
    /// - Returns: The content's container.
    func container() -> ViewStorage {
        onUpdate()
        return content.storage()
    }

    /// Update the content.
    /// - Parameter storage: The content's storage.
    func update(_ storage: ViewStorage) {
        onUpdate()
        content.updateStorage(storage)
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
