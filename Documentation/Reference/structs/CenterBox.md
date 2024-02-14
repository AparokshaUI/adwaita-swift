**STRUCT**

# `CenterBox`

`GtkCenterBox` arranges three children in a row, keeping the middle child
centered as well as possible.

![An example GtkCenterBox](centerbox.png)

To add children to `GtkCenterBox`, use [method@Gtk.CenterBox.set_start_widget],
[method@Gtk.CenterBox.set_center_widget] and
[method@Gtk.CenterBox.set_end_widget].

The sizing and positioning of children can be influenced with the
align and expand properties of the children.

# GtkCenterBox as GtkBuildable

The `GtkCenterBox` implementation of the `GtkBuildable` interface
supports placing children in the 3 positions by specifying “start”, “center”
or “end” as the “type” attribute of a `<child>` element.

# CSS nodes

`GtkCenterBox` uses a single CSS node with the name “box”,

The first child of the `GtkCenterBox` will be allocated depending on the
text direction, i.e. in left-to-right layouts it will be allocated on the
left and in right-to-left layouts on the right.

In vertical orientation, the nodes of the children are arranged from top to
bottom.

# Accessibility

Until GTK 4.10, `GtkCenterBox` used the `GTK_ACCESSIBLE_ROLE_GROUP` role.

Starting from GTK 4.12, `GtkCenterBox` uses the `GTK_ACCESSIBLE_ROLE_GENERIC` role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `accessibleRole`

The accessible role of the given `GtkAccessible` implementation.

The accessible role cannot be changed once set.

### `centerWidget`

The widget that is placed at the center position.

### `endWidget`

The widget that is placed at the end position.

In vertical orientation, the end position is at the bottom.
In horizontal orientation, the end position is at the trailing
edge wrt. to the text direction.

### `shrinkCenterLast`

Whether to shrink the center widget after other children.

By default, when there's no space to give all three children their
natural widths, the start and end widgets start shrinking and the
center child keeps natural width until they reach minimum width.

If set to `FALSE`, start and end widgets keep natural width and the
center widget starts shrinking instead.

### `startWidget`

The widget that is placed at the start position.

In vertical orientation, the start position is at the top.
In horizontal orientation, the start position is at the leading
edge wrt. to the text direction.

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `CenterBox`.

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

### `centerWidget(_:)`

The widget that is placed at the center position.

### `endWidget(_:)`

The widget that is placed at the end position.

In vertical orientation, the end position is at the bottom.
In horizontal orientation, the end position is at the trailing
edge wrt. to the text direction.

### `shrinkCenterLast(_:)`

Whether to shrink the center widget after other children.

By default, when there's no space to give all three children their
natural widths, the start and end widgets start shrinking and the
center child keeps natural width until they reach minimum width.

If set to `FALSE`, start and end widgets keep natural width and the
center widget starts shrinking instead.

### `startWidget(_:)`

The widget that is placed at the start position.

In vertical orientation, the start position is at the top.
In horizontal orientation, the start position is at the leading
edge wrt. to the text direction.
