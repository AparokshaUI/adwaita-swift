//
//  Menu.swift
//  Adwaita
//
//  Created by auto-generation on 21.07.24.
//

import CAdw
import LevenshteinTransformations

/// The `GtkMenuButton` widget is used to display a popup when clicked.
/// 
/// ![An example GtkMenuButton](menu-button.png)
/// 
/// This popup can be provided either as a `GtkPopover` or as an abstract
/// `GMenuModel`.
/// 
/// The `GtkMenuButton` widget can show either an icon (set with the
/// [property@Gtk.MenuButton:icon-name] property) or a label (set with the
/// [property@Gtk.MenuButton:label] property). If neither is explicitly set,
/// a [class@Gtk.Image] is automatically created, using an arrow image oriented
/// according to [property@Gtk.MenuButton:direction] or the generic
/// “open-menu-symbolic” icon if the direction is not set.
/// 
/// The positioning of the popup is determined by the
/// [property@Gtk.MenuButton:direction] property of the menu button.
/// 
/// For menus, the [property@Gtk.Widget:halign] and [property@Gtk.Widget:valign]
/// properties of the menu are also taken into account. For example, when the
/// direction is %GTK_ARROW_DOWN and the horizontal alignment is %GTK_ALIGN_START,
/// the menu will be positioned below the button, with the starting edge
/// (depending on the text direction) of the menu aligned with the starting
/// edge of the button. If there is not enough space below the button, the
/// menu is popped up above the button instead. If the alignment would move
/// part of the menu offscreen, it is “pushed in”.
/// 
/// |           | start                | center                | end                |
/// | -         | ---                  | ---                   | ---                |
/// | **down**  | ![](down-start.png)  | ![](down-center.png)  | ![](down-end.png)  |
/// | **up**    | ![](up-start.png)    | ![](up-center.png)    | ![](up-end.png)    |
/// | **left**  | ![](left-start.png)  | ![](left-center.png)  | ![](left-end.png)  |
/// | **right** | ![](right-start.png) | ![](right-center.png) | ![](right-end.png) |
/// 
/// # CSS nodes
/// 
/// ```
/// menubutton
/// ╰── button.toggle
/// ╰── <content>╰── [arrow]
/// ```
/// 
/// `GtkMenuButton` has a single CSS node with name `menubutton`
/// which contains a `button` node with a `.toggle` style class.
/// 
/// If the button contains an icon, it will have the `.image-button` style class,
/// if it contains text, it will have `.text-button` style class. If an arrow is
/// visible in addition to an icon, text or a custom child, it will also have
/// `.arrow-button` style class.
/// 
/// Inside the toggle button content, there is an `arrow` node for
/// the indicator, which will carry one of the `.none`, `.up`, `.down`,
/// `.left` or `.right` style classes to indicate the direction that
/// the menu will appear in. The CSS is expected to provide a suitable
/// image for each of these cases using the `-gtk-icon-source` property.
/// 
/// Optionally, the `menubutton` node can carry the `.circular` style class
/// to request a round appearance.
/// 
/// # Accessibility
/// 
/// `GtkMenuButton` uses the %GTK_ACCESSIBLE_ROLE_BUTTON role.
public struct Menu: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(View) -> View], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(View) -> View]) -> Void] = []

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    var accessibleRole: String?
    /// Whether the menu button is active.
    var active: Binding<Bool>?
    /// Whether to show a dropdown arrow even when using an icon or a custom child.
    var alwaysShowArrow: Bool?
    /// Whether the size of the button can be made smaller than the natural
    /// size of its contents.
    var canShrink: Bool?
    /// The child widget.
    var child:  (() -> Body)?
    /// Whether the button has a frame.
    var hasFrame: Bool?
    /// The name of the icon used to automatically populate the button.
    var iconName: String?
    /// The label for the button.
    var label: String?
    /// The `GMenuModel` from which the popup will be created.
    /// 
    /// See [method@Gtk.MenuButton.set_menu_model] for the interaction
    /// with the [property@Gtk.MenuButton:popover] property.
    var menuModel:  (() -> MenuContent)?
    /// Whether the menu button acts as a primary menu.
    /// 
    /// Primary menus can be opened using the <kbd>F10</kbd> key
    var primary: Bool?
    /// If set an underscore in the text indicates a mnemonic.
    var useUnderline: Bool?
    /// Emitted to when the menu button is activated.
    /// 
    /// The `::activate` signal on `GtkMenuButton` is an action signal and
    /// emitting it causes the button to pop up its menu.
    var activate: (() -> Void)?
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `Menu`.
    public init() {
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(gtk_menu_button_new()?.opaque())
        for function in appearFunctions {
            function(storage, modifiers)
        }
        update(storage, modifiers: modifiers, updateProperties: true)
        if let childStorage = child?().widget(modifiers: modifiers).storage(modifiers: modifiers) {
            storage.content["child"] = [childStorage]
            gtk_menu_button_set_child(storage.pointer, childStorage.pointer?.cast())
        }
        if let declarative = menuModel?(), let app {
            let menu = g_menu_new()
            gtk_menu_button_set_menu_model(storage.pointer, menu?.cast())
            for item in declarative {
                item.addMenuItems(menu: menu, app: app, window: window)
            }
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
        storage.modify { widget in

        storage.notify(name: "active") {
            let newValue = gtk_menu_button_get_active(storage.pointer) != 0
if let active, newValue != active.wrappedValue {
    active.wrappedValue = newValue
}
        }
            if let active, updateProperties, (gtk_menu_button_get_active(storage.pointer) != 0) != active.wrappedValue {
                gtk_menu_button_set_active(storage.pointer, active.wrappedValue.cBool)
            }
            if let alwaysShowArrow, updateProperties {
                gtk_menu_button_set_always_show_arrow(widget, alwaysShowArrow.cBool)
            }
            if let canShrink, updateProperties {
                gtk_menu_button_set_can_shrink(widget, canShrink.cBool)
            }
            if let widget = storage.content["child"]?.first {
                child?().widget(modifiers: modifiers).update(widget, modifiers: modifiers, updateProperties: updateProperties)
            }
            if let hasFrame, updateProperties {
                gtk_menu_button_set_has_frame(widget, hasFrame.cBool)
            }
            if let iconName, updateProperties {
                gtk_menu_button_set_icon_name(widget, iconName)
            }
            if let label, storage.content["child"] == nil, updateProperties {
                gtk_menu_button_set_label(widget, label)
            }
            if let primary, updateProperties {
                gtk_menu_button_set_primary(widget, primary.cBool)
            }
            if let useUnderline, updateProperties {
                gtk_menu_button_set_use_underline(widget, useUnderline.cBool)
            }


        }
        for function in updateFunctions {
            function(storage, modifiers, updateProperties)
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

    /// Whether the menu button is active.
    public func active(_ active: Binding<Bool>?) -> Self {
        var newSelf = self
        newSelf.active = active
        
        return newSelf
    }

    /// Whether to show a dropdown arrow even when using an icon or a custom child.
    public func alwaysShowArrow(_ alwaysShowArrow: Bool? = true) -> Self {
        var newSelf = self
        newSelf.alwaysShowArrow = alwaysShowArrow
        
        return newSelf
    }

    /// Whether the size of the button can be made smaller than the natural
    /// size of its contents.
    public func canShrink(_ canShrink: Bool? = true) -> Self {
        var newSelf = self
        newSelf.canShrink = canShrink
        
        return newSelf
    }

    /// The child widget.
    public func child(@ViewBuilder _ child: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.child = child
        
        return newSelf
    }

    /// Whether the button has a frame.
    public func hasFrame(_ hasFrame: Bool? = true) -> Self {
        var newSelf = self
        newSelf.hasFrame = hasFrame
        
        return newSelf
    }

    /// The name of the icon used to automatically populate the button.
    public func iconName(_ iconName: String?) -> Self {
        var newSelf = self
        newSelf.iconName = iconName
        
        return newSelf
    }

    /// The label for the button.
    public func label(_ label: String?) -> Self {
        var newSelf = self
        newSelf.label = label
        
        return newSelf
    }

    /// The `GMenuModel` from which the popup will be created.
    /// 
    /// See [method@Gtk.MenuButton.set_menu_model] for the interaction
    /// with the [property@Gtk.MenuButton:popover] property.
    public func menuModel(app: GTUIApp, window: GTUIApplicationWindow? = nil, @MenuBuilder _ menuModel: @escaping (() -> MenuContent)) -> Self {
        var newSelf = self
        newSelf.menuModel = menuModel
        newSelf.app = app; newSelf.window = window
        return newSelf
    }

    /// Whether the menu button acts as a primary menu.
    /// 
    /// Primary menus can be opened using the <kbd>F10</kbd> key
    public func primary(_ primary: Bool? = true) -> Self {
        var newSelf = self
        newSelf.primary = primary
        
        return newSelf
    }

    /// If set an underscore in the text indicates a mnemonic.
    public func useUnderline(_ useUnderline: Bool? = true) -> Self {
        var newSelf = self
        newSelf.useUnderline = useUnderline
        
        return newSelf
    }

    /// Emitted to when the menu button is activated.
    /// 
    /// The `::activate` signal on `GtkMenuButton` is an action signal and
    /// emitting it causes the button to pop up its menu.
    public func activate(_ activate: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.activate = activate
        return newSelf
    }

}
