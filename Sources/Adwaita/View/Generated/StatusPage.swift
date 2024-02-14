//
//  StatusPage.swift
//  Adwaita
//
//  Created by auto-generation on 14.02.24.
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
public struct StatusPage: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage) -> Void] = []

    /// The child widget.
    var child:  (() -> Body)?
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
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `StatusPage`.
    public init() {
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(adw_status_page_new()?.opaque())
        update(storage, modifiers: modifiers, updateProperties: true)
        if let childStorage = child?().widget(modifiers: modifiers).storage(modifiers: modifiers) {
            storage.content["child"] = [childStorage]
            adw_status_page_set_child(storage.pointer, childStorage.pointer?.cast())
        }


        for function in appearFunctions {
            function(storage)
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
            if let description, updateProperties {
                adw_status_page_set_description(widget, description)
            }
            if let iconName, updateProperties {
                adw_status_page_set_icon_name(widget, iconName)
            }
            if let title, updateProperties {
                adw_status_page_set_title(widget, title)
            }


        }
        for function in updateFunctions {
            function(storage)
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
