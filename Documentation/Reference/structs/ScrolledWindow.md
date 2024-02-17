**STRUCT**

# `ScrolledWindow`

`GtkScrolledWindow` is a container that makes its child scrollable.

It does so using either internally added scrollbars or externally
associated adjustments, and optionally draws a frame around the child.

Widgets with native scrolling support, i.e. those whose classes implement
the [iface@Gtk.Scrollable] interface, are added directly. For other types
of widget, the class [class@Gtk.Viewport] acts as an adaptor, giving
scrollability to other widgets. [method@Gtk.ScrolledWindow.set_child]
intelligently accounts for whether or not the added child is a `GtkScrollable`.
If it isn’t, then it wraps the child in a `GtkViewport`. Therefore, you can
just add any child widget and not worry about the details.

If [method@Gtk.ScrolledWindow.set_child] has added a `GtkViewport` for you,
it will be automatically removed when you unset the child.
Unless [property@Gtk.ScrolledWindow:hscrollbar-policy] and
[property@Gtk.ScrolledWindow:vscrollbar-policy] are %GTK_POLICY_NEVER or
%GTK_POLICY_EXTERNAL, `GtkScrolledWindow` adds internal `GtkScrollbar` widgets
around its child. The scroll position of the child, and if applicable the
scrollbars, is controlled by the [property@Gtk.ScrolledWindow:hadjustment]
and [property@Gtk.ScrolledWindow:vadjustment] that are associated with the
`GtkScrolledWindow`. See the docs on [class@Gtk.Scrollbar] for the details,
but note that the “step_increment” and “page_increment” fields are only
effective if the policy causes scrollbars to be present.

If a `GtkScrolledWindow` doesn’t behave quite as you would like, or
doesn’t have exactly the right layout, it’s very possible to set up
your own scrolling with `GtkScrollbar` and for example a `GtkGrid`.

# Touch support

`GtkScrolledWindow` has built-in support for touch devices. When a
touchscreen is used, swiping will move the scrolled window, and will
expose 'kinetic' behavior. This can be turned off with the
[property@Gtk.ScrolledWindow:kinetic-scrolling] property if it is undesired.

`GtkScrolledWindow` also displays visual 'overshoot' indication when
the content is pulled beyond the end, and this situation can be
captured with the [signal@Gtk.ScrolledWindow::edge-overshot] signal.

If no mouse device is present, the scrollbars will overlaid as
narrow, auto-hiding indicators over the content. If traditional
scrollbars are desired although no mouse is present, this behaviour
can be turned off with the [property@Gtk.ScrolledWindow:overlay-scrolling]
property.

# CSS nodes

`GtkScrolledWindow` has a main CSS node with name scrolledwindow.
It gets a .frame style class added when [property@Gtk.ScrolledWindow:has-frame]
is %TRUE.

It uses subnodes with names overshoot and undershoot to draw the overflow
and underflow indications. These nodes get the .left, .right, .top or .bottom
style class added depending on where the indication is drawn.

`GtkScrolledWindow` also sets the positional style classes (.left, .right,
.top, .bottom) and style classes related to overlay scrolling
(.overlay-indicator, .dragging, .hovering) on its scrollbars.

If both scrollbars are visible, the area where they meet is drawn
with a subnode named junction.

# Accessibility

Until GTK 4.10, `GtkScrolledWindow` used the `GTK_ACCESSIBLE_ROLE_GROUP` role.

Starting from GTK 4.12, `GtkScrolledWindow` uses the `GTK_ACCESSIBLE_ROLE_GENERIC` role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `accessibleRole`

The accessible role of the given `GtkAccessible` implementation.

The accessible role cannot be changed once set.

### `child`

The child widget.

When setting this property, if the child widget does not implement
[iface@Gtk.Scrollable], the scrolled window will add the child to
a [class@Gtk.Viewport] and then set the viewport as the child.

### `hasFrame`

Whether to draw a frame around the contents.

### `kineticScrolling`

Whether kinetic scrolling is enabled or not.

Kinetic scrolling only applies to devices with source %GDK_SOURCE_TOUCHSCREEN.

### `maxContentHeight`

The maximum content height of @scrolled_window.

### `maxContentWidth`

The maximum content width of @scrolled_window.

### `minContentHeight`

The minimum content height of @scrolled_window.

### `minContentWidth`

The minimum content width of @scrolled_window.

### `overlayScrolling`

Whether overlay scrolling is enabled or not.

If it is, the scrollbars are only added as traditional widgets
when a mouse is present. Otherwise, they are overlaid on top of
the content, as narrow indicators.

Note that overlay scrolling can also be globally disabled, with
the [property@Gtk.Settings:gtk-overlay-scrolling] setting.

### `propagateNaturalHeight`

Whether the natural height of the child should be calculated and propagated
through the scrolled window’s requested natural height.

This is useful in cases where an attempt should be made to allocate exactly
enough space for the natural size of the child.

