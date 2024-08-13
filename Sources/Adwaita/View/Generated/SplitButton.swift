//
//  SplitButton.swift
//  Adwaita
//
//  Created by auto-generation on 03.08.24.
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
public struct SplitButton: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(AnyView) -> AnyView], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(AnyView) -> AnyView]) -> Void] = []

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
    var child: (() -> Body)?
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
    var menuModel: (() -> Body)?
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
    var app: AdwaitaApp?
    /// The window.
    var window: AdwaitaWindow?

    /// Initialize `SplitButton`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(modifiers: [(AnyView) -> AnyView], type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_split_button_new()?.opaque())
        for function in appearFunctions {
            function(storage, modifiers)
        }
        update(storage, modifiers: modifiers, updateProperties: true, type: type)
        if let childStorage = child?().storage(modifiers: modifiers, type: type) {
            storage.content["child"] = [childStorage]
            adw_split_button_set_child(storage.opaquePointer, childStorage.opaquePointer?.cast())
        }
        if let menu = menuModel?(), let app {
            let childStorage = MenuCollection { menu }.getMenu(app: app, window: window)
            storage.content["menuModel"] = [childStorage]
            adw_split_button_set_menu_model(storage.opaquePointer, childStorage.opaquePointer?.cast())
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
        if let clicked {
            storage.connectSignal(name: "clicked", argCount: 0) {
                clicked()
            }
        }
        storage.modify { widget in

            if let canShrink, updateProperties, (storage.previousState as? Self)?.canShrink != canShrink {
                adw_split_button_set_can_shrink(widget, canShrink.cBool)
            }
            if let widget = storage.content["child"]?.first {
                child?().updateStorage(widget, modifiers: modifiers, updateProperties: updateProperties, type: type)
            }
            if let dropdownTooltip, updateProperties, (storage.previousState as? Self)?.dropdownTooltip != dropdownTooltip {
                adw_split_button_set_dropdown_tooltip(widget, dropdownTooltip)
            }
            if let iconName, updateProperties, (storage.previousState as? Self)?.iconName != iconName {
                adw_split_button_set_icon_name(widget, iconName)
            }
            if let label, storage.content["child"] == nil, updateProperties, (storage.previousState as? Self)?.label != label {
                adw_split_button_set_label(widget, label)
            }
            if let menu = storage.content["menuModel"]?.first {
                MenuCollection { menuModel?() ?? [] }
                    .updateStorage(menu, modifiers: [], updateProperties: updateProperties, type: MenuContext.self)
            }
            if let useUnderline, updateProperties, (storage.previousState as? Self)?.useUnderline != useUnderline {
                adw_split_button_set_use_underline(widget, useUnderline.cBool)
            }


        }
        for function in updateFunctions {
            function(storage, modifiers, updateProperties)
        }
        if updateProperties {
            storage.previousState = self
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
    public func menuModel(app: AdwaitaApp, window: AdwaitaWindow? = nil, @ViewBuilder _ menuModel: @escaping (() -> Body)) -> Self {
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
