//
//  ToastOverlay.swift
//  Adwaita
//
//  Created by david-swift on 30.11.23.
//

import Libadwaita

/// A wrapper around a view presenting toasts.
struct ToastOverlay: Widget {

    /// The signal for showing the toast./// Present a toast when the signal gets activated.
    var signal: Signal
    /// The child view.
    var child: View
    /// The title of the toast.
    var title: String
    /// Information about the button if available (label and handler).
    var button: (String, () -> Void)?

    /// Get the overlay's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    func container(modifiers: [(View) -> View]) -> ViewStorage {
        let contentStorage = child.widget(modifiers: modifiers).storage(modifiers: modifiers)
        let overlay = Libadwaita.ToastOverlay(contentStorage.view)
        setVisibility(overlay)
        return .init(overlay, content: [.mainContent: [contentStorage]])
    }

    /// Update the overlay's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: The view modifiers.
    func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let overlay = storage.view as? Libadwaita.ToastOverlay {
            setVisibility(overlay)
        }
        if let storage = storage.content[.mainContent]?.first {
            child.widget(modifiers: modifiers).update(storage, modifiers: modifiers)
        }
    }

    /// Add a toast if the signal is active.
    /// - Parameter overlay: The toast overlay.
    func setVisibility(_ overlay: Libadwaita.ToastOverlay) {
        if signal.update {
            let toast = Toast(title)
            if let button {
                _ = toast
                    .buttonLabel(button.0)
                    .buttonHandler(button.1)
            }
            overlay.addToast(toast)
        }
    }

}

extension View {

    /// Present a toast when the signal gets activated.
    /// - Parameters:
    ///     - title: The title of the toast.
    ///     - signal: The signal which activates the presentation of a toast.
    /// - Returns: A view.
    public func toast(_ title: String, signal: Signal) -> View {
        ToastOverlay(signal: signal, child: self, title: title)
    }

    /// Present a toast with a button when the signal gets activated.
    /// - Parameters:
    ///     - title: The title of the toast.
    ///     - signal: The signal which activates the presentation of a toast.
    ///     - button: The button's label.
    ///     - handler: The handler for the button.
    /// - Returns: A view.
    public func toast(_ title: String, signal: Signal, button: String, handler: @escaping () -> Void) -> View {
        ToastOverlay(signal: signal, child: self, title: title, button: (button, handler))
    }

}
