**STRUCT**

# `CheckButton`

A `GtkCheckButton` places a label next to an indicator.

![Example GtkCheckButtons](check-button.png)

A `GtkCheckButton` is created by calling either [ctor@Gtk.CheckButton.new]
or [ctor@Gtk.CheckButton.new_with_label].

The state of a `GtkCheckButton` can be set specifically using
[method@Gtk.CheckButton.set_active], and retrieved using
[method@Gtk.CheckButton.get_active].

# Inconsistent state

In addition to "on" and "off", check buttons can be an
"in between" state that is neither on nor off. This can be used
e.g. when the user has selected a range of elements (such as some
text or spreadsheet cells) that are affected by a check button,
and the current values in that range are inconsistent.

To set a `GtkCheckButton` to inconsistent state, use
[method@Gtk.CheckButton.set_inconsistent].

# Grouping

Check buttons can be grouped together, to form mutually exclusive
groups - only one of the buttons can be toggled at a time, and toggling
another one will switch the currently toggled one off.

Grouped check buttons use a different indicator, and are commonly referred
to as *radio buttons*.

![Example GtkCheckButtons](radio-button.png)

To add a `GtkCheckButton` to a group, use [method@Gtk.CheckButton.set_group].

When the code must keep track of the state of a group of radio buttons, it
is recommended to keep track of such state through a stateful
`GAction` with a target for each button. Using the `toggled` signals to keep
track of the group changes and state is discouraged.

# CSS nodes

```
checkbutton[.text-button]
├── check
╰── [label]
```

A `GtkCheckButton` has a main node with name checkbutton. If the
[property@Gtk.CheckButton:label] or [property@Gtk.CheckButton:child]
properties are set, it contains a child widget. The indicator node
is named check when no group is set, and radio if the checkbutton
is grouped together with other checkbuttons.

# Accessibility

`GtkCheckButton` uses the %GTK_ACCESSIBLE_ROLE_CHECKBOX role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `accessibleRole`

The accessible role of the given `GtkAccessible` implementation.

The accessible role cannot be changed once set.

### `actionName`

action-name

### `active`

If the check button is active.

Setting `active` to %TRUE will add the `:checked:` state to both
the check button and the indicator CSS node.

### `child`

The child widget.

### `inconsistent`

If the check button is in an “in between” state.

The inconsistent state only affects visual appearance,
not the semantics of the button.

### `label`

Text of the label inside the check button, if it contains a label widget.

### `useUnderline`

If set, an underline in the text indicates that the following
character is to be used as mnemonic.

### `activate`

Emitted to when the check button is activated.

The `::activate` signal on `GtkCheckButton` is an action signal and
emitting it causes the button to animate press then release.

Applications should never connect to this signal, but use the
[signal@Gtk.CheckButton::toggled] signal.

The default bindings for this signal are all forms of the
<kbd>␣</kbd> and <kbd>Enter</kbd> keys.

### `toggled`

Emitted when the buttons's [property@Gtk.CheckButton:active]
property changes.

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `CheckButton`.

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

### `actionName(_:)`

action-name

### `active(_:)`

If the check button is active.

Setting `active` to %TRUE will add the `:checked:` state to both
the check button and the indicator CSS node.

### `child(_:)`

The child widget.

### `inconsistent(_:)`

If the check button is in an “in between” state.

The inconsistent state only affects visual appearance,
not the semantics of the button.

### `label(_:)`

Text of the label inside the check button, if it contains a label widget.

### `useUnderline(_:)`

If set, an underline in the text indicates that the following
character is to be used as mnemonic.

### `activate(_:)`

Emitted to when the check button is activated.

The `::activate` signal on `GtkCheckButton` is an action signal and
emitting it causes the button to animate press then release.

Applications should never connect to this signal, but use the
[signal@Gtk.CheckButton::toggled] signal.

The default bindings for this signal are all forms of the
<kbd>␣</kbd> and <kbd>Enter</kbd> keys.

### `toggled(_:)`

Emitted when the buttons's [property@Gtk.CheckButton:active]
property changes.
