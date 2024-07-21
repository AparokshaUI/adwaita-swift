//
//  ToastOverlay.swift
//  Adwaita
//
//  Created by auto-generation on 21.07.24.
//

import CAdw
import LevenshteinTransformations

/// A widget showing toasts above its content.
/// 
/// <picture><source srcset="toast-overlay-dark.png" media="(prefers-color-scheme: dark)"><img src="toast-overlay.png" alt="toast-overlay"></picture>
/// 
/// Much like [class@Gtk.Overlay], `AdwToastOverlay` is a container with a single
/// main child, on top of which it can display a [class@Toast], overlaid.
/// Toasts can be shown with [method@ToastOverlay.add_toast].
/// 
/// See [class@Toast] for details.
/// 
/// ## CSS nodes
/// 
/// ```
/// toastoverlay
/// ├── [child]
/// ├── toast
/// ┊   ├── widget
/// ┊   │   ├── [label.heading]
/// │   ╰── [custom title]
/// ├── [button]
/// ╰── button.circular.flat
/// ```
/// 
/// `AdwToastOverlay`'s CSS node is called `toastoverlay`. It contains the child,
/// as well as zero or more `toast` subnodes.
/// 
/// Each of the `toast` nodes contains a `widget` subnode, optionally a `button`
/// subnode, and another `button` subnode with `.circular` and `.flat` style
/// classes.
/// 
/// The `widget` subnode contains a `label` subnode with the `.heading` style
/// class, or a custom widget provided by the application.
/// 
/// ## Accessibility
/// 
/// `AdwToastOverlay` uses the `GTK_ACCESSIBLE_ROLE_TAB_GROUP` role.
public struct ToastOverlay: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(View) -> View], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(View) -> View]) -> Void] = []

    /// The child widget.
    var child:  (() -> Body)?
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `ToastOverlay`.
    public init() {
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(adw_toast_overlay_new()?.opaque())
        for function in appearFunctions {
            function(storage, modifiers)
        }
        update(storage, modifiers: modifiers, updateProperties: true)
        if let childStorage = child?().widget(modifiers: modifiers).storage(modifiers: modifiers) {
            storage.content["child"] = [childStorage]
            adw_toast_overlay_set_child(storage.pointer, childStorage.pointer?.cast())
        }

        return storage
    }

    /// Update the widget's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: The view modifiers.
    ///     - updateProperties: Whether to update the view's properties.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
        storage.modify { widget in

            if let widget = storage.content["child"]?.first {
                child?().widget(modifiers: modifiers).update(widget, modifiers: modifiers, updateProperties: updateProperties)
            }


        }
        for function in updateFunctions {
            function(storage, modifiers, updateProperties)
        }
    }

    /// The child widget.
    public func child(@ViewBuilder _ child: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.child = child
        
        return newSelf
    }

}
