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
    var onAppear: (NativeWidgetPeer) -> Void
    /// The content.
    var content: View

    /// Get the content's container.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The content's container.
    func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = content.storage(modifiers: modifiers)
        onAppear(storage.view)
        return storage
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

    /// Run a function on the widget when it appears for the first time.
    /// - Parameter closure: The function.
    /// - Returns: A view.
    public func inspectOnAppear(_ closure: @escaping (NativeWidgetPeer) -> Void) -> View {
        AppearObserver(onAppear: closure, content: self)
    }

    /// Run a function when the view appears for the first time.
    /// - Parameter closure: The function.
    /// - Returns: A view.
    public func onAppear(_ closure: @escaping () -> Void) -> View {
        inspectOnAppear { _ in closure() }
    }

    /// Run a function when the widget gets clicked.
    /// - Parameter handler: The function.
    /// - Returns: A view.
    public func onClick(handler: @escaping () -> Void) -> View {
        inspectOnAppear { _ = $0.onClick(closure: handler) }
    }

}
