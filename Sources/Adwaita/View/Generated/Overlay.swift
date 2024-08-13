//
//  Overlay.swift
//  Adwaita
//
//  Created by auto-generation on 03.08.24.
//

import CAdw
import LevenshteinTransformations

/// `GtkOverlay` is a container which contains a single main child, on top
/// of which it can place “overlay” widgets.
/// 
/// ![An example GtkOverlay](overlay.png)
/// 
/// The position of each overlay widget is determined by its
/// [property@Gtk.Widget:halign] and [property@Gtk.Widget:valign]
/// properties. E.g. a widget with both alignments set to %GTK_ALIGN_START
/// will be placed at the top left corner of the `GtkOverlay` container,
/// whereas an overlay with halign set to %GTK_ALIGN_CENTER and valign set
/// to %GTK_ALIGN_END will be placed a the bottom edge of the `GtkOverlay`,
/// horizontally centered. The position can be adjusted by setting the margin
/// properties of the child to non-zero values.
/// 
/// More complicated placement of overlays is possible by connecting
/// to the [signal@Gtk.Overlay::get-child-position] signal.
/// 
/// An overlay’s minimum and natural sizes are those of its main child.
/// The sizes of overlay children are not considered when measuring these
/// preferred sizes.
/// 
/// # GtkOverlay as GtkBuildable
/// 
/// The `GtkOverlay` implementation of the `GtkBuildable` interface
/// supports placing a child as an overlay by specifying “overlay” as
/// the “type” attribute of a `<child>` element.
/// 
/// # CSS nodes
/// 
/// `GtkOverlay` has a single CSS node with the name “overlay”. Overlay children
/// whose alignments cause them to be positioned at an edge get the style classes
/// “.left”, “.right”, “.top”, and/or “.bottom” according to their position.
public struct Overlay: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(AnyView) -> AnyView], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(AnyView) -> AnyView]) -> Void] = []

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    var accessibleRole: String?
    /// The main child widget.
    var child: (() -> Body)?
    /// Emitted to determine the position and size of any overlay
    /// child widgets.
    /// 
    /// A handler for this signal should fill @allocation with
    /// the desired position and size for @widget, relative to
    /// the 'main' child of @overlay.
    /// 
    /// The default handler for this signal uses the @widget's
    /// halign and valign properties to determine the position
    /// and gives the widget its natural size (except that an
    /// alignment of %GTK_ALIGN_FILL will cause the overlay to
    /// be full-width/height). If the main child is a
    /// `GtkScrolledWindow`, the overlays are placed relative
    /// to its contents.
    var getChildPosition: (() -> Void)?
    /// The body for the widget "overlay".
    var overlay: () -> Body = { [] }
    /// The application.
    var app: AdwaitaApp?
    /// The window.
    var window: AdwaitaWindow?

    /// Initialize `Overlay`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(modifiers: [(AnyView) -> AnyView], type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(gtk_overlay_new()?.opaque())
        for function in appearFunctions {
            function(storage, modifiers)
        }
        update(storage, modifiers: modifiers, updateProperties: true, type: type)
        if let childStorage = child?().storage(modifiers: modifiers, type: type) {
            storage.content["child"] = [childStorage]
            gtk_overlay_set_child(storage.opaquePointer, childStorage.opaquePointer?.cast())
        }

        var overlayStorage: [ViewStorage] = []
        for view in overlay() {
            overlayStorage.append(view.storage(modifiers: modifiers, type: type))
            gtk_overlay_add_overlay(storage.opaquePointer, overlayStorage.last?.opaquePointer?.cast())
        }
        storage.content["overlay"] = overlayStorage
        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The type of the app storage.
    public func update<Data>(_ storage: ViewStorage, modifiers: [(AnyView) -> AnyView], updateProperties: Bool, type: Data.Type) where Data: ViewRenderData {
        if let getChildPosition {
            storage.connectSignal(name: "get-child-position", argCount: 2) {
                getChildPosition()
            }
        }
        storage.modify { widget in

            if let widget = storage.content["child"]?.first {
                child?().updateStorage(widget, modifiers: modifiers, updateProperties: updateProperties, type: type)
            }

            if let overlayStorage = storage.content["overlay"] {
                for (index, view) in overlay().enumerated() {
                    if let storage = overlayStorage[safe: index] {
                        view.updateStorage(
                            storage,
                            modifiers: modifiers,
                            updateProperties: updateProperties,
                            type: type
                        )
                    }
                }
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

    /// The main child widget.
    public func child(@ViewBuilder _ child: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.child = child
        
        return newSelf
    }

    /// Emitted to determine the position and size of any overlay
    /// child widgets.
    /// 
    /// A handler for this signal should fill @allocation with
    /// the desired position and size for @widget, relative to
    /// the 'main' child of @overlay.
    /// 
    /// The default handler for this signal uses the @widget's
    /// halign and valign properties to determine the position
    /// and gives the widget its natural size (except that an
    /// alignment of %GTK_ALIGN_FILL will cause the overlay to
    /// be full-width/height). If the main child is a
    /// `GtkScrolledWindow`, the overlays are placed relative
    /// to its contents.
    public func getChildPosition(_ getChildPosition: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.getChildPosition = getChildPosition
        return newSelf
    }

    /// Set the body for "overlay".
    /// - Parameter body: The body.
    /// - Returns: The widget.
    public func overlay(@ViewBuilder _ body: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.overlay = body
        return newSelf
    }
}
