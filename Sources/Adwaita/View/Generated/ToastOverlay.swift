//
//  ToastOverlay.swift
//  Adwaita
//
//  Created by auto-generation on 15.08.24.
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
    var updateFunctions: [(ViewStorage, WidgetData, Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, WidgetData) -> Void] = []

    /// The child widget.
    var child: (() -> Body)?

    /// Initialize `ToastOverlay`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The view render data type.
    /// - Returns: The view storage.
    public func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_toast_overlay_new()?.opaque())
        for function in appearFunctions {
            function(storage, data)
        }
        update(storage, data: data, updateProperties: true, type: type)
        if let childStorage = child?().storage(data: data, type: type) {
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
    ///     - type: The view render data type.
    public func update<Data>(_ storage: ViewStorage, data: WidgetData, updateProperties: Bool, type: Data.Type) where Data: ViewRenderData {
        storage.modify { widget in

            if let widget = storage.content["child"]?.first {
                child?().updateStorage(widget, data: data, updateProperties: updateProperties, type: type)
            }


        }
        for function in updateFunctions {
            function(storage, data, updateProperties)
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
