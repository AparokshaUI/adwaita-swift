//
//  ExpanderRow.swift
//  Adwaita
//
//  Created by auto-generation on 03.08.24.
//

import CAdw
import LevenshteinTransformations

/// A [class@Gtk.ListBoxRow] used to reveal widgets.
/// 
/// <picture><source srcset="expander-row-dark.png" media="(prefers-color-scheme: dark)"><img src="expander-row.png" alt="expander-row"></picture>
/// 
/// The `AdwExpanderRow` widget allows the user to reveal or hide widgets below
/// it. It also allows the user to enable the expansion of the row, allowing to
/// disable all that the row contains.
/// 
/// ## AdwExpanderRow as GtkBuildable
/// 
/// The `AdwExpanderRow` implementation of the [iface@Gtk.Buildable] interface
/// supports adding a child as an suffix widget by specifying “suffix” as the
/// “type” attribute of a <child> element.
/// 
/// It also supports adding it as a prefix widget by specifying “prefix” as the
/// “type” attribute of a <child> element.
/// 
/// ## CSS nodes
/// 
/// `AdwExpanderRow` has a main CSS node with name `row` and the `.expander`
/// style class. It has the `.empty` style class when it contains no children.
/// 
/// It contains the subnodes `row.header` for its main embedded row,
/// `list.nested` for the list it can expand, and `image.expander-row-arrow` for
/// its arrow.
public struct ExpanderRow: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(AnyView) -> AnyView], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(AnyView) -> AnyView]) -> Void] = []

    /// Whether expansion is enabled.
    var enableExpansion: Binding<Bool>?
    /// Whether the row is expanded.
    var expanded: Binding<Bool>?
    /// Whether the switch enabling the expansion is visible.
    var showEnableSwitch: Bool?
    /// The subtitle for this row.
    /// 
    /// The subtitle is interpreted as Pango markup unless
    /// [property@PreferencesRow:use-markup] is set to `FALSE`.
    var subtitle: String?
    /// The number of lines at the end of which the subtitle label will be
    /// ellipsized.
    /// 
    /// If the value is 0, the number of lines won't be limited.
    var subtitleLines: Int?
    /// The title of the preference represented by this row.
    /// 
    /// The title is interpreted as Pango markup unless
    /// [property@PreferencesRow:use-markup] is set to `FALSE`.
    var title: String?
    /// The number of lines at the end of which the title label will be ellipsized.
    /// 
    /// If the value is 0, the number of lines won't be limited.
    var titleLines: Int?
    /// Whether the user can copy the title from the label.
    /// 
    /// See also [property@Gtk.Label:selectable].
    var titleSelectable: Bool?
    /// Whether to use Pango markup for the title label.
    /// 
    /// Subclasses may also use it for other labels, such as subtitle.
    /// 
    /// See also [func@Pango.parse_markup].
    var useMarkup: Bool?
    /// Whether an embedded underline in the title indicates a mnemonic.
    var useUnderline: Bool?
    /// The body for the widget "rows".
    var rows: () -> Body = { [] }
    /// The body for the widget "suffix".
    var suffix: () -> Body = { [] }
    /// The body for the widget "prefix".
    var prefix: () -> Body = { [] }
    /// The application.
    var app: AdwaitaApp?
    /// The window.
    var window: AdwaitaWindow?

    /// Initialize `ExpanderRow`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(modifiers: [(AnyView) -> AnyView], type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_expander_row_new()?.opaque())
        for function in appearFunctions {
            function(storage, modifiers)
        }
        update(storage, modifiers: modifiers, updateProperties: true, type: type)

        var rowsStorage: [ViewStorage] = []
        for view in rows() {
            rowsStorage.append(view.storage(modifiers: modifiers, type: type))
            adw_expander_row_add_row(storage.opaquePointer?.cast(), rowsStorage.last?.opaquePointer?.cast())
        }
        storage.content["rows"] = rowsStorage
        var suffixStorage: [ViewStorage] = []
        for view in suffix() {
            suffixStorage.append(view.storage(modifiers: modifiers, type: type))
            adw_expander_row_add_suffix(storage.opaquePointer?.cast(), suffixStorage.last?.opaquePointer?.cast())
        }
        storage.content["suffix"] = suffixStorage
        var prefixStorage: [ViewStorage] = []
        for view in prefix() {
            prefixStorage.append(view.storage(modifiers: modifiers, type: type))
            adw_expander_row_add_prefix(storage.opaquePointer?.cast(), prefixStorage.last?.opaquePointer?.cast())
        }
        storage.content["prefix"] = prefixStorage
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

        storage.notify(name: "enable-expansion") {
            let newValue = adw_expander_row_get_enable_expansion(storage.opaquePointer?.cast()) != 0
if let enableExpansion, newValue != enableExpansion.wrappedValue {
    enableExpansion.wrappedValue = newValue
}
        }
        storage.notify(name: "expanded") {
            let newValue = adw_expander_row_get_expanded(storage.opaquePointer?.cast()) != 0
if let expanded, newValue != expanded.wrappedValue {
    expanded.wrappedValue = newValue
}
        }
            if let enableExpansion, updateProperties, (adw_expander_row_get_enable_expansion(storage.opaquePointer?.cast()) != 0) != enableExpansion.wrappedValue {
                adw_expander_row_set_enable_expansion(storage.opaquePointer?.cast(), enableExpansion.wrappedValue.cBool)
            }
            if let expanded, updateProperties, (adw_expander_row_get_expanded(storage.opaquePointer?.cast()) != 0) != expanded.wrappedValue {
                adw_expander_row_set_expanded(storage.opaquePointer?.cast(), expanded.wrappedValue.cBool)
            }
            if let showEnableSwitch, updateProperties, (storage.previousState as? Self)?.showEnableSwitch != showEnableSwitch {
                adw_expander_row_set_show_enable_switch(widget?.cast(), showEnableSwitch.cBool)
            }
            if let subtitle, updateProperties, (storage.previousState as? Self)?.subtitle != subtitle {
                adw_expander_row_set_subtitle(widget?.cast(), subtitle)
            }
            if let subtitleLines, updateProperties, (storage.previousState as? Self)?.subtitleLines != subtitleLines {
                adw_expander_row_set_subtitle_lines(widget?.cast(), subtitleLines.cInt)
            }
            if let title, updateProperties, (storage.previousState as? Self)?.title != title {
                adw_preferences_row_set_title(widget?.cast(), title)
            }
            if let titleLines, updateProperties, (storage.previousState as? Self)?.titleLines != titleLines {
                adw_expander_row_set_title_lines(widget?.cast(), titleLines.cInt)
            }
            if let titleSelectable, updateProperties, (storage.previousState as? Self)?.titleSelectable != titleSelectable {
                adw_preferences_row_set_title_selectable(widget?.cast(), titleSelectable.cBool)
            }
            if let useMarkup, updateProperties, (storage.previousState as? Self)?.useMarkup != useMarkup {
                adw_preferences_row_set_use_markup(widget?.cast(), useMarkup.cBool)
            }
            if let useUnderline, updateProperties, (storage.previousState as? Self)?.useUnderline != useUnderline {
                adw_preferences_row_set_use_underline(widget?.cast(), useUnderline.cBool)
            }

            if let rowsStorage = storage.content["rows"] {
                for (index, view) in rows().enumerated() {
                    if let storage = rowsStorage[safe: index] {
                        view.updateStorage(
                            storage,
                            modifiers: modifiers,
                            updateProperties: updateProperties,
                            type: type
                        )
                    }
                }
            }
            if let suffixStorage = storage.content["suffix"] {
                for (index, view) in suffix().enumerated() {
                    if let storage = suffixStorage[safe: index] {
                        view.updateStorage(
                            storage,
                            modifiers: modifiers,
                            updateProperties: updateProperties,
                            type: type
                        )
                    }
                }
            }
            if let prefixStorage = storage.content["prefix"] {
                for (index, view) in prefix().enumerated() {
                    if let storage = prefixStorage[safe: index] {
                        view.updateStorage(
                            storage,
                            modifiers: modifiers,
                            updateProperties: updateProperties,
                            type: type
                        )
                    }
                }
            }

        }
        for function in updateFunctions {
            function(storage, modifiers, updateProperties)
        }
        if updateProperties {
            storage.previousState = self
        }
    }

    /// Whether expansion is enabled.
    public func enableExpansion(_ enableExpansion: Binding<Bool>?) -> Self {
        var newSelf = self
        newSelf.enableExpansion = enableExpansion
        
        return newSelf
    }

    /// Whether the row is expanded.
    public func expanded(_ expanded: Binding<Bool>?) -> Self {
        var newSelf = self
        newSelf.expanded = expanded
        
        return newSelf
    }

    /// Whether the switch enabling the expansion is visible.
    public func showEnableSwitch(_ showEnableSwitch: Bool? = true) -> Self {
        var newSelf = self
        newSelf.showEnableSwitch = showEnableSwitch
        
        return newSelf
    }

    /// The subtitle for this row.
    /// 
    /// The subtitle is interpreted as Pango markup unless
    /// [property@PreferencesRow:use-markup] is set to `FALSE`.
    public func subtitle(_ subtitle: String?) -> Self {
        var newSelf = self
        newSelf.subtitle = subtitle
        
        return newSelf
    }

    /// The number of lines at the end of which the subtitle label will be
    /// ellipsized.
    /// 
    /// If the value is 0, the number of lines won't be limited.
    public func subtitleLines(_ subtitleLines: Int?) -> Self {
        var newSelf = self
        newSelf.subtitleLines = subtitleLines
        
        return newSelf
    }

    /// The title of the preference represented by this row.
    /// 
    /// The title is interpreted as Pango markup unless
    /// [property@PreferencesRow:use-markup] is set to `FALSE`.
    public func title(_ title: String?) -> Self {
        var newSelf = self
        newSelf.title = title
        
        return newSelf
    }

    /// The number of lines at the end of which the title label will be ellipsized.
    /// 
    /// If the value is 0, the number of lines won't be limited.
    public func titleLines(_ titleLines: Int?) -> Self {
        var newSelf = self
        newSelf.titleLines = titleLines
        
        return newSelf
    }

    /// Whether the user can copy the title from the label.
    /// 
    /// See also [property@Gtk.Label:selectable].
    public func titleSelectable(_ titleSelectable: Bool? = true) -> Self {
        var newSelf = self
        newSelf.titleSelectable = titleSelectable
        
        return newSelf
    }

    /// Whether to use Pango markup for the title label.
    /// 
    /// Subclasses may also use it for other labels, such as subtitle.
    /// 
    /// See also [func@Pango.parse_markup].
    public func useMarkup(_ useMarkup: Bool? = true) -> Self {
        var newSelf = self
        newSelf.useMarkup = useMarkup
        
        return newSelf
    }

    /// Whether an embedded underline in the title indicates a mnemonic.
    public func useUnderline(_ useUnderline: Bool? = true) -> Self {
        var newSelf = self
        newSelf.useUnderline = useUnderline
        
        return newSelf
    }

    /// Set the body for "rows".
    /// - Parameter body: The body.
    /// - Returns: The widget.
    public func rows(@ViewBuilder _ body: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.rows = body
        return newSelf
    }
    /// Set the body for "suffix".
    /// - Parameter body: The body.
    /// - Returns: The widget.
    public func suffix(@ViewBuilder _ body: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.suffix = body
        return newSelf
    }
    /// Set the body for "prefix".
    /// - Parameter body: The body.
    /// - Returns: The widget.
    public func prefix(@ViewBuilder _ body: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.prefix = body
        return newSelf
    }
}
