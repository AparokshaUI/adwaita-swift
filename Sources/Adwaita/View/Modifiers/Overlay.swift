//
//  Overlay.swift
//  Adwaita
//
//  Created by david-swift on 03.01.24.
//

import Libadwaita

/// A wrapper around a view for adding other views on top.
struct Overlay: Widget {

    /// The child view.
    var child: View
    /// The overlay view.
    var overlay: Body

    /// The identifier for the overlay content.
    let overlayID = "overlay"

    /// Get the overlay's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    func container(modifiers: [(View) -> View]) -> ViewStorage {
        let contentStorage = child.storage(modifiers: modifiers)
        let overlayStorage = overlay.widget(modifiers: modifiers).storage(modifiers: modifiers)
        let overlay = Libadwaita.Overlay().child(contentStorage.view).addOverlay(overlayStorage.view)
        return .init(overlay, content: [.mainContent: [contentStorage], overlayID: [overlayStorage]])
    }

    /// Update the overlay's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: The view modifiers.
    func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let storage = storage.content[.mainContent]?.first {
            child.updateStorage(storage, modifiers: modifiers)
        }
        if let storage = storage.content[overlayID]?.first {
            overlay.widget(modifiers: modifiers).update(storage, modifiers: modifiers)
        }
    }

}

extension View {

    /// Add an overlay view.
    /// - Parameters:
    ///     - overlay: The overlay view.
    /// - Returns: A view.
    public func overlay(@ViewBuilder _ overlay: @escaping () -> Body) -> View {
        Overlay(child: self, overlay: overlay())
    }

}
