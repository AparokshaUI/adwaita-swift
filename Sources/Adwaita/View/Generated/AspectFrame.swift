//
//  AspectFrame.swift
//  Adwaita
//
//  Created by auto-generation on 03.08.24.
//

import CAdw
import LevenshteinTransformations

/// `GtkAspectFrame` preserves the aspect ratio of its child.
/// 
/// The frame can respect the aspect ratio of the child widget,
/// or use its own aspect ratio.
/// 
/// # CSS nodes
/// 
/// `GtkAspectFrame` uses a CSS node with name `frame`.
/// 
/// # Accessibility
/// 
/// Until GTK 4.10, `GtkAspectFrame` used the `GTK_ACCESSIBLE_ROLE_GROUP` role.
/// 
/// Starting from GTK 4.12, `GtkAspectFrame` uses the `GTK_ACCESSIBLE_ROLE_GENERIC` role.
public struct AspectFrame: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(AnyView) -> AnyView], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(AnyView) -> AnyView]) -> Void] = []

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    var accessibleRole: String?
    /// The child widget.
    var child: (() -> Body)?
    /// Whether the `GtkAspectFrame` should use the aspect ratio of its child.
    var obeyChild: Bool?
    /// The aspect ratio to be used by the `GtkAspectFrame`.
    /// 
    /// This property is only used if
    /// [property@Gtk.AspectFrame:obey-child] is set to %FALSE.
    var ratio: Float
    /// The horizontal alignment of the child.
    var xalign: Float?
    /// The vertical alignment of the child.
    var yalign: Float?
    /// The application.
    var app: AdwaitaApp?
    /// The window.
    var window: AdwaitaWindow?

    /// Initialize `AspectFrame`.
    public init(ratio: Float) {
        self.ratio = ratio
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(modifiers: [(AnyView) -> AnyView], type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(gtk_aspect_frame_new(0.5, 0.5, ratio, 0)?.opaque())
        for function in appearFunctions {
            function(storage, modifiers)
        }
        update(storage, modifiers: modifiers, updateProperties: true, type: type)
        if let childStorage = child?().storage(modifiers: modifiers, type: type) {
            storage.content["child"] = [childStorage]
            gtk_aspect_frame_set_child(storage.opaquePointer, childStorage.opaquePointer?.cast())
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
            if let obeyChild, updateProperties, (storage.previousState as? Self)?.obeyChild != obeyChild {
                gtk_aspect_frame_set_obey_child(widget, obeyChild.cBool)
            }
            if updateProperties, (storage.previousState as? Self)?.ratio != ratio {
                gtk_aspect_frame_set_ratio(widget, ratio)
            }
            if let xalign, updateProperties, (storage.previousState as? Self)?.xalign != xalign {
                gtk_aspect_frame_set_xalign(widget, xalign)
            }
            if let yalign, updateProperties, (storage.previousState as? Self)?.yalign != yalign {
                gtk_aspect_frame_set_yalign(widget, yalign)
            }


        }
        for function in updateFunctions {
            function(storage, modifiers, updateProperties)
        }
        if updateProperties {
            storage.previousState = self
        }
    }

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    public func accessibleRole(_ accessibleRole: String?) -> Self {
        var newSelf = self
        newSelf.accessibleRole = accessibleRole
        
        return newSelf
    }

    /// The child widget.
    public func child(@ViewBuilder _ child: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.child = child
        
        return newSelf
    }

    /// Whether the `GtkAspectFrame` should use the aspect ratio of its child.
    public func obeyChild(_ obeyChild: Bool? = true) -> Self {
        var newSelf = self
        newSelf.obeyChild = obeyChild
        
        return newSelf
    }

    /// The aspect ratio to be used by the `GtkAspectFrame`.
    /// 
    /// This property is only used if
    /// [property@Gtk.AspectFrame:obey-child] is set to %FALSE.
    public func ratio(_ ratio: Float) -> Self {
        var newSelf = self
        newSelf.ratio = ratio
        
        return newSelf
    }

    /// The horizontal alignment of the child.
    public func xalign(_ xalign: Float?) -> Self {
        var newSelf = self
        newSelf.xalign = xalign
        
        return newSelf
    }

    /// The vertical alignment of the child.
    public func yalign(_ yalign: Float?) -> Self {
        var newSelf = self
        newSelf.yalign = yalign
        
        return newSelf
    }

}
