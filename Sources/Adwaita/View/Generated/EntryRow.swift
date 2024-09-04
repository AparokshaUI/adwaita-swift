//
//  EntryRow.swift
//  Adwaita
//
//  Created by auto-generation on 15.08.24.
//

import CAdw
import LevenshteinTransformations

/// A [class@Gtk.ListBoxRow] with an embedded text entry.
/// 
/// <picture><source srcset="entry-row-dark.png" media="(prefers-color-scheme: dark)"><img src="entry-row.png" alt="entry-row"></picture>
/// 
/// `AdwEntryRow` has a title that doubles as placeholder text. It shows an icon
/// indicating that it's editable and can receive additional widgets before or
/// after the editable part.
/// 
/// If [property@EntryRow:show-apply-button] is set to `TRUE`, `AdwEntryRow` can
/// show an apply button when editing its contents. This can be useful if
/// changing its contents can result in an expensive operation, such as network
/// activity.
/// 
/// `AdwEntryRow` provides only minimal API and should be used with the
/// [iface@Gtk.Editable] API.
/// 
/// See also [class@PasswordEntryRow].
/// 
/// ## AdwEntryRow as GtkBuildable
/// 
/// The `AdwEntryRow` implementation of the [iface@Gtk.Buildable] interface
/// supports adding a child at its end by specifying “suffix” or omitting the
/// “type” attribute of a <child> element.
/// 
/// It also supports adding a child as a prefix widget by specifying “prefix” as
/// the “type” attribute of a <child> element.
/// 
/// ## CSS nodes
/// 
/// `AdwEntryRow` has a single CSS node with name `row` and the `.entry` style
/// class.
public struct EntryRow: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, WidgetData, Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, WidgetData) -> Void] = []

    /// Whether activating the embedded entry can activate the default widget.
    var activatesDefault: Bool?
    /// Whether to suggest emoji replacements on the entry row.
    /// 
    /// Emoji replacement is done with :-delimited names, like `:heart:`.
    var enableEmojiCompletion: Bool?
    /// Whether to show the apply button.
    /// 
    /// When set to `TRUE`, typing text in the entry will reveal an apply button.
    /// Clicking it or pressing the <kbd>Enter</kbd> key will hide the button and
    /// emit the [signal@EntryRow::apply] signal.
    /// 
    /// This is useful if changing the entry contents can trigger an expensive
    /// operation, e.g. network activity, to avoid triggering it after typing every
    /// character.
    var showApplyButton: Bool?
    /// The length of the text in the entry row.
    var textLength: UInt?
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
    /// Emitted when the apply button is pressed.
    /// 
    /// See [property@EntryRow:show-apply-button].
    var apply: (() -> Void)?
    /// Emitted when the embedded entry is activated.
    var entryActivated: (() -> Void)?
    /// The body for the widget "suffix".
    var suffix: () -> Body = { [] }
    /// The body for the widget "prefix".
    var prefix: () -> Body = { [] }

    /// Initialize `EntryRow`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The view render data type.
    /// - Returns: The view storage.
    public func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_entry_row_new()?.opaque())
        for function in appearFunctions {
            function(storage, data)
        }
        update(storage, data: data, updateProperties: true, type: type)

        var suffixStorage: [ViewStorage] = []
        for view in suffix() {
            suffixStorage.append(view.storage(data: data, type: type))
            adw_entry_row_add_suffix(storage.opaquePointer?.cast(), suffixStorage.last?.opaquePointer?.cast())
        }
        storage.content["suffix"] = suffixStorage
        var prefixStorage: [ViewStorage] = []
        for view in prefix() {
            prefixStorage.append(view.storage(data: data, type: type))
            adw_entry_row_add_prefix(storage.opaquePointer?.cast(), prefixStorage.last?.opaquePointer?.cast())
        }
        storage.content["prefix"] = prefixStorage
        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The view render data type.
    public func update<Data>(_ storage: ViewStorage, data: WidgetData, updateProperties: Bool, type: Data.Type) where Data: ViewRenderData {
        if let apply {
            storage.connectSignal(name: "apply", argCount: 0) {
                apply()
            }
        }
        if let entryActivated {
            storage.connectSignal(name: "entry-activated", argCount: 0) {
                entryActivated()
            }
        }
        storage.modify { widget in

            if let activatesDefault, updateProperties, (storage.previousState as? Self)?.activatesDefault != activatesDefault {
                adw_entry_row_set_activates_default(widget?.cast(), activatesDefault.cBool)
            }
            if let enableEmojiCompletion, updateProperties, (storage.previousState as? Self)?.enableEmojiCompletion != enableEmojiCompletion {
                adw_entry_row_set_enable_emoji_completion(widget?.cast(), enableEmojiCompletion.cBool)
            }
            if let showApplyButton, updateProperties, (storage.previousState as? Self)?.showApplyButton != showApplyButton {
                adw_entry_row_set_show_apply_button(widget?.cast(), showApplyButton.cBool)
            }
            if let title, updateProperties, (storage.previousState as? Self)?.title != title {
                adw_preferences_row_set_title(widget?.cast(), title)
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

            if let suffixStorage = storage.content["suffix"] {
                for (index, view) in suffix().enumerated() {
                    if let storage = suffixStorage[safe: index] {
                        view.updateStorage(
                            storage,
                            data: data,
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

    /// Whether activating the embedded entry can activate the default widget.
    public func activatesDefault(_ activatesDefault: Bool? = true) -> Self {
        var newSelf = self
        newSelf.activatesDefault = activatesDefault
        
        return newSelf
    }

    /// Whether to suggest emoji replacements on the entry row.
    /// 
    /// Emoji replacement is done with :-delimited names, like `:heart:`.
    public func enableEmojiCompletion(_ enableEmojiCompletion: Bool? = true) -> Self {
        var newSelf = self
        newSelf.enableEmojiCompletion = enableEmojiCompletion
        
        return newSelf
    }

    /// Whether to show the apply button.
    /// 
    /// When set to `TRUE`, typing text in the entry will reveal an apply button.
    /// Clicking it or pressing the <kbd>Enter</kbd> key will hide the button and
    /// emit the [signal@EntryRow::apply] signal.
    /// 
    /// This is useful if changing the entry contents can trigger an expensive
    /// operation, e.g. network activity, to avoid triggering it after typing every
    /// character.
    public func showApplyButton(_ showApplyButton: Bool? = true) -> Self {
        var newSelf = self
        newSelf.showApplyButton = showApplyButton
        
        return newSelf
    }

    /// The length of the text in the entry row.
    public func textLength(_ textLength: UInt?) -> Self {
        var newSelf = self
        newSelf.textLength = textLength
        
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

    /// Emitted when the apply button is pressed.
    /// 
    /// See [property@EntryRow:show-apply-button].
    public func apply(_ apply: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.apply = apply
        return newSelf
    }

    /// Emitted when the embedded entry is activated.
    public func entryActivated(_ entryActivated: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.entryActivated = entryActivated
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
