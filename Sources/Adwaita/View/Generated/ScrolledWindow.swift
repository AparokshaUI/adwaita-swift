//
//  ScrolledWindow.swift
//  Adwaita
//
//  Created by auto-generation on 10.02.24.
//

import CAdw
import LevenshteinTransformations

/// `GtkScrolledWindow` is a container that makes its child scrollable.
/// 
/// It does so using either internally added scrollbars or externally
/// associated adjustments, and optionally draws a frame around the child.
/// 
/// Widgets with native scrolling support, i.e. those whose classes implement
/// the [iface@Gtk.Scrollable] interface, are added directly. For other types
/// of widget, the class [class@Gtk.Viewport] acts as an adaptor, giving
/// scrollability to other widgets. [method@Gtk.ScrolledWindow.set_child]
/// intelligently accounts for whether or not the added child is a `GtkScrollable`.
/// If it isn’t, then it wraps the child in a `GtkViewport`. Therefore, you can
/// just add any child widget and not worry about the details.
/// 
/// If [method@Gtk.ScrolledWindow.set_child] has added a `GtkViewport` for you,
/// it will be automatically removed when you unset the child.
/// Unless [property@Gtk.ScrolledWindow:hscrollbar-policy] and
/// [property@Gtk.ScrolledWindow:vscrollbar-policy] are %GTK_POLICY_NEVER or
/// %GTK_POLICY_EXTERNAL, `GtkScrolledWindow` adds internal `GtkScrollbar` widgets
/// around its child. The scroll position of the child, and if applicable the
/// scrollbars, is controlled by the [property@Gtk.ScrolledWindow:hadjustment]
/// and [property@Gtk.ScrolledWindow:vadjustment] that are associated with the
/// `GtkScrolledWindow`. See the docs on [class@Gtk.Scrollbar] for the details,
/// but note that the “step_increment” and “page_increment” fields are only
/// effective if the policy causes scrollbars to be present.
/// 
/// If a `GtkScrolledWindow` doesn’t behave quite as you would like, or
/// doesn’t have exactly the right layout, it’s very possible to set up
/// your own scrolling with `GtkScrollbar` and for example a `GtkGrid`.
/// 
/// # Touch support
/// 
/// `GtkScrolledWindow` has built-in support for touch devices. When a
/// touchscreen is used, swiping will move the scrolled window, and will
/// expose 'kinetic' behavior. This can be turned off with the
/// [property@Gtk.ScrolledWindow:kinetic-scrolling] property if it is undesired.
/// 
/// `GtkScrolledWindow` also displays visual 'overshoot' indication when
/// the content is pulled beyond the end, and this situation can be
/// captured with the [signal@Gtk.ScrolledWindow::edge-overshot] signal.
/// 
/// If no mouse device is present, the scrollbars will overlaid as
/// narrow, auto-hiding indicators over the content. If traditional
/// scrollbars are desired although no mouse is present, this behaviour
/// can be turned off with the [property@Gtk.ScrolledWindow:overlay-scrolling]
/// property.
/// 
/// # CSS nodes
/// 
/// `GtkScrolledWindow` has a main CSS node with name scrolledwindow.
/// It gets a .frame style class added when [property@Gtk.ScrolledWindow:has-frame]
/// is %TRUE.
/// 
/// It uses subnodes with names overshoot and undershoot to draw the overflow
/// and underflow indications. These nodes get the .left, .right, .top or .bottom
/// style class added depending on where the indication is drawn.
/// 
/// `GtkScrolledWindow` also sets the positional style classes (.left, .right,
/// .top, .bottom) and style classes related to overlay scrolling
/// (.overlay-indicator, .dragging, .hovering) on its scrollbars.
/// 
/// If both scrollbars are visible, the area where they meet is drawn
/// with a subnode named junction.
/// 
/// # Accessibility
/// 
/// Until GTK 4.10, `GtkScrolledWindow` used the `GTK_ACCESSIBLE_ROLE_GROUP` role.
/// 
/// Starting from GTK 4.12, `GtkScrolledWindow` uses the `GTK_ACCESSIBLE_ROLE_GENERIC` role.
public struct ScrolledWindow: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage) -> Void] = []

    /// The child widget.
    var child:  (() -> Body)?
    /// Whether to draw a frame around the contents.
    var hasFrame: Bool?
    /// Whether kinetic scrolling is enabled or not.
    /// 
    /// Kinetic scrolling only applies to devices with source %GDK_SOURCE_TOUCHSCREEN.
    var kineticScrolling: Bool?
    /// The maximum content height of @scrolled_window.
    var maxContentHeight: Int?
    /// The maximum content width of @scrolled_window.
    var maxContentWidth: Int?
    /// The minimum content height of @scrolled_window.
    var minContentHeight: Int?
    /// The minimum content width of @scrolled_window.
    var minContentWidth: Int?
    /// Whether overlay scrolling is enabled or not.
    /// 
    /// If it is, the scrollbars are only added as traditional widgets
    /// when a mouse is present. Otherwise, they are overlaid on top of
    /// the content, as narrow indicators.
    /// 
    /// Note that overlay scrolling can also be globally disabled, with
    /// the [property@Gtk.Settings:gtk-overlay-scrolling] setting.
    var overlayScrolling: Bool?
    /// Whether the natural height of the child should be calculated and propagated
    /// through the scrolled window’s requested natural height.
    /// 
    /// This is useful in cases where an attempt should be made to allocate exactly
    /// enough space for the natural size of the child.
    var propagateNaturalHeight: Bool?
    /// Whether the natural width of the child should be calculated and propagated
    /// through the scrolled window’s requested natural width.
    /// 
    /// This is useful in cases where an attempt should be made to allocate exactly
    /// enough space for the natural size of the child.
    var propagateNaturalWidth: Bool?
    /// Emitted whenever user initiated scrolling makes the scrolled
    /// window firmly surpass the limits defined by the adjustment
    /// in that orientation.
    /// 
    /// A similar behavior without edge resistance is provided by the
    /// [signal@Gtk.ScrolledWindow::edge-reached] signal.
    /// 
    /// Note: The @pos argument is LTR/RTL aware, so callers should be
    /// aware too if intending to provide behavior on horizontal edges.
    var edgeOvershot: (() -> Void)?
    /// Emitted whenever user-initiated scrolling makes the scrolled
    /// window exactly reach the lower or upper limits defined by the
    /// adjustment in that orientation.
    /// 
    /// A similar behavior with edge resistance is provided by the
    /// [signal@Gtk.ScrolledWindow::edge-overshot] signal.
    /// 
    /// Note: The @pos argument is LTR/RTL aware, so callers should be
    /// aware too if intending to provide behavior on horizontal edges.
    var edgeReached: (() -> Void)?
    /// Emitted when focus is moved away from the scrolled window by a
    /// keybinding.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    /// 
    /// The default bindings for this signal are
    /// `Ctrl + Tab` to move forward and `Ctrl + Shift + Tab` to
    /// move backward.
    var moveFocusOut: (() -> Void)?
    /// Emitted when a keybinding that scrolls is pressed.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    /// 
    /// The horizontal or vertical adjustment is updated which triggers a
    /// signal that the scrolled window’s child may listen to and scroll itself.
    var scrollChild: (() -> Void)?
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `ScrolledWindow`.
    public init() {
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(gtk_scrolled_window_new()?.opaque())
        update(storage, modifiers: modifiers, updateProperties: true)
        if let childStorage = child?().widget(modifiers: modifiers).storage(modifiers: modifiers) {
            storage.content["child"] = [childStorage]
            gtk_scrolled_window_set_child(storage.pointer, childStorage.pointer?.cast())
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
        if let edgeOvershot {
            storage.connectSignal(name: "edge-overshot", argCount: 1) {
                edgeOvershot()
            }
        }
        if let edgeReached {
            storage.connectSignal(name: "edge-reached", argCount: 1) {
                edgeReached()
            }
        }
        if let moveFocusOut {
            storage.connectSignal(name: "move-focus-out", argCount: 1) {
                moveFocusOut()
            }
        }
        if let scrollChild {
            storage.connectSignal(name: "scroll-child", argCount: 2) {
                scrollChild()
            }
        }
        storage.modify { widget in
            if let widget = storage.content["child"]?.first {
                child?().widget(modifiers: modifiers).update(widget, modifiers: modifiers, updateProperties: updateProperties)
            }
            if let hasFrame, updateProperties {
                gtk_scrolled_window_set_has_frame(widget, hasFrame.cBool)
            }
            if let kineticScrolling, updateProperties {
                gtk_scrolled_window_set_kinetic_scrolling(widget, kineticScrolling.cBool)
            }
            if let maxContentHeight, updateProperties {
                gtk_scrolled_window_set_max_content_height(widget, maxContentHeight.cInt)
            }
            if let maxContentWidth, updateProperties {
                gtk_scrolled_window_set_max_content_width(widget, maxContentWidth.cInt)
            }
            if let minContentHeight, updateProperties {
                gtk_scrolled_window_set_min_content_height(widget, minContentHeight.cInt)
            }
            if let minContentWidth, updateProperties {
                gtk_scrolled_window_set_min_content_width(widget, minContentWidth.cInt)
            }
            if let overlayScrolling, updateProperties {
                gtk_scrolled_window_set_overlay_scrolling(widget, overlayScrolling.cBool)
            }
            if let propagateNaturalHeight, updateProperties {
                gtk_scrolled_window_set_propagate_natural_height(widget, propagateNaturalHeight.cBool)
            }
            if let propagateNaturalWidth, updateProperties {
                gtk_scrolled_window_set_propagate_natural_width(widget, propagateNaturalWidth.cBool)
            }


        }
        for function in updateFunctions {
            function(storage)
        }
    }

    /// The child widget.
    public func child(@ViewBuilder _ child: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.child = child
        
        return newSelf
    }

    /// Whether to draw a frame around the contents.
    public func hasFrame(_ hasFrame: Bool? = true) -> Self {
        var newSelf = self
        newSelf.hasFrame = hasFrame
        
        return newSelf
    }

    /// Whether kinetic scrolling is enabled or not.
    /// 
    /// Kinetic scrolling only applies to devices with source %GDK_SOURCE_TOUCHSCREEN.
    public func kineticScrolling(_ kineticScrolling: Bool? = true) -> Self {
        var newSelf = self
        newSelf.kineticScrolling = kineticScrolling
        
        return newSelf
    }

    /// The maximum content height of @scrolled_window.
    public func maxContentHeight(_ maxContentHeight: Int?) -> Self {
        var newSelf = self
        newSelf.maxContentHeight = maxContentHeight
        
        return newSelf
    }

    /// The maximum content width of @scrolled_window.
    public func maxContentWidth(_ maxContentWidth: Int?) -> Self {
        var newSelf = self
        newSelf.maxContentWidth = maxContentWidth
        
        return newSelf
    }

    /// The minimum content height of @scrolled_window.
    public func minContentHeight(_ minContentHeight: Int?) -> Self {
        var newSelf = self
        newSelf.minContentHeight = minContentHeight
        
        return newSelf
    }

    /// The minimum content width of @scrolled_window.
    public func minContentWidth(_ minContentWidth: Int?) -> Self {
        var newSelf = self
        newSelf.minContentWidth = minContentWidth
        
        return newSelf
    }

    /// Whether overlay scrolling is enabled or not.
    /// 
    /// If it is, the scrollbars are only added as traditional widgets
    /// when a mouse is present. Otherwise, they are overlaid on top of
    /// the content, as narrow indicators.
    /// 
    /// Note that overlay scrolling can also be globally disabled, with
    /// the [property@Gtk.Settings:gtk-overlay-scrolling] setting.
    public func overlayScrolling(_ overlayScrolling: Bool? = true) -> Self {
        var newSelf = self
        newSelf.overlayScrolling = overlayScrolling
        
        return newSelf
    }

    /// Whether the natural height of the child should be calculated and propagated
    /// through the scrolled window’s requested natural height.
    /// 
    /// This is useful in cases where an attempt should be made to allocate exactly
    /// enough space for the natural size of the child.
    public func propagateNaturalHeight(_ propagateNaturalHeight: Bool? = true) -> Self {
        var newSelf = self
        newSelf.propagateNaturalHeight = propagateNaturalHeight
        
        return newSelf
    }

    /// Whether the natural width of the child should be calculated and propagated
    /// through the scrolled window’s requested natural width.
    /// 
    /// This is useful in cases where an attempt should be made to allocate exactly
    /// enough space for the natural size of the child.
    public func propagateNaturalWidth(_ propagateNaturalWidth: Bool? = true) -> Self {
        var newSelf = self
        newSelf.propagateNaturalWidth = propagateNaturalWidth
        
        return newSelf
    }

    /// Emitted whenever user initiated scrolling makes the scrolled
    /// window firmly surpass the limits defined by the adjustment
    /// in that orientation.
    /// 
    /// A similar behavior without edge resistance is provided by the
    /// [signal@Gtk.ScrolledWindow::edge-reached] signal.
    /// 
    /// Note: The @pos argument is LTR/RTL aware, so callers should be
    /// aware too if intending to provide behavior on horizontal edges.
    public func edgeOvershot(_ edgeOvershot: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.edgeOvershot = edgeOvershot
        return newSelf
    }

    /// Emitted whenever user-initiated scrolling makes the scrolled
    /// window exactly reach the lower or upper limits defined by the
    /// adjustment in that orientation.
    /// 
    /// A similar behavior with edge resistance is provided by the
    /// [signal@Gtk.ScrolledWindow::edge-overshot] signal.
    /// 
    /// Note: The @pos argument is LTR/RTL aware, so callers should be
    /// aware too if intending to provide behavior on horizontal edges.
    public func edgeReached(_ edgeReached: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.edgeReached = edgeReached
        return newSelf
    }

    /// Emitted when focus is moved away from the scrolled window by a
    /// keybinding.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    /// 
    /// The default bindings for this signal are
    /// `Ctrl + Tab` to move forward and `Ctrl + Shift + Tab` to
    /// move backward.
    public func moveFocusOut(_ moveFocusOut: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.moveFocusOut = moveFocusOut
        return newSelf
    }

    /// Emitted when a keybinding that scrolls is pressed.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    /// 
    /// The horizontal or vertical adjustment is updated which triggers a
    /// signal that the scrolled window’s child may listen to and scroll itself.
    public func scrollChild(_ scrollChild: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.scrollChild = scrollChild
        return newSelf
    }

}
