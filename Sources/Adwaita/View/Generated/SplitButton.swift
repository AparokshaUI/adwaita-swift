//
//  SplitButton.swift
//  Adwaita
//
//  Created by auto-generation on 14.02.24.
//

import CAdw
import LevenshteinTransformations

/// A combined button and dropdown widget.
/// 
/// <picture><source srcset="split-button-dark.png" media="(prefers-color-scheme: dark)"><img src="split-button.png" alt="split-button"></picture>
/// 
/// `AdwSplitButton` is typically used to present a set of actions in a menu,
/// but allow access to one of them with a single click.
/// 
/// The API is very similar to [class@Gtk.Button] and [class@Gtk.MenuButton], see
/// their documentation for details.
/// 
/// ## CSS nodes
/// 
/// ```
/// splitbutton[.image-button][.text-button]
/// ├── button
/// │   ╰── <content>├── separator
/// ╰── menubutton
/// ╰── button.toggle
/// ╰── arrow
/// ```
/// 
/// `AdwSplitButton`'s CSS node is called `splitbutton`. It contains the css
/// nodes: `button`, `separator`, `menubutton`. See [class@Gtk.MenuButton]
/// documentation for the `menubutton` contents.
/// 
/// The main CSS node will contain the `.image-button` or `.text-button` style
/// classes matching the button contents. The nested button nodes will never
/// contain them.
/// 
/// ## Accessibility
/// 
/// `AdwSplitButton` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
public struct SplitButton: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage) -> Void] = []

    /// Whether the button can be smaller than the natural size of its contents.
    /// 
    /// If set to `TRUE`, the label will ellipsize.
    /// 
    /// See [property@Gtk.Button:can-shrink] and
    /// [property@Gtk.MenuButton:can-shrink].
    var canShrink: Bool?
    /// The child widget.
    /// 
    /// Setting the child widget will set [property@SplitButton:label] and
    /// [property@SplitButton:icon-name] to `NULL`.
    var child:  (() -> Body)?
    /// The tooltip of the dropdown button.
    /// 
    /// The tooltip can be marked up with the Pango text markup language.
    var dropdownTooltip: String?
    /// The name of the icon used to automatically populate the button.
    /// 
    /// Setting the icon name will set [property@SplitButton:label] and
    /// [property@SplitButton:child] to `NULL`.
    var iconName: String?
    /// The label for the button.
    /// 
    /// Setting the label will set [property@SplitButton:icon-name] and
    /// [property@SplitButton:child] to `NULL`.
    var label: String?
    /// The `GMenuModel` from which the popup will be created.
    /// 
    /// If the menu model is `NULL`, the dropdown is disabled.
    /// 
    /// A [class@Gtk.Popover] will be created from the menu model with
    /// [ctor@Gtk.PopoverMenu.new_from_model]. Actions will be connected as
    /// documented for this function.
    /// 
    /// If [property@SplitButton:popover] is already set, it will be dissociated
    /// from the button, and the property is set to `NULL`.
    var menuModel:  (() -> MenuContent)?
    /// Whether an underline in the text indicates a mnemonic.
    /// 
    /// See [property@SplitButton:label].
    var useUnderline: Bool?
    /// Emitted to animate press then release.
    /// 
    /// This is an action signal. Applications should never connect to this signal,
    /// but use the [signal@SplitButton::clicked] signal.
    var activate: (() -> Void)?
    /// Emitted when the button has been activated (pressed and released).
    var clicked: (() -> Void)?
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `SplitButton`.
    public init() {
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(adw_split_button_new()?.opaque())
        update(storage, modifiers: modifiers, updateProperties: true)
        if let childStorage = child?().widget(modifiers: modifiers).storage(modifiers: modifiers) {
            storage.content["child"] = [childStorage]
            adw_split_button_set_child(storage.pointer, childStorage.pointer?.cast())
        }
        if let declarative = menuModel?(), let app {
            let menu = g_menu_new()
            adw_split_button_set_menu_model(storage.pointer, menu?.cast())
            for item in declarative {
                item.addMenuItems(menu: menu, app: app, window: window)
            }
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
        if let activate {
            storage.connectSignal(name: "activate", argCount: 0) {
                activate()
            }
        }
        if let clicked {
            storage.connectSignal(name: "clicked", argCount: 0) {
                clicked()
            }
        }
        storage.modify { widget in

            if let canShrink, updateProperties {
                adw_split_button_set_can_shrink(widget, canShrink.cBool)
            }
            if let widget = storage.content["child"]?.first {
                child?().widget(modifiers: modifiers).update(widget, modifiers: modifiers, updateProperties: updateProperties)
            }
            if let dropdownTooltip, updateProperties {
                adw_split_button_set_dropdown_tooltip(widget, dropdownTooltip)
            }
            if let iconName, updateProperties {
                adw_split_button_set_icon_name(widget, iconName)
            }
            if let label, storage.content["child"] == nil, updateProperties {
                adw_split_button_set_label(widget, label)
            }
            if let useUnderline, updateProperties {
                adw_split_button_set_use_underline(widget, useUnderline.cBool)
            }


        }
        for function in updateFunctions {
            function(storage)
        }
    }

    /// Whether the button can be smaller than the natural size of its contents.
    /// 
    /// If set to `TRUE`, the label will ellipsize.
    /// 
    /// See [property@Gtk.Button:can-shrink] and
    /// [property@Gtk.MenuButton:can-shrink].
    public func canShrink(_ canShrink: Bool? = true) -> Self {
        var newSelf = self
        newSelf.canShrink = canShrink
        
        return newSelf
    }

    /// The child widget.
    /// 
    /// Setting the child widget will set [property@SplitButton:label] and
    /// [property@SplitButton:icon-name] to `NULL`.
    public func child(@ViewBuilder _ child: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.child = child
        
        return newSelf
    }

    /// The tooltip of the dropdown button.
    /// 
    /// The tooltip can be marked up with the Pango text markup language.
    public func dropdownTooltip(_ dropdownTooltip: String?) -> Self {
        var newSelf = self
        newSelf.dropdownTooltip = dropdownTooltip
        
        return newSelf
    }

    /// The name of the icon used to automatically populate the button.
    /// 
    /// Setting the icon name will set [property@SplitButton:label] and
    /// [property@SplitButton:child] to `NULL`.
    public func iconName(_ iconName: String?) -> Self {
        var newSelf = self
        newSelf.iconName = iconName
        
        return newSelf
    }

    /// The label for the button.
    /// 
    /// Setting the label will set [property@SplitButton:icon-name] and
    /// [property@SplitButton:child] to `NULL`.
    public func label(_ label: String?) -> Self {
        var newSelf = self
        newSelf.label = label
        
        return newSelf
    }

    /// The `GMenuModel` from which the popup will be created.
    /// 
    /// If the menu model is `NULL`, the dropdown is disabled.
    /// 
    /// A [class@Gtk.Popover] will be created from the menu model with
    /// [ctor@Gtk.PopoverMenu.new_from_model]. Actions will be connected as
    /// documented for this function.
    /// 
    /// If [property@SplitButton:popover] is already set, it will be dissociated
    /// from the button, and the property is set to `NULL`.
    public func menuModel(app: GTUIApp, window: GTUIApplicationWindow? = nil, @MenuBuilder _ menuModel: @escaping (() -> MenuContent)) -> Self {
        var newSelf = self
        newSelf.menuModel = menuModel
        newSelf.app = app; newSelf.window = window
        return newSelf
    }

    /// Whether an underline in the text indicates a mnemonic.
    /// 
    /// See [property@SplitButton:label].
    public func useUnderline(_ useUnderline: Bool? = true) -> Self {
        var newSelf = self
        newSelf.useUnderline = useUnderline
        
        return newSelf
    }

    /// Emitted to animate press then release.
    /// 
    /// This is an action signal. Applications should never connect to this signal,
    /// but use the [signal@SplitButton::clicked] signal.
    public func activate(_ activate: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.activate = activate
        return newSelf
    }

    /// Emitted when the button has been activated (pressed and released).
    public func clicked(_ clicked: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.clicked = clicked
        return newSelf
    }

}
