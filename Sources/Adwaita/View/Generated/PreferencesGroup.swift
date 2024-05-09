//
//  PreferencesGroup.swift
//  Adwaita
//
//  Created by auto-generation on 09.05.24.
//

import CAdw
import LevenshteinTransformations

/// A group of preference rows.
/// 
/// <picture><source srcset="preferences-group-dark.png" media="(prefers-color-scheme: dark)"><img src="preferences-group.png" alt="preferences-group"></picture>
/// 
/// An `AdwPreferencesGroup` represents a group or tightly related preferences,
/// which in turn are represented by [class@PreferencesRow].
/// 
/// To summarize the role of the preferences it gathers, a group can have both a
/// title and a description. The title will be used by [class@PreferencesDialog]
/// to let the user look for a preference.
/// 
/// ## AdwPreferencesGroup as GtkBuildable
/// 
/// The `AdwPreferencesGroup` implementation of the [iface@Gtk.Buildable] interface
/// supports adding [class@PreferencesRow]s to the list by omitting "type". If "type"
/// is omitted and the widget isn't a [class@PreferencesRow] the child is added to
/// a box below the list.
/// 
/// When the "type" attribute of a child is `header-suffix`, the child
/// is set as the suffix on the end of the title and description.
/// 
/// ## CSS nodes
/// 
/// `AdwPreferencesGroup` has a single CSS node with name `preferencesgroup`.
/// 
/// ## Accessibility
/// 
/// `AdwPreferencesGroup` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
public struct PreferencesGroup: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(View) -> View], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(View) -> View]) -> Void] = []

    /// The description for this group of preferences.
    var description: String?
    /// The header suffix widget.
    /// 
    /// Displayed above the list, next to the title and description.
    /// 
    /// Suffixes are commonly used to show a button or a spinner for the whole
    /// group.
    var headerSuffix:  (() -> Body)?
    /// The title for this group of preferences.
    var title: String?
    /// The body for the widget "child".
    var child: () -> Body = { [] }
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `PreferencesGroup`.
    public init() {
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(adw_preferences_group_new()?.opaque())
        for function in appearFunctions {
            function(storage, modifiers)
        }
        update(storage, modifiers: modifiers, updateProperties: true)
        if let headerSuffixStorage = headerSuffix?().widget(modifiers: modifiers).storage(modifiers: modifiers) {
            storage.content["headerSuffix"] = [headerSuffixStorage]
            adw_preferences_group_set_header_suffix(storage.pointer?.cast(), headerSuffixStorage.pointer?.cast())
        }

        var childStorage: [ViewStorage] = []
        for view in child() {
            childStorage.append(view.storage(modifiers: modifiers))
            adw_preferences_group_add(storage.pointer?.cast(), childStorage.last?.pointer?.cast())
        }
        storage.content["child"] = childStorage
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
                adw_preferences_group_set_description(widget?.cast(), description)
            }
            if let widget = storage.content["headerSuffix"]?.first {
                headerSuffix?().widget(modifiers: modifiers).update(widget, modifiers: modifiers, updateProperties: updateProperties)
            }
            if let title, updateProperties {
                adw_preferences_group_set_title(widget?.cast(), title)
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
            function(storage, modifiers, updateProperties)
        }
    }

    /// The description for this group of preferences.
    public func description(_ description: String?) -> Self {
        var newSelf = self
        newSelf.description = description
        
        return newSelf
    }

    /// The header suffix widget.
    /// 
    /// Displayed above the list, next to the title and description.
    /// 
    /// Suffixes are commonly used to show a button or a spinner for the whole
    /// group.
    public func headerSuffix(@ViewBuilder _ headerSuffix: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.headerSuffix = headerSuffix
        
        return newSelf
    }

    /// The title for this group of preferences.
    public func title(_ title: String?) -> Self {
        var newSelf = self
        newSelf.title = title
        
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
