//
//  Clamp.swift
//  Adwaita
//
//  Created by auto-generation on 03.08.24.
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
public struct Clamp: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(AnyView) -> AnyView], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(AnyView) -> AnyView]) -> Void] = []

    /// The child widget of the `AdwClamp`.
    var child: (() -> Body)?
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
    var app: AdwaitaApp?
    /// The window.
    var window: AdwaitaWindow?

    /// Initialize `Clamp`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(modifiers: [(AnyView) -> AnyView], type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_clamp_new()?.opaque())
        for function in appearFunctions {
            function(storage, modifiers)
        }
        update(storage, modifiers: modifiers, updateProperties: true, type: type)
        if let childStorage = child?().storage(modifiers: modifiers, type: type) {
            storage.content["child"] = [childStorage]
            adw_clamp_set_child(storage.opaquePointer, childStorage.opaquePointer?.cast())
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
            if let maximumSize, updateProperties, (storage.previousState as? Self)?.maximumSize != maximumSize {
                adw_clamp_set_maximum_size(widget, maximumSize.cInt)
            }
            if let tighteningThreshold, updateProperties, (storage.previousState as? Self)?.tighteningThreshold != tighteningThreshold {
                adw_clamp_set_tightening_threshold(widget, tighteningThreshold.cInt)
            }


        }
        for function in updateFunctions {
            function(storage, modifiers, updateProperties)
        }
        if updateProperties {
            storage.previousState = self
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
