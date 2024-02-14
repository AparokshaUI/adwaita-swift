**STRUCT**

# `Overlay`

`GtkOverlay` is a container which contains a single main child, on top
of which it can place “overlay” widgets.

![An example GtkOverlay](overlay.png)

The position of each overlay widget is determined by its
[property@Gtk.Widget:halign] and [property@Gtk.Widget:valign]
properties. E.g. a widget with both alignments set to %GTK_ALIGN_START
will be placed at the top left corner of the `GtkOverlay` container,
whereas an overlay with halign set to %GTK_ALIGN_CENTER and valign set
to %GTK_ALIGN_END will be placed a the bottom edge of the `GtkOverlay`,
horizontally centered. The position can be adjusted by setting the margin
properties of the child to non-zero values.

More complicated placement of overlays is possible by connecting
to the [signal@Gtk.Overlay::get-child-position] signal.

An overlay’s minimum and natural sizes are those of its main child.
The sizes of overlay children are not considered when measuring these
preferred sizes.

# GtkOverlay as GtkBuildable

The `GtkOverlay` implementation of the `GtkBuildable` interface
supports placing a child as an overlay by specifying “overlay” as
the “type” attribute of a `<child>` element.

# CSS nodes

`GtkOverlay` has a single CSS node with the name “overlay”. Overlay children
whose alignments cause them to be positioned at an edge get the style classes
“.left”, “.right”, “.top”, and/or “.bottom” according to their position.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `accessibleRole`

The accessible role of the given `GtkAccessible` implementation.

The accessible role cannot be changed once set.

### `child`

The main child widget.

### `getChildPosition`

Emitted to determine the position and size of any overlay
child widgets.

A handler for this signal should fill @allocation with
the desired position and size for @widget, relative to
the 'main' child of @overlay.

The default handler for this signal uses the @widget's
halign and valign properties to determine the position
and gives the widget its natural size (except that an
alignment of %GTK_ALIGN_FILL will cause the overlay to
be full-width/height). If the main child is a
`GtkScrolledWindow`, the overlays are placed relative
to its contents.

### `overlay`

The body for the widget "overlay".

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `Overlay`.

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

The main child widget.

### `getChildPosition(_:)`

Emitted to determine the position and size of any overlay
child widgets.

A handler for this signal should fill @allocation with
the desired position and size for @widget, relative to
the 'main' child of @overlay.

The default handler for this signal uses the @widget's
halign and valign properties to determine the position
and gives the widget its natural size (except that an
alignment of %GTK_ALIGN_FILL will cause the overlay to
be full-width/height). If the main child is a
`GtkScrolledWindow`, the overlays are placed relative
to its contents.

### `overlay(_:)`

Set the body for "overlay".
- Parameter body: The body.
- Returns: The widget.
