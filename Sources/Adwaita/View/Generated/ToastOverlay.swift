//
//  ToastOverlay.swift
//  Adwaita
//
//  Created by auto-generation on 03.08.24.
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
public struct ToastOverlay: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(AnyView) -> AnyView], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(AnyView) -> AnyView]) -> Void] = []

    /// The child widget.
    var child: (() -> Body)?
    /// The application.
    var app: AdwaitaApp?
    /// The window.
    var window: AdwaitaWindow?

    /// Initialize `ToastOverlay`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(modifiers: [(AnyView) -> AnyView], type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_toast_overlay_new()?.opaque())
        for function in appearFunctions {
            function(storage, modifiers)
        }
        update(storage, modifiers: modifiers, updateProperties: true, type: type)
        if let childStorage = child?().storage(modifiers: modifiers, type: type) {
            storage.content["child"] = [childStorage]
            adw_toast_overlay_set_child(storage.opaquePointer, childStorage.opaquePointer?.cast())
        }

        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The type of the app storage.
    public func update<Data>(_ storage: ViewStorage, modifiers: [(AnyView) -> AnyView], updateProperties: Bool, type: Data.Type) where Data: ViewRenderData {
        storage.modify { widget in

            if let widget = storage.content["child"]?.first {
                child?().updateStorage(widget, modifiers: modifiers, updateProperties: updateProperties, type: type)
            }


        }
        for function in updateFunctions {
            function(storage, modifiers, updateProperties)
        }
        if updateProperties {
            storage.previousState = self
        }
    }

    /// The child widget.
    public func child(@ViewBuilder _ child: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.child = child
        
        return newSelf
    }

}
