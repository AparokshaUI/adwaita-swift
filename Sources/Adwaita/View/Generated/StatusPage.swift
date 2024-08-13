//
//  StatusPage.swift
//  Adwaita
//
//  Created by auto-generation on 03.08.24.
//

import CAdw
import LevenshteinTransformations

/// A page used for empty/error states and similar use-cases.
/// 
/// <picture><source srcset="status-page-dark.png" media="(prefers-color-scheme: dark)"><img src="status-page.png" alt="status-page"></picture>
/// 
/// The `AdwStatusPage` widget can have an icon, a title, a description and a
/// custom widget which is displayed below them.
/// 
/// ## CSS nodes
/// 
/// `AdwStatusPage` has a main CSS node with name `statuspage`.
/// 
/// `AdwStatusPage` can use the
/// [`.compact`](style-classes.html#compact-status-page) style class for when it
/// needs to fit into a small space such a sidebar or a popover.
public struct StatusPage: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(AnyView) -> AnyView], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(AnyView) -> AnyView]) -> Void] = []

    /// The child widget.
    var child: (() -> Body)?
    /// The description markup to be displayed below the title.
    var description: String?
    /// The name of the icon to be used.
    /// 
    /// Changing this will set [property@StatusPage:paintable] to `NULL`.
    var iconName: String?
    /// The title to be displayed below the icon.
    /// 
    /// It is not parsed as Pango markup.
    var title: String?
    /// The application.
    var app: AdwaitaApp?
    /// The window.
    var window: AdwaitaWindow?

    /// Initialize `StatusPage`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(modifiers: [(AnyView) -> AnyView], type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_status_page_new()?.opaque())
        for function in appearFunctions {
            function(storage, modifiers)
        }
        update(storage, modifiers: modifiers, updateProperties: true, type: type)
        if let childStorage = child?().storage(modifiers: modifiers, type: type) {
            storage.content["child"] = [childStorage]
            adw_status_page_set_child(storage.opaquePointer, childStorage.opaquePointer?.cast())
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
            if let description, updateProperties, (storage.previousState as? Self)?.description != description {
                adw_status_page_set_description(widget, description)
            }
            if let iconName, updateProperties, (storage.previousState as? Self)?.iconName != iconName {
                adw_status_page_set_icon_name(widget, iconName)
            }
            if let title, updateProperties, (storage.previousState as? Self)?.title != title {
                adw_status_page_set_title(widget, title)
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

    /// The description markup to be displayed below the title.
    public func description(_ description: String?) -> Self {
        var newSelf = self
        newSelf.description = description
        
        return newSelf
    }

    /// The name of the icon to be used.
    /// 
    /// Changing this will set [property@StatusPage:paintable] to `NULL`.
    public func iconName(_ iconName: String?) -> Self {
        var newSelf = self
        newSelf.iconName = iconName
        
        return newSelf
    }

    /// The title to be displayed below the icon.
    /// 
    /// It is not parsed as Pango markup.
    public func title(_ title: String?) -> Self {
        var newSelf = self
        newSelf.title = title
        
        return newSelf
    }

}
