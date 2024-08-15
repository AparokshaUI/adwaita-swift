//
//  PreferencesGroup.swift
//  Adwaita
//
//  Created by auto-generation on 15.08.24.
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
public struct PreferencesGroup: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, WidgetData, Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, WidgetData) -> Void] = []

    /// The description for this group of preferences.
    var description: String?
    /// The header suffix widget.
    /// 
    /// Displayed above the list, next to the title and description.
    /// 
    /// Suffixes are commonly used to show a button or a spinner for the whole
    /// group.
    var headerSuffix: (() -> Body)?
    /// The title for this group of preferences.
    var title: String?
    /// The body for the widget "child".
    var child: () -> Body = { [] }

    /// Initialize `PreferencesGroup`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_preferences_group_new()?.opaque())
        for function in appearFunctions {
            function(storage, data)
        }
        update(storage, data: data, updateProperties: true, type: type)
        if let headerSuffixStorage = headerSuffix?().storage(data: data, type: type) {
            storage.content["headerSuffix"] = [headerSuffixStorage]
            adw_preferences_group_set_header_suffix(storage.opaquePointer?.cast(), headerSuffixStorage.opaquePointer?.cast())
        }

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
                adw_preferences_group_set_description(widget?.cast(), description)
            }
            if let widget = storage.content["headerSuffix"]?.first {
                headerSuffix?().updateStorage(widget, data: data, updateProperties: updateProperties, type: type)
            }
            if let title, updateProperties, (storage.previousState as? Self)?.title != title {
                adw_preferences_group_set_title(widget?.cast(), title)
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
