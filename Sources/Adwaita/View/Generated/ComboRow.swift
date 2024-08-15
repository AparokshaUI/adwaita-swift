//
//  ComboRow.swift
//  Adwaita
//
//  Created by auto-generation on 15.08.24.
//

import CAdw
import LevenshteinTransformations

/// A [class@Gtk.ListBoxRow] used to choose from a list of items.
/// 
/// <picture><source srcset="combo-row-dark.png" media="(prefers-color-scheme: dark)"><img src="combo-row.png" alt="combo-row"></picture>
/// 
/// The `AdwComboRow` widget allows the user to choose from a list of valid
/// choices. The row displays the selected choice. When activated, the row
/// displays a popover which allows the user to make a new choice.
/// 
/// Example of an `AdwComboRow` UI definition:
/// ```xml
/// <object class="AdwComboRow"><property name="title" translatable="yes">Combo Row</property><property name="model"><object class="GtkStringList"><items><item translatable="yes">Foo</item><item translatable="yes">Bar</item><item translatable="yes">Baz</item></items></object></property></object>
/// ```
/// 
/// The [property@ComboRow:selected] and [property@ComboRow:selected-item]
/// properties can be used to keep track of the selected item and react to their
/// changes.
/// 
/// `AdwComboRow` mirrors [class@Gtk.DropDown], see that widget for details.
/// 
/// `AdwComboRow` is [property@Gtk.ListBoxRow:activatable] if a model is set.
/// 
/// ## CSS nodes
/// 
/// `AdwComboRow` has a main CSS node with name `row` and the `.combo` style
/// class.
/// 
/// Its popover has the node named `popover` with the `.menu` style class, it
/// contains a [class@Gtk.ScrolledWindow], which in turn contains a
/// [class@Gtk.ListView], both are accessible via their regular nodes.
/// 
/// ## Accessibility
/// 
/// `AdwComboRow` uses the `GTK_ACCESSIBLE_ROLE_COMBO_BOX` role.
public struct ComboRow: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, WidgetData, Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, WidgetData) -> Void] = []

    /// The widget to activate when the row is activated.
    /// 
    /// The row can be activated either by clicking on it, calling
    /// [method@ActionRow.activate], or via mnemonics in the title.
    /// See the [property@PreferencesRow:use-underline] property to enable
    /// mnemonics.
    /// 
    /// The target widget will be activated by emitting the
    /// [signal@Gtk.Widget::mnemonic-activate] signal on it.
    var activatableWidget: (() -> Body)?
    /// Whether to show a search entry in the popup.
    /// 
    /// If set to `TRUE`, a search entry will be shown in the popup that
    /// allows to search for items in the list.
    /// 
    /// Search requires [property@ComboRow:expression] to be set.
    var enableSearch: Bool?
    /// The position of the selected item.
    /// 
    /// If no item is selected, the property has the value
    /// [const@Gtk.INVALID_LIST_POSITION]
    var selected: Binding<UInt>?
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
    /// Whether the user can copy the subtitle from the label.
    /// 
    /// See also [property@Gtk.Label:selectable].
    var subtitleSelectable: Bool?
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
    /// Whether to use the current value as the subtitle.
    /// 
    /// If you use a custom list item factory, you will need to give the row a
    /// name conversion expression with [property@ComboRow:expression].
    /// 
    /// If set to `TRUE`, you should not access [property@ActionRow:subtitle].
    /// 
    /// The subtitle is interpreted as Pango markup if
    /// [property@PreferencesRow:use-markup] is set to `TRUE`.
    var useSubtitle: Bool?
    /// Whether an embedded underline in the title indicates a mnemonic.
    var useUnderline: Bool?
    /// This signal is emitted after the row has been activated.
    var activated: (() -> Void)?
    /// The body for the widget "suffix".
    var suffix: () -> Body = { [] }
    /// The body for the widget "prefix".
    var prefix: () -> Body = { [] }

    /// Initialize `ComboRow`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_combo_row_new()?.opaque())
        for function in appearFunctions {
            function(storage, data)
        }
        update(storage, data: data, updateProperties: true, type: type)
        if let activatableWidgetStorage = activatableWidget?().storage(data: data, type: type) {
            storage.content["activatableWidget"] = [activatableWidgetStorage]
            adw_action_row_set_activatable_widget(storage.opaquePointer?.cast(), activatableWidgetStorage.opaquePointer?.cast())
        }

        var suffixStorage: [ViewStorage] = []
        for view in suffix() {
            suffixStorage.append(view.storage(data: data, type: type))
            adw_action_row_add_suffix(storage.opaquePointer?.cast(), suffixStorage.last?.opaquePointer?.cast())
        }
        storage.content["suffix"] = suffixStorage
        var prefixStorage: [ViewStorage] = []
        for view in prefix() {
            prefixStorage.append(view.storage(data: data, type: type))
            adw_action_row_add_prefix(storage.opaquePointer?.cast(), prefixStorage.last?.opaquePointer?.cast())
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
    public func update<Data>(_ storage: ViewStorage, data: WidgetData, updateProperties: Bool, type: Data.Type) where Data: ViewRenderData {
        if let activated {
            storage.connectSignal(name: "activated", argCount: 0) {
                activated()
            }
        }
        storage.modify { widget in

        storage.notify(name: "selected") {
            let newValue = UInt(adw_combo_row_get_selected(storage.opaquePointer?.cast()))
if let selected, newValue != selected.wrappedValue {
    selected.wrappedValue = newValue
}
        }
            if let widget = storage.content["activatableWidget"]?.first {
                activatableWidget?().updateStorage(widget, data: data, updateProperties: updateProperties, type: type)
            }
            if let enableSearch, updateProperties, (storage.previousState as? Self)?.enableSearch != enableSearch {
                adw_combo_row_set_enable_search(widget?.cast(), enableSearch.cBool)
            }
            if let selected, updateProperties, (UInt(adw_combo_row_get_selected(storage.opaquePointer?.cast()))) != selected.wrappedValue {
                adw_combo_row_set_selected(storage.opaquePointer?.cast(), selected.wrappedValue.cInt)
            }
            if let subtitle, updateProperties, (storage.previousState as? Self)?.subtitle != subtitle {
                adw_action_row_set_subtitle(widget?.cast(), subtitle)
            }
            if let subtitleLines, updateProperties, (storage.previousState as? Self)?.subtitleLines != subtitleLines {
                adw_action_row_set_subtitle_lines(widget?.cast(), subtitleLines.cInt)
            }
            if let subtitleSelectable, updateProperties, (storage.previousState as? Self)?.subtitleSelectable != subtitleSelectable {
                adw_action_row_set_subtitle_selectable(widget?.cast(), subtitleSelectable.cBool)
            }
            if let title, updateProperties, (storage.previousState as? Self)?.title != title {
                adw_preferences_row_set_title(widget?.cast(), title)
            }
            if let titleLines, updateProperties, (storage.previousState as? Self)?.titleLines != titleLines {
                adw_action_row_set_title_lines(widget?.cast(), titleLines.cInt)
            }
            if let titleSelectable, updateProperties, (storage.previousState as? Self)?.titleSelectable != titleSelectable {
                adw_preferences_row_set_title_selectable(widget?.cast(), titleSelectable.cBool)
            }
            if let useMarkup, updateProperties, (storage.previousState as? Self)?.useMarkup != useMarkup {
                adw_preferences_row_set_use_markup(widget?.cast(), useMarkup.cBool)
            }
            if let useSubtitle, updateProperties, (storage.previousState as? Self)?.useSubtitle != useSubtitle {
                adw_combo_row_set_use_subtitle(widget?.cast(), useSubtitle.cBool)
            }
            if let useUnderline, updateProperties, (storage.previousState as? Self)?.useUnderline != useUnderline {
                adw_preferences_row_set_use_underline(widget?.cast(), useUnderline.cBool)
            }


        }
        for function in updateFunctions {
            function(storage, data, updateProperties)
        }
        if updateProperties {
            storage.previousState = self
        }
    }

    /// The widget to activate when the row is activated.
    /// 
    /// The row can be activated either by clicking on it, calling
    /// [method@ActionRow.activate], or via mnemonics in the title.
    /// See the [property@PreferencesRow:use-underline] property to enable
    /// mnemonics.
    /// 
    /// The target widget will be activated by emitting the
    /// [signal@Gtk.Widget::mnemonic-activate] signal on it.
    public func activatableWidget(@ViewBuilder _ activatableWidget: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.activatableWidget = activatableWidget
        
        return newSelf
    }

    /// Whether to show a search entry in the popup.
    /// 
    /// If set to `TRUE`, a search entry will be shown in the popup that
    /// allows to search for items in the list.
    /// 
    /// Search requires [property@ComboRow:expression] to be set.
    public func enableSearch(_ enableSearch: Bool? = true) -> Self {
        var newSelf = self
        newSelf.enableSearch = enableSearch
        
        return newSelf
    }

    /// The position of the selected item.
    /// 
    /// If no item is selected, the property has the value
    /// [const@Gtk.INVALID_LIST_POSITION]
    public func selected(_ selected: Binding<UInt>?) -> Self {
        var newSelf = self
        newSelf.selected = selected
        
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

    /// Whether the user can copy the subtitle from the label.
    /// 
    /// See also [property@Gtk.Label:selectable].
    public func subtitleSelectable(_ subtitleSelectable: Bool? = true) -> Self {
        var newSelf = self
        newSelf.subtitleSelectable = subtitleSelectable
        
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

    /// Whether to use the current value as the subtitle.
    /// 
    /// If you use a custom list item factory, you will need to give the row a
    /// name conversion expression with [property@ComboRow:expression].
    /// 
    /// If set to `TRUE`, you should not access [property@ActionRow:subtitle].
    /// 
    /// The subtitle is interpreted as Pango markup if
    /// [property@PreferencesRow:use-markup] is set to `TRUE`.
    public func useSubtitle(_ useSubtitle: Bool? = true) -> Self {
        var newSelf = self
        newSelf.useSubtitle = useSubtitle
        
        return newSelf
    }

    /// Whether an embedded underline in the title indicates a mnemonic.
    public func useUnderline(_ useUnderline: Bool? = true) -> Self {
        var newSelf = self
        newSelf.useUnderline = useUnderline
        
        return newSelf
    }

    /// This signal is emitted after the row has been activated.
    public func activated(_ activated: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.activated = activated
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
