//
//  ComboRow.swift
//  Adwaita
//
//  Created by auto-generation on 29.01.24.
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
public struct ComboRow: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage) -> Void] = []

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
    /// The widget to activate when the row is activated.
    /// 
    /// The row can be activated either by clicking on it, calling
    /// [method@ActionRow.activate], or via mnemonics in the title.
    /// See the [property@PreferencesRow:use-underline] property to enable
    /// mnemonics.
    /// 
    /// The target widget will be activated by emitting the
    /// [signal@Gtk.Widget::mnemonic-activate] signal on it.
    var activatableWidget:  (() -> Body)?
    /// The icon name for this row.
    var iconName: String?
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
    /// The number of lines at the end of which the title label will be ellipsized.
    /// 
    /// If the value is 0, the number of lines won't be limited.
    var titleLines: Int?
    /// The title of the preference represented by this row.
    /// 
    /// The title is interpreted as Pango markup unless
    /// [property@PreferencesRow:use-markup] is set to `FALSE`.
    var title: String?
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
    /// This signal is emitted after the row has been activated.
    var activated: (() -> Void)?
    /// The body for the widget "suffix".
    var suffix: () -> Body = { [] }
    /// The body for the widget "prefix".
    var prefix: () -> Body = { [] }
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `ComboRow`.
    public init() {
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(adw_combo_row_new()?.opaque())
        update(storage, modifiers: modifiers, updateProperties: true)
        if let activatableWidgetStorage = activatableWidget?().widget(modifiers: modifiers).storage(modifiers: modifiers) {
            storage.content["activatableWidget"] = [activatableWidgetStorage]
            adw_action_row_set_activatable_widget(storage.pointer?.cast(), activatableWidgetStorage.pointer?.cast())
        }

        var suffixStorage: [ViewStorage] = []
        for view in suffix() {
            suffixStorage.append(view.storage(modifiers: modifiers))
            adw_action_row_add_suffix(storage.pointer?.cast(), suffixStorage.last?.pointer?.cast())
        }
        storage.content["suffix"] = suffixStorage
        var prefixStorage: [ViewStorage] = []
        for view in prefix() {
            prefixStorage.append(view.storage(modifiers: modifiers))
            adw_action_row_add_prefix(storage.pointer?.cast(), prefixStorage.last?.pointer?.cast())
        }
        storage.content["prefix"] = prefixStorage

        storage.notify(name: "selected") {
            selected?.wrappedValue = .init(adw_combo_row_get_selected(storage.pointer?.cast()))
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
        if let activated {
            storage.connectSignal(name: "activated", argCount: 0) {
                activated()
            }
        }
        storage.modify { widget in
            if let enableSearch, updateProperties {
                adw_combo_row_set_enable_search(widget?.cast(), enableSearch.cBool)
            }
            if let selected, updateProperties {
                adw_combo_row_set_selected(widget?.cast(), selected.wrappedValue.cInt)
            }
            if let useSubtitle, updateProperties {
                adw_combo_row_set_use_subtitle(widget?.cast(), useSubtitle.cBool)
            }
            if let widget = storage.content["activatableWidget"]?.first {
                activatableWidget?().widget(modifiers: modifiers).update(widget, modifiers: modifiers, updateProperties: updateProperties)
            }
            if let iconName, updateProperties {
                adw_action_row_set_icon_name(widget?.cast(), iconName)
            }
            if let subtitle, updateProperties {
                adw_action_row_set_subtitle(widget?.cast(), subtitle)
            }
            if let subtitleLines, updateProperties {
                adw_action_row_set_subtitle_lines(widget?.cast(), subtitleLines.cInt)
            }
            if let subtitleSelectable, updateProperties {
                adw_action_row_set_subtitle_selectable(widget?.cast(), subtitleSelectable.cBool)
            }
            if let titleLines, updateProperties {
                adw_action_row_set_title_lines(widget?.cast(), titleLines.cInt)
            }
            if let title, updateProperties {
                adw_preferences_row_set_title(widget?.cast(), title)
            }
            if let titleSelectable, updateProperties {
                adw_preferences_row_set_title_selectable(widget?.cast(), titleSelectable.cBool)
            }
            if let useMarkup, updateProperties {
                adw_preferences_row_set_use_markup(widget?.cast(), useMarkup.cBool)
            }
            if let useUnderline, updateProperties {
                adw_preferences_row_set_use_underline(widget?.cast(), useUnderline.cBool)
            }


        }
        for function in updateFunctions {
            function(storage)
        }
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

    /// The icon name for this row.
    public func iconName(_ iconName: String?) -> Self {
        var newSelf = self
        newSelf.iconName = iconName
        
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

    /// The number of lines at the end of which the title label will be ellipsized.
    /// 
    /// If the value is 0, the number of lines won't be limited.
    public func titleLines(_ titleLines: Int?) -> Self {
        var newSelf = self
        newSelf.titleLines = titleLines
        
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

    /// This signal is emitted after the row has been activated.
    public func activated(_ activated: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.activated = activated
        return newSelf
    }

}
