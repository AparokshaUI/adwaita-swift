//
//  CheckButton.swift
//  Adwaita
//
//  Created by auto-generation on 03.08.24.
//

import CAdw
import LevenshteinTransformations

/// A `GtkCheckButton` places a label next to an indicator.
/// 
/// ![Example GtkCheckButtons](check-button.png)
/// 
/// A `GtkCheckButton` is created by calling either [ctor@Gtk.CheckButton.new]
/// or [ctor@Gtk.CheckButton.new_with_label].
/// 
/// The state of a `GtkCheckButton` can be set specifically using
/// [method@Gtk.CheckButton.set_active], and retrieved using
/// [method@Gtk.CheckButton.get_active].
/// 
/// # Inconsistent state
/// 
/// In addition to "on" and "off", check buttons can be an
/// "in between" state that is neither on nor off. This can be used
/// e.g. when the user has selected a range of elements (such as some
/// text or spreadsheet cells) that are affected by a check button,
/// and the current values in that range are inconsistent.
/// 
/// To set a `GtkCheckButton` to inconsistent state, use
/// [method@Gtk.CheckButton.set_inconsistent].
/// 
/// # Grouping
/// 
/// Check buttons can be grouped together, to form mutually exclusive
/// groups - only one of the buttons can be toggled at a time, and toggling
/// another one will switch the currently toggled one off.
/// 
/// Grouped check buttons use a different indicator, and are commonly referred
/// to as *radio buttons*.
/// 
/// ![Example GtkCheckButtons](radio-button.png)
/// 
/// To add a `GtkCheckButton` to a group, use [method@Gtk.CheckButton.set_group].
/// 
/// When the code must keep track of the state of a group of radio buttons, it
/// is recommended to keep track of such state through a stateful
/// `GAction` with a target for each button. Using the `toggled` signals to keep
/// track of the group changes and state is discouraged.
/// 
/// # CSS nodes
/// 
/// ```
/// checkbutton[.text-button]
/// ├── check
/// ╰── [label]
/// ```
/// 
/// A `GtkCheckButton` has a main node with name checkbutton. If the
/// [property@Gtk.CheckButton:label] or [property@Gtk.CheckButton:child]
/// properties are set, it contains a child widget. The indicator node
/// is named check when no group is set, and radio if the checkbutton
/// is grouped together with other checkbuttons.
/// 
/// # Accessibility
/// 
/// `GtkCheckButton` uses the %GTK_ACCESSIBLE_ROLE_CHECKBOX role.
public struct CheckButton: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(AnyView) -> AnyView], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(AnyView) -> AnyView]) -> Void] = []

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    var accessibleRole: String?
/// action-name
    var actionName: String?
    /// If the check button is active.
    /// 
    /// Setting `active` to %TRUE will add the `:checked:` state to both
    /// the check button and the indicator CSS node.
    var active: Binding<Bool>?
    /// The child widget.
    var child: (() -> Body)?
    /// If the check button is in an “in between” state.
    /// 
    /// The inconsistent state only affects visual appearance,
    /// not the semantics of the button.
    var inconsistent: Bool?
    /// Text of the label inside the check button, if it contains a label widget.
    var label: String?
    /// If set, an underline in the text indicates that the following
    /// character is to be used as mnemonic.
    var useUnderline: Bool?
    /// Emitted to when the check button is activated.
    /// 
    /// The `::activate` signal on `GtkCheckButton` is an action signal and
    /// emitting it causes the button to animate press then release.
    /// 
    /// Applications should never connect to this signal, but use the
    /// [signal@Gtk.CheckButton::toggled] signal.
    /// 
    /// The default bindings for this signal are all forms of the
    /// <kbd>␣</kbd> and <kbd>Enter</kbd> keys.
    var activate: (() -> Void)?
    /// Emitted when the buttons's [property@Gtk.CheckButton:active]
    /// property changes.
    var toggled: (() -> Void)?
    /// The application.
    var app: AdwaitaApp?
    /// The window.
    var window: AdwaitaWindow?

    /// Initialize `CheckButton`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(modifiers: [(AnyView) -> AnyView], type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(gtk_check_button_new()?.opaque())
        for function in appearFunctions {
            function(storage, modifiers)
        }
        update(storage, modifiers: modifiers, updateProperties: true, type: type)
        if let childStorage = child?().storage(modifiers: modifiers, type: type) {
            storage.content["child"] = [childStorage]
            gtk_check_button_set_child(storage.opaquePointer?.cast(), childStorage.opaquePointer?.cast())
        }

        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The type of the app storage.
    public func update<Data>(_ storage: ViewStorage, modifiers: [(AnyView) -> AnyView], updateProperties: Bool, type: Data.Type) where Data: ViewRenderData {
        if let activate {
            storage.connectSignal(name: "activate", argCount: 0) {
                activate()
            }
        }
        if let toggled {
            storage.connectSignal(name: "toggled", argCount: 0) {
                toggled()
            }
        }
        storage.modify { widget in

        storage.notify(name: "active") {
            let newValue = gtk_check_button_get_active(storage.opaquePointer?.cast()) != 0
if let active, newValue != active.wrappedValue {
    active.wrappedValue = newValue
}
        }
            if let actionName, updateProperties, (storage.previousState as? Self)?.actionName != actionName {
                gtk_actionable_set_action_name(widget, actionName)
            }
            if let active, updateProperties, (gtk_check_button_get_active(storage.opaquePointer?.cast()) != 0) != active.wrappedValue {
                gtk_check_button_set_active(storage.opaquePointer?.cast(), active.wrappedValue.cBool)
            }
            if let widget = storage.content["child"]?.first {
                child?().updateStorage(widget, modifiers: modifiers, updateProperties: updateProperties, type: type)
            }
            if let inconsistent, updateProperties, (storage.previousState as? Self)?.inconsistent != inconsistent {
                gtk_check_button_set_inconsistent(widget?.cast(), inconsistent.cBool)
            }
            if let label, storage.content["child"] == nil, updateProperties, (storage.previousState as? Self)?.label != label {
                gtk_check_button_set_label(widget?.cast(), label)
            }
            if let useUnderline, updateProperties, (storage.previousState as? Self)?.useUnderline != useUnderline {
                gtk_check_button_set_use_underline(widget?.cast(), useUnderline.cBool)
            }


        }
        for function in updateFunctions {
            function(storage, modifiers, updateProperties)
        }
        if updateProperties {
            storage.previousState = self
        }
    }

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    public func accessibleRole(_ accessibleRole: String?) -> Self {
        var newSelf = self
        newSelf.accessibleRole = accessibleRole
        
        return newSelf
    }

