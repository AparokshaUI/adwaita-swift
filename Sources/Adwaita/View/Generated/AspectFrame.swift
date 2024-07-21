//
//  AspectFrame.swift
//  Adwaita
//
//  Created by auto-generation on 21.07.24.
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
public struct AspectFrame: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(View) -> View], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(View) -> View]) -> Void] = []

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    var accessibleRole: String?
    /// The child widget.
    var child:  (() -> Body)?
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
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `AspectFrame`.
    public init(ratio: Float) {
        self.ratio = ratio
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(gtk_aspect_frame_new(0.5, 0.5, ratio, 0)?.opaque())
        for function in appearFunctions {
            function(storage, modifiers)
        }
        update(storage, modifiers: modifiers, updateProperties: true)
        if let childStorage = child?().widget(modifiers: modifiers).storage(modifiers: modifiers) {
            storage.content["child"] = [childStorage]
            gtk_aspect_frame_set_child(storage.pointer, childStorage.pointer?.cast())
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
            if let obeyChild, updateProperties {
                gtk_aspect_frame_set_obey_child(widget, obeyChild.cBool)
            }
            if updateProperties {
                gtk_aspect_frame_set_ratio(widget, ratio)
            }
            if let xalign, updateProperties {
                gtk_aspect_frame_set_xalign(widget, xalign)
            }
            if let yalign, updateProperties {
                gtk_aspect_frame_set_yalign(widget, yalign)
            }


        }
        for function in updateFunctions {
            function(storage, modifiers, updateProperties)
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