### `propagateNaturalWidth`

Whether the natural width of the child should be calculated and propagated
through the scrolled window’s requested natural width.

This is useful in cases where an attempt should be made to allocate exactly
enough space for the natural size of the child.

### `edgeOvershot`

Emitted whenever user initiated scrolling makes the scrolled
window firmly surpass the limits defined by the adjustment
in that orientation.

A similar behavior without edge resistance is provided by the
[signal@Gtk.ScrolledWindow::edge-reached] signal.

Note: The @pos argument is LTR/RTL aware, so callers should be
aware too if intending to provide behavior on horizontal edges.

### `edgeReached`

Emitted whenever user-initiated scrolling makes the scrolled
window exactly reach the lower or upper limits defined by the
adjustment in that orientation.

A similar behavior with edge resistance is provided by the
[signal@Gtk.ScrolledWindow::edge-overshot] signal.

Note: The @pos argument is LTR/RTL aware, so callers should be
aware too if intending to provide behavior on horizontal edges.

### `moveFocusOut`

Emitted when focus is moved away from the scrolled window by a
keybinding.

This is a [keybinding signal](class.SignalAction.html).

The default bindings for this signal are
`Ctrl + Tab` to move forward and `Ctrl + Shift + Tab` to
move backward.

### `scrollChild`

Emitted when a keybinding that scrolls is pressed.

This is a [keybinding signal](class.SignalAction.html).

The horizontal or vertical adjustment is updated which triggers a
signal that the scrolled window’s child may listen to and scroll itself.

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `ScrolledWindow`.

### `container(modifiers:)`

Get the widget's view storage.
- Parameter modifiers: The view modifiers.
- Returns: The view storage.

### `update(_:modifiers:updateProperties:)`

Update the widget's view storage.
- Parameters:
    - storage: The view storage.
    - modifiers: The view modifiers.
    - updateProperties: Whether to update the view's properties.

### `accessibleRole(_:)`

The accessible role of the given `GtkAccessible` implementation.

The accessible role cannot be changed once set.

### `child(_:)`

The child widget.

When setting this property, if the child widget does not implement
[iface@Gtk.Scrollable], the scrolled window will add the child to
a [class@Gtk.Viewport] and then set the viewport as the child.

### `hasFrame(_:)`

Whether to draw a frame around the contents.

### `kineticScrolling(_:)`

Whether kinetic scrolling is enabled or not.

Kinetic scrolling only applies to devices with source %GDK_SOURCE_TOUCHSCREEN.

### `maxContentHeight(_:)`

The maximum content height of @scrolled_window.

### `maxContentWidth(_:)`

The maximum content width of @scrolled_window.

### `minContentHeight(_:)`

The minimum content height of @scrolled_window.

### `minContentWidth(_:)`

The minimum content width of @scrolled_window.

### `overlayScrolling(_:)`

Whether overlay scrolling is enabled or not.

If it is, the scrollbars are only added as traditional widgets
when a mouse is present. Otherwise, they are overlaid on top of
the content, as narrow indicators.

Note that overlay scrolling can also be globally disabled, with
the [property@Gtk.Settings:gtk-overlay-scrolling] setting.

### `propagateNaturalHeight(_:)`

Whether the natural height of the child should be calculated and propagated
through the scrolled window’s requested natural height.

This is useful in cases where an attempt should be made to allocate exactly
enough space for the natural size of the child.

### `propagateNaturalWidth(_:)`

Whether the natural width of the child should be calculated and propagated
through the scrolled window’s requested natural width.

This is useful in cases where an attempt should be made to allocate exactly
enough space for the natural size of the child.

### `edgeOvershot(_:)`

Emitted whenever user initiated scrolling makes the scrolled
window firmly surpass the limits defined by the adjustment
in that orientation.

A similar behavior without edge resistance is provided by the
[signal@Gtk.ScrolledWindow::edge-reached] signal.

Note: The @pos argument is LTR/RTL aware, so callers should be
aware too if intending to provide behavior on horizontal edges.

### `edgeReached(_:)`

Emitted whenever user-initiated scrolling makes the scrolled
window exactly reach the lower or upper limits defined by the
adjustment in that orientation.

A similar behavior with edge resistance is provided by the
[signal@Gtk.ScrolledWindow::edge-overshot] signal.

Note: The @pos argument is LTR/RTL aware, so callers should be
aware too if intending to provide behavior on horizontal edges.

### `moveFocusOut(_:)`

Emitted when focus is moved away from the scrolled window by a
keybinding.

This is a [keybinding signal](class.SignalAction.html).

The default bindings for this signal are
`Ctrl + Tab` to move forward and `Ctrl + Shift + Tab` to
move backward.

### `scrollChild(_:)`

Emitted when a keybinding that scrolls is pressed.

This is a [keybinding signal](class.SignalAction.html).

The horizontal or vertical adjustment is updated which triggers a
signal that the scrolled window’s child may listen to and scroll itself.