/// action-name
    public func actionName(_ actionName: String?) -> Self {
        var newSelf = self
        newSelf.actionName = actionName
        
        return newSelf
    }

    /// If the check button is active.
    /// 
    /// Setting `active` to %TRUE will add the `:checked:` state to both
    /// the check button and the indicator CSS node.
    public func active(_ active: Binding<Bool>?) -> Self {
        var newSelf = self
        newSelf.active = active
        
        return newSelf
    }

    /// The child widget.
    public func child(@ViewBuilder _ child: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.child = child
        
        return newSelf
    }

    /// If the check button is in an “in between” state.
    /// 
    /// The inconsistent state only affects visual appearance,
    /// not the semantics of the button.
    public func inconsistent(_ inconsistent: Bool? = true) -> Self {
        var newSelf = self
        newSelf.inconsistent = inconsistent
        
        return newSelf
    }

    /// Text of the label inside the check button, if it contains a label widget.
    public func label(_ label: String?) -> Self {
        var newSelf = self
        newSelf.label = label
        
        return newSelf
    }

    /// If set, an underline in the text indicates that the following
    /// character is to be used as mnemonic.
    public func useUnderline(_ useUnderline: Bool? = true) -> Self {
        var newSelf = self
        newSelf.useUnderline = useUnderline
        
        return newSelf
    }

    /// Emitted to when the check button is activated.
    /// 
    /// The `::activate` signal on `GtkCheckButton` is an action signal and
    /// emitting it causes the button to animate press then release.
    /// 
    /// Applications should never connect to this signal, but use the
    /// [signal@Gtk.CheckButton::toggled] signal.
    /// 
    /// The default bindings for this signal are all forms of the
    /// <kbd>␣</kbd> and <kbd>Enter</kbd> keys.
    public func activate(_ activate: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.activate = activate
        return newSelf
    }

    /// Emitted when the buttons's [property@Gtk.CheckButton:active]
    /// property changes.
    public func toggled(_ toggled: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.toggled = toggled
        return newSelf
    }

}
