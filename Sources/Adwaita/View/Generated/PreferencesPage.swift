//
//  PreferencesPage.swift
//  Adwaita
//
//  Created by auto-generation on 27.01.24.
//

import CAdw
import LevenshteinTransformations

/// A page from [class@PreferencesWindow].
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
public struct PreferencesPage: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage) -> Void] = []

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
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `PreferencesPage`.
    public init() {
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(adw_preferences_page_new()?.opaque())
        update(storage, modifiers: modifiers, updateProperties: true)

        var childStorage: [ViewStorage] = []
        for view in child() {
            childStorage.append(view.storage(modifiers: modifiers))
            adw_preferences_group_add(storage.pointer?.cast(), childStorage.last?.pointer?.cast())
        }
        storage.content["child"] = childStorage

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
            if let description, updateProperties {
                adw_preferences_page_set_description(widget?.cast(), description)
            }
            if let iconName, updateProperties {
                adw_preferences_page_set_icon_name(widget?.cast(), iconName)
            }
            if let name, updateProperties {
                adw_preferences_page_set_name(widget?.cast(), name)
            }
            if let title, updateProperties {
                adw_preferences_page_set_title(widget?.cast(), title)
            }
            if let useUnderline, updateProperties {
                adw_preferences_page_set_use_underline(widget?.cast(), useUnderline.cBool)
            }

            if let childStorage = storage.content["child"] {
                for (index, view) in child().enumerated() {
                    if let storage = childStorage[safe: index] {
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
            function(storage)
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
