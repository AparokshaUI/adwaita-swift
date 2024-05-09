//
//  Box.swift
//  Adwaita
//
//  Created by auto-generation on 09.05.24.
//

import CAdw
import LevenshteinTransformations

/// The `GtkBox` widget arranges child widgets into a single row or column.
/// 
/// ![An example GtkBox](box.png)
/// 
/// Whether it is a row or column depends on the value of its
/// [property@Gtk.Orientable:orientation] property. Within the other
/// dimension, all children are allocated the same size. Of course, the
/// [property@Gtk.Widget:halign] and [property@Gtk.Widget:valign] properties
/// can be used on the children to influence their allocation.
/// 
/// Use repeated calls to [method@Gtk.Box.append] to pack widgets into a
/// `GtkBox` from start to end. Use [method@Gtk.Box.remove] to remove widgets
/// from the `GtkBox`. [method@Gtk.Box.insert_child_after] can be used to add
/// a child at a particular position.
/// 
/// Use [method@Gtk.Box.set_homogeneous] to specify whether or not all children
/// of the `GtkBox` are forced to get the same amount of space.
/// 
/// Use [method@Gtk.Box.set_spacing] to determine how much space will be minimally
/// placed between all children in the `GtkBox`. Note that spacing is added
/// *between* the children.
/// 
/// Use [method@Gtk.Box.reorder_child_after] to move a child to a different
/// place in the box.
/// 
/// # CSS nodes
/// 
/// `GtkBox` uses a single CSS node with name box.
/// 
/// # Accessibility
/// 
/// Until GTK 4.10, `GtkBox` used the `GTK_ACCESSIBLE_ROLE_GROUP` role.
/// 
/// Starting from GTK 4.12, `GtkBox` uses the `GTK_ACCESSIBLE_ROLE_GENERIC` role.
public struct Box: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(View) -> View], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(View) -> View]) -> Void] = []

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    var accessibleRole: String?
    /// The child that determines the baseline, in vertical orientation.
    var baselineChild: Int?
    /// Whether the children should all be the same size.
    var homogeneous: Bool?
    /// The amount of space between children.
    var spacing: Int
    /// The body for the widget "append".
    var append: () -> Body = { [] }
    /// The body for the widget "prepend".
    var prepend: () -> Body = { [] }
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `Box`.
    public init(spacing: Int) {
        self.spacing = spacing
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(gtk_box_new(GTK_ORIENTATION_VERTICAL, spacing.cInt)?.opaque())
        for function in appearFunctions {
            function(storage, modifiers)
        }
        update(storage, modifiers: modifiers, updateProperties: true)

        var appendStorage: [ViewStorage] = []
        for view in append() {
            appendStorage.append(view.storage(modifiers: modifiers))
            gtk_box_append(storage.pointer?.cast(), appendStorage.last?.pointer?.cast())
        }
        storage.content["append"] = appendStorage
        var prependStorage: [ViewStorage] = []
        for view in prepend() {
            prependStorage.append(view.storage(modifiers: modifiers))
            gtk_box_prepend(storage.pointer?.cast(), prependStorage.last?.pointer?.cast())
        }
        storage.content["prepend"] = prependStorage
        return storage
    }

    /// Update the widget's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: The view modifiers.
    ///     - updateProperties: Whether to update the view's properties.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
        storage.modify { widget in

            if let baselineChild, updateProperties {
                gtk_box_set_baseline_child(widget?.cast(), baselineChild.cInt)
            }
            if let homogeneous, updateProperties {
                gtk_box_set_homogeneous(widget?.cast(), homogeneous.cBool)
            }
            if updateProperties {
                gtk_box_set_spacing(widget?.cast(), spacing.cInt)
            }

            if let appendStorage = storage.content["append"] {
                for (index, view) in append().enumerated() {
                    if let storage = appendStorage[safe: index] {
                        view.updateStorage(
                            storage,
                            modifiers: modifiers,
                            updateProperties: updateProperties
                        )
                    }
                }
            }
            if let prependStorage = storage.content["prepend"] {
                for (index, view) in prepend().enumerated() {
                    if let storage = prependStorage[safe: index] {
                        view.updateStorage(
                            storage,
                            modifiers: modifiers,
                            updateProperties: updateProperties
                        )
                    }
                }
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

    /// The child that determines the baseline, in vertical orientation.
    public func baselineChild(_ baselineChild: Int?) -> Self {
        var newSelf = self
        newSelf.baselineChild = baselineChild
        
        return newSelf
    }

    /// Whether the children should all be the same size.
    public func homogeneous(_ homogeneous: Bool? = true) -> Self {
        var newSelf = self
        newSelf.homogeneous = homogeneous
        
        return newSelf
    }

    /// The amount of space between children.
    public func spacing(_ spacing: Int) -> Self {
        var newSelf = self
        newSelf.spacing = spacing
        
        return newSelf
    }

    /// Set the body for "append".
    /// - Parameter body: The body.
    /// - Returns: The widget.
    public func append(@ViewBuilder _ body: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.append = body
        return newSelf
    }
    /// Set the body for "prepend".
    /// - Parameter body: The body.
    /// - Returns: The widget.
    public func prepend(@ViewBuilder _ body: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.prepend = body
        return newSelf
    }
}
