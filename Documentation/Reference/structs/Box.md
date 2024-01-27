**STRUCT**

# `Box`

The `GtkBox` widget arranges child widgets into a single row or column.

![An example GtkBox](box.png)

Whether it is a row or column depends on the value of its
[property@Gtk.Orientable:orientation] property. Within the other
dimension, all children are allocated the same size. Of course, the
[property@Gtk.Widget:halign] and [property@Gtk.Widget:valign] properties
can be used on the children to influence their allocation.

Use repeated calls to [method@Gtk.Box.append] to pack widgets into a
`GtkBox` from start to end. Use [method@Gtk.Box.remove] to remove widgets
from the `GtkBox`. [method@Gtk.Box.insert_child_after] can be used to add
a child at a particular position.

Use [method@Gtk.Box.set_homogeneous] to specify whether or not all children
of the `GtkBox` are forced to get the same amount of space.

Use [method@Gtk.Box.set_spacing] to determine how much space will be minimally
placed between all children in the `GtkBox`. Note that spacing is added
*between* the children.

Use [method@Gtk.Box.reorder_child_after] to move a child to a different
place in the box.

# CSS nodes

`GtkBox` uses a single CSS node with name box.

# Accessibility

Until GTK 4.10, `GtkBox` used the `GTK_ACCESSIBLE_ROLE_GROUP` role.

Starting from GTK 4.12, `GtkBox` uses the `GTK_ACCESSIBLE_ROLE_GENERIC` role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `baselineChild`

The child that determines the baseline, in vertical orientation.

### `homogeneous`

Whether the children should all be the same size.

### `spacing`

The amount of space between children.

### `append`

The body for the widget "append".

### `prepend`

The body for the widget "prepend".

### `app`

The application.

### `window`

The window.

## Methods
### `init(spacing:)`

Initialize `Box`.

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

### `baselineChild(_:)`

The child that determines the baseline, in vertical orientation.

### `homogeneous(_:)`

Whether the children should all be the same size.

### `spacing(_:)`

The amount of space between children.

### `append(_:)`

Set the body for "append".
- Parameter body: The body.
- Returns: The widget.

### `prepend(_:)`

Set the body for "prepend".
- Parameter body: The body.
- Returns: The widget.
