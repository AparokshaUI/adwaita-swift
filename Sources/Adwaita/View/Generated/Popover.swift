//
//  Popover.swift
//  Adwaita
//
//  Created by auto-generation on 15.08.24.
//

import CAdw
import LevenshteinTransformations

/// `GtkPopover` is a bubble-like context popup.
/// 
/// ![An example GtkPopover](popover.png)
/// 
/// It is primarily meant to provide context-dependent information
/// or options. Popovers are attached to a parent widget. By default,
/// they point to the whole widget area, although this behavior can be
/// changed with [method@Gtk.Popover.set_pointing_to].
/// 
/// The position of a popover relative to the widget it is attached to
/// can also be changed with [method@Gtk.Popover.set_position]
/// 
/// By default, `GtkPopover` performs a grab, in order to ensure input
/// events get redirected to it while it is shown, and also so the popover
/// is dismissed in the expected situations (clicks outside the popover,
/// or the Escape key being pressed). If no such modal behavior is desired
/// on a popover, [method@Gtk.Popover.set_autohide] may be called on it to
/// tweak its behavior.
/// 
/// ## GtkPopover as menu replacement
/// 
/// `GtkPopover` is often used to replace menus. The best was to do this
/// is to use the [class@Gtk.PopoverMenu] subclass which supports being
/// populated from a `GMenuModel` with [ctor@Gtk.PopoverMenu.new_from_model].
/// 
/// ```xml
/// <section><attribute name="display-hint">horizontal-buttons</attribute><item><attribute name="label">Cut</attribute><attribute name="action">app.cut</attribute><attribute name="verb-icon">edit-cut-symbolic</attribute></item><item><attribute name="label">Copy</attribute><attribute name="action">app.copy</attribute><attribute name="verb-icon">edit-copy-symbolic</attribute></item><item><attribute name="label">Paste</attribute><attribute name="action">app.paste</attribute><attribute name="verb-icon">edit-paste-symbolic</attribute></item></section>
/// ```
/// 
/// # CSS nodes
/// 
/// ```
/// popover.background[.menu]
/// ├── arrow
/// ╰── contents
/// ╰── <child>
/// ```
/// 
/// `GtkPopover` has a main node with name `popover`, an arrow with name `arrow`,
/// and another node for the content named `contents`. The `popover` node always
/// gets the `.background` style class. It also gets the `.menu` style class
/// if the popover is menu-like, e.g. is a [class@Gtk.PopoverMenu].
/// 
/// Particular uses of `GtkPopover`, such as touch selection popups or
/// magnifiers in `GtkEntry` or `GtkTextView` get style classes like
/// `.touch-selection` or `.magnifier` to differentiate from plain popovers.
/// 
/// When styling a popover directly, the `popover` node should usually
/// not have any background. The visible part of the popover can have
/// a shadow. To specify it in CSS, set the box-shadow of the `contents` node.
/// 
/// Note that, in order to accomplish appropriate arrow visuals, `GtkPopover`
/// uses custom drawing for the `arrow` node. This makes it possible for the
/// arrow to change its shape dynamically, but it also limits the possibilities
/// of styling it using CSS. In particular, the `arrow` gets drawn over the
/// `content` node's border and shadow, so they look like one shape, which
/// means that the border width of the `content` node and the `arrow` node should
/// be the same. The arrow also does not support any border shape other than
/// solid, no border-radius, only one border width (border-bottom-width is
/// used) and no box-shadow.
public struct Popover: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, WidgetData, Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, WidgetData) -> Void] = []

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    var accessibleRole: String?
    /// Whether to dismiss the popover on outside clicks.
    var autohide: Bool?
    /// Whether the popover pops down after a child popover.
    /// 
    /// This is used to implement the expected behavior of submenus.
    var cascadePopdown: Bool?
    /// The child widget.
    var child: (() -> Body)?
    /// The default widget inside the popover.
    var defaultWidget: (() -> Body)?
    /// Whether to draw an arrow.
    var hasArrow: Bool?
    /// Whether mnemonics are currently visible in this popover.
    var mnemonicsVisible: Bool?
    /// Emitted whend the user activates the default widget.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    var activateDefault: (() -> Void)?
    /// Emitted when the popover is closed.
    var closed: (() -> Void)?

    /// Initialize `Popover`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(gtk_popover_new()?.opaque())
        for function in appearFunctions {
            function(storage, data)
        }
        update(storage, data: data, updateProperties: true, type: type)
        if let childStorage = child?().storage(data: data, type: type) {
            storage.content["child"] = [childStorage]
            gtk_popover_set_child(storage.opaquePointer?.cast(), childStorage.opaquePointer?.cast())
        }
        if let defaultWidgetStorage = defaultWidget?().storage(data: data, type: type) {
            storage.content["defaultWidget"] = [defaultWidgetStorage]
            gtk_popover_set_default_widget(storage.opaquePointer?.cast(), defaultWidgetStorage.opaquePointer?.cast())
        }

        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The type of the app storage.
    public func update<Data>(_ storage: ViewStorage, data: WidgetData, updateProperties: Bool, type: Data.Type) where Data: ViewRenderData {
        if let activateDefault {
            storage.connectSignal(name: "activate-default", argCount: 0) {
                activateDefault()
            }
        }
        if let closed {
            storage.connectSignal(name: "closed", argCount: 0) {
                closed()
            }
        }
        storage.modify { widget in

            if let autohide, updateProperties, (storage.previousState as? Self)?.autohide != autohide {
                gtk_popover_set_autohide(widget?.cast(), autohide.cBool)
            }
            if let cascadePopdown, updateProperties, (storage.previousState as? Self)?.cascadePopdown != cascadePopdown {
                gtk_popover_set_cascade_popdown(widget?.cast(), cascadePopdown.cBool)
            }
            if let widget = storage.content["child"]?.first {
                child?().updateStorage(widget, data: data, updateProperties: updateProperties, type: type)
            }
            if let widget = storage.content["defaultWidget"]?.first {
                defaultWidget?().updateStorage(widget, data: data, updateProperties: updateProperties, type: type)
            }
            if let hasArrow, updateProperties, (storage.previousState as? Self)?.hasArrow != hasArrow {
                gtk_popover_set_has_arrow(widget?.cast(), hasArrow.cBool)
            }
            if let mnemonicsVisible, updateProperties, (storage.previousState as? Self)?.mnemonicsVisible != mnemonicsVisible {
                gtk_popover_set_mnemonics_visible(widget?.cast(), mnemonicsVisible.cBool)
            }


        }
        for function in updateFunctions {
            function(storage, data, updateProperties)
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

    /// Whether to dismiss the popover on outside clicks.
    public func autohide(_ autohide: Bool? = true) -> Self {
        var newSelf = self
        newSelf.autohide = autohide
        
        return newSelf
    }

    /// Whether the popover pops down after a child popover.
    /// 
    /// This is used to implement the expected behavior of submenus.
    public func cascadePopdown(_ cascadePopdown: Bool? = true) -> Self {
        var newSelf = self
        newSelf.cascadePopdown = cascadePopdown
        
        return newSelf
    }

    /// The child widget.
    public func child(@ViewBuilder _ child: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.child = child
        
        return newSelf
    }

    /// The default widget inside the popover.
    public func defaultWidget(@ViewBuilder _ defaultWidget: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.defaultWidget = defaultWidget
        
        return newSelf
    }

    /// Whether to draw an arrow.
    public func hasArrow(_ hasArrow: Bool? = true) -> Self {
        var newSelf = self
        newSelf.hasArrow = hasArrow
        
        return newSelf
    }

    /// Whether mnemonics are currently visible in this popover.
    public func mnemonicsVisible(_ mnemonicsVisible: Bool? = true) -> Self {
        var newSelf = self
        newSelf.mnemonicsVisible = mnemonicsVisible
        
        return newSelf
    }

    /// Emitted whend the user activates the default widget.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    public func activateDefault(_ activateDefault: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.activateDefault = activateDefault
        return newSelf
    }

    /// Emitted when the popover is closed.
    public func closed(_ closed: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.closed = closed
        return newSelf
    }

}
