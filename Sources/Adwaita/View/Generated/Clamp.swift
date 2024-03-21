//
//  Clamp.swift
//  Adwaita
//
//  Created by auto-generation on 20.03.24.
//

import CAdw
import LevenshteinTransformations

/// A widget constraining its child to a given size.
/// 
/// <picture><source srcset="clamp-wide-dark.png" media="(prefers-color-scheme: dark)"><img src="clamp-wide.png" alt="clamp-wide"></picture><picture><source srcset="clamp-narrow-dark.png" media="(prefers-color-scheme: dark)"><img src="clamp-narrow.png" alt="clamp-narrow"></picture>
/// 
/// The `AdwClamp` widget constrains the size of the widget it contains to a
/// given maximum size. It will constrain the width if it is horizontal, or the
/// height if it is vertical. The expansion of the child from its minimum to its
/// maximum size is eased out for a smooth transition.
/// 
/// If the child requires more than the requested maximum size, it will be
/// allocated the minimum size it can fit in instead.
/// 
/// `AdwClamp` can scale with the text scale factor, use the
/// [property@ClampLayout:unit] property to enable that behavior.
/// 
/// ## CSS nodes
/// 
/// `AdwClamp` has a single CSS node with name `clamp`.
public struct Clamp: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(View) -> View], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(View) -> View]) -> Void] = []

    /// The child widget of the `AdwClamp`.
    var child:  (() -> Body)?
    /// The maximum size allocated to the child.
    /// 
    /// It is the width if the clamp is horizontal, or the height if it is vertical.
    var maximumSize: Int?
    /// The size above which the child is clamped.
    /// 
    /// Starting from this size, the clamp will tighten its grip on the child,
    /// slowly allocating less and less of the available size up to the maximum
    /// allocated size. Below that threshold and below the maximum size, the child
    /// will be allocated all the available size.
    /// 
    /// If the threshold is greater than the maximum size to allocate to the child,
    /// the child will be allocated all the size up to the maximum.
    /// If the threshold is lower than the minimum size to allocate to the child,
    /// that size will be used as the tightening threshold.
    /// 
    /// Effectively, tightening the grip on the child before it reaches its maximum
    /// size makes transitions to and from the maximum size smoother when resizing.
    var tighteningThreshold: Int?
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `Clamp`.
    public init() {
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(adw_clamp_new()?.opaque())
        update(storage, modifiers: modifiers, updateProperties: true)
        if let childStorage = child?().widget(modifiers: modifiers).storage(modifiers: modifiers) {
            storage.content["child"] = [childStorage]
            adw_clamp_set_child(storage.pointer, childStorage.pointer?.cast())
        }

        for function in appearFunctions {
            function(storage, modifiers)
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
            if let maximumSize, updateProperties {
                adw_clamp_set_maximum_size(widget, maximumSize.cInt)
            }
            if let tighteningThreshold, updateProperties {
                adw_clamp_set_tightening_threshold(widget, tighteningThreshold.cInt)
            }


        }
        for function in updateFunctions {
            function(storage, modifiers, updateProperties)
        }
    }

    /// The child widget of the `AdwClamp`.
    public func child(@ViewBuilder _ child: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.child = child
        
        return newSelf
    }

    /// The maximum size allocated to the child.
    /// 
    /// It is the width if the clamp is horizontal, or the height if it is vertical.
    public func maximumSize(_ maximumSize: Int?) -> Self {
        var newSelf = self
        newSelf.maximumSize = maximumSize
        
        return newSelf
    }

    /// The size above which the child is clamped.
    /// 
    /// Starting from this size, the clamp will tighten its grip on the child,
    /// slowly allocating less and less of the available size up to the maximum
    /// allocated size. Below that threshold and below the maximum size, the child
    /// will be allocated all the available size.
    /// 
    /// If the threshold is greater than the maximum size to allocate to the child,
    /// the child will be allocated all the size up to the maximum.
    /// If the threshold is lower than the minimum size to allocate to the child,
    /// that size will be used as the tightening threshold.
    /// 
    /// Effectively, tightening the grip on the child before it reaches its maximum
    /// size makes transitions to and from the maximum size smoother when resizing.
    public func tighteningThreshold(_ tighteningThreshold: Int?) -> Self {
        var newSelf = self
        newSelf.tighteningThreshold = tighteningThreshold
        
        return newSelf
    }

}
