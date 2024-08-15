//
//  PreferencesPage.swift
//  Adwaita
//
//  Created by auto-generation on 15.08.24.
//

import CAdw
import LevenshteinTransformations

/// A page from [class@PreferencesDialog].
/// 
/// <picture><source srcset="preferences-page-dark.png" media="(prefers-color-scheme: dark)"><img src="preferences-page.png" alt="preferences-page"></picture>
/// 
/// The `AdwPreferencesPage` widget gathers preferences groups into a single page
/// of a preferences window.
/// 
/// ## CSS nodes
/// 
/// `AdwPreferencesPage` has a single CSS node with name `preferencespage`.
/// 
/// ## Accessibility
/// 
/// `AdwPreferencesPage` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
public struct PreferencesPage: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, WidgetData, Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, WidgetData) -> Void] = []

    /// The description to be displayed at the top of the page.
    var description: String?
    /// The icon name for this page.
    var iconName: String?
    /// The name of this page.
    var name: String?
    /// The title for this page.
    var title: String?
    /// Whether an embedded underline in the title indicates a mnemonic.
    var useUnderline: Bool?
    /// The body for the widget "child".
    var child: () -> Body = { [] }

    /// Initialize `PreferencesPage`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_preferences_page_new()?.opaque())
        for function in appearFunctions {
            function(storage, data)
        }
        update(storage, data: data, updateProperties: true, type: type)

        var childStorage: [ViewStorage] = []
        for view in child() {
            childStorage.append(view.storage(data: data, type: type))
            adw_preferences_group_add(storage.opaquePointer?.cast(), childStorage.last?.opaquePointer?.cast())
        }
        storage.content["child"] = childStorage
        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The type of the app storage.
    public func update<Data>(_ storage: ViewStorage, data: WidgetData, updateProperties: Bool, type: Data.Type) where Data: ViewRenderData {
        storage.modify { widget in

            if let description, updateProperties, (storage.previousState as? Self)?.description != description {
                adw_preferences_page_set_description(widget?.cast(), description)
            }
            if let iconName, updateProperties, (storage.previousState as? Self)?.iconName != iconName {
                adw_preferences_page_set_icon_name(widget?.cast(), iconName)
            }
            if let name, updateProperties, (storage.previousState as? Self)?.name != name {
                adw_preferences_page_set_name(widget?.cast(), name)
            }
            if let title, updateProperties, (storage.previousState as? Self)?.title != title {
                adw_preferences_page_set_title(widget?.cast(), title)
            }
            if let useUnderline, updateProperties, (storage.previousState as? Self)?.useUnderline != useUnderline {
                adw_preferences_page_set_use_underline(widget?.cast(), useUnderline.cBool)
            }

            if let childStorage = storage.content["child"] {
                for (index, view) in child().enumerated() {
                    if let storage = childStorage[safe: index] {
                        view.updateStorage(
                            storage,
                            data: data,
                            updateProperties: updateProperties,
                            type: type
                        )
                    }
                }
            }

        }
        for function in updateFunctions {
            function(storage, data, updateProperties)
        }
        if updateProperties {
            storage.previousState = self
        }
    }

    /// The description to be displayed at the top of the page.
    public func description(_ description: String?) -> Self {
        var newSelf = self
        newSelf.description = description
        
        return newSelf
    }

    /// The icon name for this page.
    public func iconName(_ iconName: String?) -> Self {
        var newSelf = self
        newSelf.iconName = iconName
        
        return newSelf
    }

    /// The name of this page.
    public func name(_ name: String?) -> Self {
        var newSelf = self
        newSelf.name = name
        
        return newSelf
    }

    /// The title for this page.
    public func title(_ title: String?) -> Self {
        var newSelf = self
        newSelf.title = title
        
        return newSelf
    }

    /// Whether an embedded underline in the title indicates a mnemonic.
    public func useUnderline(_ useUnderline: Bool? = true) -> Self {
        var newSelf = self
        newSelf.useUnderline = useUnderline
        
        return newSelf
    }

    /// Set the body for "child".
    /// - Parameter body: The body.
    /// - Returns: The widget.
    public func child(@ViewBuilder _ body: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.child = body
        return newSelf
    }
}
