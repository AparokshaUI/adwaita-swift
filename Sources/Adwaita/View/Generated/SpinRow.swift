//
//  SpinRow.swift
//  Adwaita
//
//  Created by auto-generation on 15.08.24.
//

import CAdw
import LevenshteinTransformations

/// An [class@ActionRow] with an embedded spin button.
/// 
/// <picture><source srcset="spin-row-dark.png" media="(prefers-color-scheme: dark)"><img src="spin-row.png" alt="spin-row"></picture>
/// 
/// Example of an `AdwSpinRow` UI definition:
/// 
/// ```xml
/// <object class="AdwSpinRow"><property name="title" translatable="yes">Spin Row</property><property name="adjustment"><object class="GtkAdjustment"><property name="lower">0</property><property name="upper">100</property><property name="value">50</property><property name="page-increment">10</property><property name="step-increment">1</property></object></property></object>
/// ```
/// 
/// See [class@Gtk.SpinButton] for details.
/// 
/// ## CSS nodes
/// 
/// `AdwSpinRow` has the same structure as [class@ActionRow], as well as the
/// `.spin` style class on the main node.
public struct SpinRow: AdwaitaWidget {

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
    /// The acceleration rate when you hold down a button or key.
    var climbRate: Double
    /// The number of decimal places to display.
    var digits: UInt
    /// Whether non-numeric characters should be ignored.
    var numeric: Bool?
    /// Whether invalid values are snapped to the nearest step increment.
    var snapToTicks: Bool?
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
    /// Whether an embedded underline in the title indicates a mnemonic.
    var useUnderline: Bool?
    /// The current value.
    var value: Binding<Double>?
    /// Whether the spin row should wrap upon reaching its limits.
    var wrap: Bool?
    /// This signal is emitted after the row has been activated.
    var activated: (() -> Void)?
    /// Emitted to convert the user's input into a double value.
    /// 
    /// The signal handler is expected to use [method@Gtk.Editable.get_text] to
    /// retrieve the text of the spinbutton and set new_value to the new value.
    /// 
    /// The default conversion uses [func@GLib.strtod].
    /// 
    /// See [signal@Gtk.SpinButton::input].
    var input: (() -> Void)?
    /// Emitted to tweak the formatting of the value for display.
    /// 
    /// See [signal@Gtk.SpinButton::output].
    var output: (() -> Void)?
    /// Emitted right after the spinbutton wraps.
    /// 
    /// See [signal@Gtk.SpinButton::wrapped].
    var wrapped: (() -> Void)?
    /// The body for the widget "suffix".
    var suffix: () -> Body = { [] }
    /// The body for the widget "prefix".
    var prefix: () -> Body = { [] }

    /// Initialize `SpinRow`.
    public init(climbRate: Double, digits: UInt) {
        self.climbRate = climbRate
        self.digits = digits
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_spin_row_new(nil, climbRate, digits.cInt)?.opaque())
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
        if let input {
            storage.connectSignal(name: "input", argCount: 1) {
                input()
            }
        }
        if let output {
            storage.connectSignal(name: "output", argCount: 0) {
                output()
            }
        }
        if let wrapped {
            storage.connectSignal(name: "wrapped", argCount: 0) {
                wrapped()
            }
        }
        storage.modify { widget in

        storage.notify(name: "value") {
            let newValue = adw_spin_row_get_value(storage.opaquePointer)
if let value, newValue != value.wrappedValue {
    value.wrappedValue = newValue
}
        }
            if let widget = storage.content["activatableWidget"]?.first {
                activatableWidget?().updateStorage(widget, data: data, updateProperties: updateProperties, type: type)
            }
            if updateProperties, (storage.previousState as? Self)?.climbRate != climbRate {
                adw_spin_row_set_climb_rate(widget, climbRate)
            }
            if updateProperties, (storage.previousState as? Self)?.digits != digits {
                adw_spin_row_set_digits(widget, digits.cInt)
            }
            if let numeric, updateProperties, (storage.previousState as? Self)?.numeric != numeric {
                adw_spin_row_set_numeric(widget, numeric.cBool)
            }
            if let snapToTicks, updateProperties, (storage.previousState as? Self)?.snapToTicks != snapToTicks {
                adw_spin_row_set_snap_to_ticks(widget, snapToTicks.cBool)
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
            if let useUnderline, updateProperties, (storage.previousState as? Self)?.useUnderline != useUnderline {
                adw_preferences_row_set_use_underline(widget?.cast(), useUnderline.cBool)
            }
            if let value, updateProperties, (adw_spin_row_get_value(storage.opaquePointer)) != value.wrappedValue {
                adw_spin_row_set_value(storage.opaquePointer, value.wrappedValue)
            }
            if let wrap, updateProperties, (storage.previousState as? Self)?.wrap != wrap {
                adw_spin_row_set_wrap(widget, wrap.cBool)
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

    /// The acceleration rate when you hold down a button or key.
    public func climbRate(_ climbRate: Double) -> Self {
        var newSelf = self
        newSelf.climbRate = climbRate
        
        return newSelf
    }

    /// The number of decimal places to display.
    public func digits(_ digits: UInt) -> Self {
        var newSelf = self
        newSelf.digits = digits
        
        return newSelf
    }

    /// Whether non-numeric characters should be ignored.
    public func numeric(_ numeric: Bool? = true) -> Self {
        var newSelf = self
        newSelf.numeric = numeric
        
        return newSelf
    }

    /// Whether invalid values are snapped to the nearest step increment.
    public func snapToTicks(_ snapToTicks: Bool? = true) -> Self {
        var newSelf = self
        newSelf.snapToTicks = snapToTicks
        
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

    /// Whether an embedded underline in the title indicates a mnemonic.
    public func useUnderline(_ useUnderline: Bool? = true) -> Self {
        var newSelf = self
        newSelf.useUnderline = useUnderline
        
        return newSelf
    }

    /// The current value.
    public func value(_ value: Binding<Double>?) -> Self {
        var newSelf = self
        newSelf.value = value
        
        return newSelf
    }

    /// Whether the spin row should wrap upon reaching its limits.
    public func wrap(_ wrap: Bool? = true) -> Self {
        var newSelf = self
        newSelf.wrap = wrap
        
        return newSelf
    }

    /// This signal is emitted after the row has been activated.
    public func activated(_ activated: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.activated = activated
        return newSelf
    }

    /// Emitted to convert the user's input into a double value.
    /// 
    /// The signal handler is expected to use [method@Gtk.Editable.get_text] to
    /// retrieve the text of the spinbutton and set new_value to the new value.
    /// 
    /// The default conversion uses [func@GLib.strtod].
    /// 
    /// See [signal@Gtk.SpinButton::input].
    public func input(_ input: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.input = input
        return newSelf
    }

    /// Emitted to tweak the formatting of the value for display.
    /// 
    /// See [signal@Gtk.SpinButton::output].
    public func output(_ output: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.output = output
        return newSelf
    }

    /// Emitted right after the spinbutton wraps.
    /// 
    /// See [signal@Gtk.SpinButton::wrapped].
    public func wrapped(_ wrapped: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.wrapped = wrapped
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
