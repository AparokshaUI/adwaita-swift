//
//  MenuButton.swift
//  Adwaita
//
//  Created by david-swift on 22.10.23.
//

import CAdw

/// A button widget for menus.
public struct MenuButton: MenuWidget {

    /// The button's label.
    var label: String
    /// The button's action handler.
    var handler: () -> Void
    /// The keyboard shortcut.
    var shortcut = ""
    /// Whether to prefer adding the action to the application window.
    var preferApplicationWindow: Bool

    /// The action label.
    var filteredLabel: String { label.filter { $0.isLetter || $0.isNumber || $0 == "-" || $0 == "." } }

    /// Initialize a menu button.
    /// - Parameters:
    ///   - label: The buttons label.
    ///   - window: Whether to prefer adding the action to the application window.
    ///   - handler: The button's action handler.
    public init(_ label: String, window: Bool = true, handler: @escaping () -> Void) {
        self.label = label
        preferApplicationWindow = window
        self.handler = handler
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify the views before updating.
    ///     - type: The type of the views.
    /// - Returns: The view storage.
    public func container<Data>(
        modifiers: [(any AnyView) -> any AnyView],
        type: Data.Type
    ) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(nil)
        let getItem: (AdwaitaApp, AdwaitaWindow?) -> OpaquePointer? = { app, window in
            var label = filteredLabel
            storage.fields["app"] = app
            if let window, preferApplicationWindow {
                app.addKeyboardShortcut(shortcut, id: filteredLabel, window: window, handler: handler)
                label = "win." + label
                storage.fields["window"] = window
            } else {
                app.addKeyboardShortcut(shortcut, id: filteredLabel, handler: handler)
                label = "app." + label
            }
            return g_menu_item_new(self.label, label)
        }
        storage.pointer = getItem
        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify the views before updating.
    ///     - updateProperties: Whether to update the properties.
    ///     - type: The type of the views.
    public func update<Data>(
        _ storage: ViewStorage,
        modifiers: [(AnyView) -> AnyView],
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        guard let app = storage.fields["app"] as? AdwaitaApp else {
            return
        }
        if let window = storage.fields["window"] as? AdwaitaWindow, preferApplicationWindow {
            app.addKeyboardShortcut(shortcut, id: filteredLabel, window: window, handler: handler)
        } else {
            app.addKeyboardShortcut(shortcut, id: filteredLabel, handler: handler)
        }
    }

    /// Create a keyboard shortcut for an application from a button.
    ///
    /// Note that the keyboard shortcut is available after the view has been visible for the first time.
    /// - Parameter shortcut: The keyboard shortcut.
    /// - Returns: The button.
    public func keyboardShortcut(_ shortcut: String) -> Self {
        modify { $0.shortcut = shortcut }
    }

}
