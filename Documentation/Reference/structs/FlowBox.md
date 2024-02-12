**STRUCT**

# `FlowBox`

A `GtkFlowBox` puts child widgets in reflowing grid.

For instance, with the horizontal orientation, the widgets will be
arranged from left to right, starting a new row under the previous
row when necessary. Reducing the width in this case will require more
rows, so a larger height will be requested.

Likewise, with the vertical orientation, the widgets will be arranged
from top to bottom, starting a new column to the right when necessary.
Reducing the height will require more columns, so a larger width will
be requested.

The size request of a `GtkFlowBox` alone may not be what you expect;
if you need to be able to shrink it along both axes and dynamically
reflow its children, you may have to wrap it in a `GtkScrolledWindow`
to enable that.

The children of a `GtkFlowBox` can be dynamically sorted and filtered.

Although a `GtkFlowBox` must have only `GtkFlowBoxChild` children, you
can add any kind of widget to it via [method@Gtk.FlowBox.insert], and a
`GtkFlowBoxChild` widget will automatically be inserted between the box
and the widget.

Also see [class@Gtk.ListBox].

# CSS nodes

```
flowbox
├── flowboxchild
│   ╰── <child>├── flowboxchild
│   ╰── <child>┊
╰── [rubberband]
```

`GtkFlowBox` uses a single CSS node with name flowbox. `GtkFlowBoxChild`
uses a single CSS node with name flowboxchild. For rubberband selection,
a subnode with name rubberband is used.

# Accessibility

`GtkFlowBox` uses the %GTK_ACCESSIBLE_ROLE_GRID role, and `GtkFlowBoxChild`
uses the %GTK_ACCESSIBLE_ROLE_GRID_CELL role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `acceptUnpairedRelease`

accept-unpaired-release

### `activateOnSingleClick`

Determines whether children can be activated with a single
click, or require a double-click.

### `columnSpacing`

The amount of horizontal space between two children.

### `homogeneous`

Determines whether all children should be allocated the
same size.

### `maxChildrenPerLine`

The maximum amount of children to request space for consecutively
in the given orientation.

### `minChildrenPerLine`

The minimum number of children to allocate consecutively
in the given orientation.

Setting the minimum children per line ensures
that a reasonably small height will be requested
for the overall minimum width of the box.

### `rowSpacing`

The amount of vertical space between two children.

### `activateCursorChild`

Emitted when the user activates the @box.

This is a [keybinding signal](class.SignalAction.html).

### `childActivated`

Emitted when a child has been activated by the user.

### `moveCursor`

Emitted when the user initiates a cursor movement.

This is a [keybinding signal](class.SignalAction.html).
Applications should not connect to it, but may emit it with
g_signal_emit_by_name() if they need to control the cursor
programmatically.

The default bindings for this signal come in two variants,
the variant with the Shift modifier extends the selection,
the variant without the Shift modifier does not.
There are too many key combinations to list them all here.

- <kbd>←</kbd>, <kbd>→</kbd>, <kbd>↑</kbd>, <kbd>↓</kbd>
move by individual children
- <kbd>Home</kbd>, <kbd>End</kbd> move to the ends of the box
- <kbd>PgUp</kbd>, <kbd>PgDn</kbd> move vertically by pages

### `selectAll`

Emitted to select all children of the box,
if the selection mode permits it.

This is a [keybinding signal](class.SignalAction.html).

The default bindings for this signal is <kbd>Ctrl</kbd>-<kbd>a</kbd>.

### `selectedChildrenChanged`

Emitted when the set of selected children changes.

Use [method@Gtk.FlowBox.selected_foreach] or
[method@Gtk.FlowBox.get_selected_children] to obtain the
selected children.

### `toggleCursorChild`

Emitted to toggle the selection of the child that has the focus.

This is a [keybinding signal](class.SignalAction.html).

The default binding for this signal is <kbd>Ctrl</kbd>-<kbd>Space</kbd>.

### `unselectAll`

Emitted to unselect all children of the box,
if the selection mode permits it.

This is a [keybinding signal](class.SignalAction.html).

The default bindings for this signal is <kbd>Ctrl</kbd>-<kbd>Shift</kbd>-<kbd>a</kbd>.

### `elements`

The dynamic widget elements.

### `content`

The dynamic widget content.

### `app`

The application.

### `window`

The window.

## Methods
### `init(_:content:)`

Initialize `FlowBox`.

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

### `acceptUnpairedRelease(_:)`

accept-unpaired-release

### `activateOnSingleClick(_:)`

Determines whether children can be activated with a single
click, or require a double-click.

### `columnSpacing(_:)`

The amount of horizontal space between two children.

### `homogeneous(_:)`

Determines whether all children should be allocated the
same size.

### `maxChildrenPerLine(_:)`

The maximum amount of children to request space for consecutively
in the given orientation.

### `minChildrenPerLine(_:)`

The minimum number of children to allocate consecutively
in the given orientation.

Setting the minimum children per line ensures
that a reasonably small height will be requested
for the overall minimum width of the box.

### `rowSpacing(_:)`

The amount of vertical space between two children.

### `activateCursorChild(_:)`

Emitted when the user activates the @box.

This is a [keybinding signal](class.SignalAction.html).

### `childActivated(_:)`

Emitted when a child has been activated by the user.

### `moveCursor(_:)`

Emitted when the user initiates a cursor movement.

This is a [keybinding signal](class.SignalAction.html).
Applications should not connect to it, but may emit it with
g_signal_emit_by_name() if they need to control the cursor
programmatically.

The default bindings for this signal come in two variants,
the variant with the Shift modifier extends the selection,
the variant without the Shift modifier does not.
There are too many key combinations to list them all here.

- <kbd>←</kbd>, <kbd>→</kbd>, <kbd>↑</kbd>, <kbd>↓</kbd>
move by individual children
- <kbd>Home</kbd>, <kbd>End</kbd> move to the ends of the box
- <kbd>PgUp</kbd>, <kbd>PgDn</kbd> move vertically by pages

### `selectAll(_:)`

Emitted to select all children of the box,
if the selection mode permits it.

This is a [keybinding signal](class.SignalAction.html).

The default bindings for this signal is <kbd>Ctrl</kbd>-<kbd>a</kbd>.

### `selectedChildrenChanged(_:)`

Emitted when the set of selected children changes.

Use [method@Gtk.FlowBox.selected_foreach] or
[method@Gtk.FlowBox.get_selected_children] to obtain the
selected children.

### `toggleCursorChild(_:)`

Emitted to toggle the selection of the child that has the focus.

This is a [keybinding signal](class.SignalAction.html).

The default binding for this signal is <kbd>Ctrl</kbd>-<kbd>Space</kbd>.

### `unselectAll(_:)`

Emitted to unselect all children of the box,
if the selection mode permits it.

This is a [keybinding signal](class.SignalAction.html).

The default bindings for this signal is <kbd>Ctrl</kbd>-<kbd>Shift</kbd>-<kbd>a</kbd>.
