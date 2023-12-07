//
//  AppearObserver.swift
//  Adwaita
//
//  Created by david-swift on 29.11.23.
//

import Libadwaita

/// A widget which executes a custom code when being rendered for the first time.
struct AppearObserver: Widget {

    /// The function.
    var onAppear: () -> Void
    /// The content.
    var content: View

    /// Get the content's container.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The content's container.
    func container(modifiers: [(View) -> View]) -> ViewStorage {
        onAppear()
        return content.storage(modifiers: modifiers)
    }

    /// Update the content.
    /// - Parameters:
    ///     - storage: The content's storage.
    ///     - modifiers: Modify views before being updated.
    func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        content.updateStorage(storage, modifiers: modifiers)
    }

}

extension View {

    /// Run a function when the view appears for the first time.
    /// - Parameter closure: The function.
    /// - Returns: A view.
    public func onAppear(_ closure: @escaping () -> Void) -> View {
        AppearObserver(onAppear: closure, content: self)
    }

}