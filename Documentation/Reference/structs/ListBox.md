**STRUCT**

# `ListBox`

`GtkListBox` is a vertical list.

A `GtkListBox` only contains `GtkListBoxRow` children. These rows can
by dynamically sorted and filtered, and headers can be added dynamically
depending on the row content. It also allows keyboard and mouse navigation
and selection like a typical list.

Using `GtkListBox` is often an alternative to `GtkTreeView`, especially
when the list contents has a more complicated layout than what is allowed
by a `GtkCellRenderer`, or when the contents is interactive (i.e. has a
button in it).

Although a `GtkListBox` must have only `GtkListBoxRow` children, you can
add any kind of widget to it via [method@Gtk.ListBox.prepend],
[method@Gtk.ListBox.append] and [method@Gtk.ListBox.insert] and a
`GtkListBoxRow` widget will automatically be inserted between the list
and the widget.

`GtkListBoxRows` can be marked as activatable or selectable. If a row is
activatable, [signal@Gtk.ListBox::row-activated] will be emitted for it when
the user tries to activate it. If it is selectable, the row will be marked
as selected when the user tries to select it.

# GtkListBox as GtkBuildable

The `GtkListBox` implementation of the `GtkBuildable` interface supports
setting a child as the placeholder by specifying “placeholder” as the “type”
attribute of a `<child>` element. See [method@Gtk.ListBox.set_placeholder]
for info.

# CSS nodes

|[<!-- language="plain" -->
list[.separators][.rich-list][.navigation-sidebar][.boxed-list]
╰── row[.activatable]
]|

`GtkListBox` uses a single CSS node named list. It may carry the .separators
style class, when the [property@Gtk.ListBox:show-separators] property is set.
Each `GtkListBoxRow` uses a single CSS node named row. The row nodes get the
.activatable style class added when appropriate.

It may also carry the .boxed-list style class. In this case, the list will be
automatically surrounded by a frame and have separators.

The main list node may also carry style classes to select
the style of [list presentation](section-list-widget.html#list-styles):
.rich-list, .navigation-sidebar or .data-table.

# Accessibility

`GtkListBox` uses the %GTK_ACCESSIBLE_ROLE_LIST role and `GtkListBoxRow` uses
the %GTK_ACCESSIBLE_ROLE_LIST_ITEM role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `acceptUnpairedRelease`

Whether to accept unpaired release events.

### `activateOnSingleClick`

Determines whether children can be activated with a single
click, or require a double-click.

### `showSeparators`

Whether to show separators between rows.

### `activateCursorRow`

activateCursorRow

### `moveCursor`

moveCursor

### `rowActivated`

Emitted when a row has been activated by the user.

### `rowSelected`

Emitted when a new row is selected, or (with a %NULL @row)
when the selection is cleared.

When the @box is using %GTK_SELECTION_MULTIPLE, this signal will not
give you the full picture of selection changes, and you should use
the [signal@Gtk.ListBox::selected-rows-changed] signal instead.

### `selectAll`

Emitted to select all children of the box, if the selection
mode permits it.

This is a [keybinding signal](class.SignalAction.html).

The default binding for this signal is <kbd>Ctrl</kbd>-<kbd>a</kbd>.

### `selectedRowsChanged`

Emitted when the set of selected rows changes.

### `toggleCursorRow`

toggleCursorRow

### `unselectAll`

Emitted to unselect all children of the box, if the selection
mode permits it.

This is a [keybinding signal](class.SignalAction.html).

The default binding for this signal is
<kbd>Ctrl</kbd>-<kbd>Shift</kbd>-<kbd>a</kbd>.

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

Initialize `ListBox`.

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

Whether to accept unpaired release events.

### `activateOnSingleClick(_:)`

Determines whether children can be activated with a single
click, or require a double-click.

### `showSeparators(_:)`

Whether to show separators between rows.

### `activateCursorRow(_:)`

activateCursorRow

### `moveCursor(_:)`

moveCursor

### `rowActivated(_:)`

Emitted when a row has been activated by the user.

### `rowSelected(_:)`

Emitted when a new row is selected, or (with a %NULL @row)
when the selection is cleared.

When the @box is using %GTK_SELECTION_MULTIPLE, this signal will not
give you the full picture of selection changes, and you should use
the [signal@Gtk.ListBox::selected-rows-changed] signal instead.

### `selectAll(_:)`

Emitted to select all children of the box, if the selection
mode permits it.

This is a [keybinding signal](class.SignalAction.html).

The default binding for this signal is <kbd>Ctrl</kbd>-<kbd>a</kbd>.

### `selectedRowsChanged(_:)`

Emitted when the set of selected rows changes.

### `toggleCursorRow(_:)`

toggleCursorRow

### `unselectAll(_:)`

Emitted to unselect all children of the box, if the selection
mode permits it.

This is a [keybinding signal](class.SignalAction.html).

The default binding for this signal is
<kbd>Ctrl</kbd>-<kbd>Shift</kbd>-<kbd>a</kbd>.
