//
//  PasswordEntryRow.swift
//  Adwaita
//
//  Created by auto-generation on 21.07.24.
//

import CAdw
import LevenshteinTransformations

/// A [class@EntryRow] tailored for entering secrets.
/// 
/// <picture><source srcset="password-entry-row-dark.png" media="(prefers-color-scheme: dark)"><img src="password-entry-row.png" alt="password-entry-row"></picture>
/// 
/// It does not show its contents in clear text, does not allow to copy it to the
/// clipboard, and shows a warning when Caps Lock is engaged. If the underlying
/// platform allows it, `AdwPasswordEntryRow` will also place the text in a
/// non-pageable memory area, to avoid it being written out to disk by the
/// operating system.
/// 
/// It offer a way to reveal the contents in clear text.
/// 
/// ## CSS Nodes
/// 
/// `AdwPasswordEntryRow` has a single CSS node with name `row` that carries
/// `.entry` and `.password` style classes.
public struct PasswordEntryRow: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(View) -> View], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(View) -> View]) -> Void] = []

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
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `PasswordEntryRow`.
    public init() {
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(adw_password_entry_row_new()?.opaque())
        for function in appearFunctions {
            function(storage, modifiers)
        }
        update(storage, modifiers: modifiers, updateProperties: true)

        var suffixStorage: [ViewStorage] = []
        for view in suffix() {
            suffixStorage.append(view.storage(modifiers: modifiers))
            adw_entry_row_add_suffix(storage.pointer?.cast(), suffixStorage.last?.pointer?.cast())
        }
        storage.content["suffix"] = suffixStorage
        var prefixStorage: [ViewStorage] = []
        for view in prefix() {
            prefixStorage.append(view.storage(modifiers: modifiers))
            adw_entry_row_add_prefix(storage.pointer?.cast(), prefixStorage.last?.pointer?.cast())
        }
        storage.content["prefix"] = prefixStorage
        return storage
    }

    /// Update the widget's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: The view modifiers.
    ///     - updateProperties: Whether to update the view's properties.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
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

            if let activatesDefault, updateProperties {
                adw_entry_row_set_activates_default(widget?.cast(), activatesDefault.cBool)
            }
            if let enableEmojiCompletion, updateProperties {
                adw_entry_row_set_enable_emoji_completion(widget?.cast(), enableEmojiCompletion.cBool)
            }
            if let showApplyButton, updateProperties {
                adw_entry_row_set_show_apply_button(widget?.cast(), showApplyButton.cBool)
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
            function(storage, modifiers, updateProperties)
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
