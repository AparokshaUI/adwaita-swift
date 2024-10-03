//
//  Bin.swift
//  Adwaita
//
//  Created by auto-generation on 15.08.24.
//

import CAdw
import LevenshteinTransformations

/// A widget with one child.
/// 
/// <picture><source srcset="bin-dark.png" media="(prefers-color-scheme: dark)"><img src="bin.png" alt="bin"></picture>
/// 
/// The `AdwBin` widget has only one child, set with the [property@Bin:child]
/// property.
/// 
/// It is useful for deriving subclasses, since it provides common code needed
/// for handling a single child widget.
public struct Bin: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, WidgetData, Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, WidgetData) -> Void] = []

    /// The child widget of the `AdwBin`.
    var child: (() -> Body)?

    /// Initialize `Bin`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The view render data type.
    /// - Returns: The view storage.
    public func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_bin_new()?.opaque())
        for function in appearFunctions {
            function(storage, data)
        }
        update(storage, data: data, updateProperties: true, type: type)
        if let childStorage = child?().storage(data: data, type: type) {
            storage.content["child"] = [childStorage]
            adw_bin_set_child(storage.opaquePointer?.cast(), childStorage.opaquePointer?.cast())
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

    /// The child widget of the `AdwBin`.
    public func child(@ViewBuilder _ child: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.child = child
        
        return newSelf
    }

}
