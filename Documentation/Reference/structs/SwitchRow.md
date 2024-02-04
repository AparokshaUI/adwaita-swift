**STRUCT**

# `SwitchRow`

A [class@Gtk.ListBoxRow] used to represent two states.

<picture><source srcset="switch-row-dark.png" media="(prefers-color-scheme: dark)"><img src="switch-row.png" alt="switch-row"></picture>

The `AdwSwitchRow` widget contains a [class@Gtk.Switch] that allows the user
to select between two states: "on" or "off". When activated, the row will
invert its active state.

The user can control the switch by activating the row or by dragging on the
switch handle.

See [class@Gtk.Switch] for details.

Example of an `AdwSwitchRow` UI definition:
```xml
<object class="AdwSwitchRow"><property name="title" translatable="yes">Switch Row</property><signal name="notify::active" handler="switch_row_notify_active_cb"/></object>
```

The [property@SwitchRow:active] property should be connected to in order to
monitor changes to the active state.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `active`

Whether the switch row is in the "on" or "off" position.

### `activatableWidget`

The widget to activate when the row is activated.

The row can be activated either by clicking on it, calling
[method@ActionRow.activate], or via mnemonics in the title.
See the [property@PreferencesRow:use-underline] property to enable
mnemonics.

The target widget will be activated by emitting the
[signal@Gtk.Widget::mnemonic-activate] signal on it.

### `iconName`

The icon name for this row.

### `subtitle`

The subtitle for this row.

The subtitle is interpreted as Pango markup unless
[property@PreferencesRow:use-markup] is set to `FALSE`.

### `subtitleLines`

The number of lines at the end of which the subtitle label will be
ellipsized.

If the value is 0, the number of lines won't be limited.

### `subtitleSelectable`

Whether the user can copy the subtitle from the label.

See also [property@Gtk.Label:selectable].

### `titleLines`

The number of lines at the end of which the title label will be ellipsized.

If the value is 0, the number of lines won't be limited.

### `title`

The title of the preference represented by this row.

The title is interpreted as Pango markup unless
[property@PreferencesRow:use-markup] is set to `FALSE`.

### `titleSelectable`

Whether the user can copy the title from the label.

See also [property@Gtk.Label:selectable].

### `useMarkup`

Whether to use Pango markup for the title label.

Subclasses may also use it for other labels, such as subtitle.

See also [func@Pango.parse_markup].

### `useUnderline`

Whether an embedded underline in the title indicates a mnemonic.

### `activated`

This signal is emitted after the row has been activated.

### `suffix`

The body for the widget "suffix".

### `prefix`

The body for the widget "prefix".

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `SwitchRow`.

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

### `active(_:)`

Whether the switch row is in the "on" or "off" position.

### `activatableWidget(_:)`

The widget to activate when the row is activated.

The row can be activated either by clicking on it, calling
[method@ActionRow.activate], or via mnemonics in the title.
See the [property@PreferencesRow:use-underline] property to enable
mnemonics.

The target widget will be activated by emitting the
[signal@Gtk.Widget::mnemonic-activate] signal on it.

### `iconName(_:)`

The icon name for this row.

### `subtitle(_:)`

The subtitle for this row.

The subtitle is interpreted as Pango markup unless
[property@PreferencesRow:use-markup] is set to `FALSE`.

### `subtitleLines(_:)`

The number of lines at the end of which the subtitle label will be
ellipsized.

If the value is 0, the number of lines won't be limited.

### `subtitleSelectable(_:)`

Whether the user can copy the subtitle from the label.

See also [property@Gtk.Label:selectable].

### `titleLines(_:)`

The number of lines at the end of which the title label will be ellipsized.

If the value is 0, the number of lines won't be limited.

### `title(_:)`

The title of the preference represented by this row.

The title is interpreted as Pango markup unless
[property@PreferencesRow:use-markup] is set to `FALSE`.

### `titleSelectable(_:)`

Whether the user can copy the title from the label.

See also [property@Gtk.Label:selectable].

### `useMarkup(_:)`

Whether to use Pango markup for the title label.

Subclasses may also use it for other labels, such as subtitle.

See also [func@Pango.parse_markup].

### `useUnderline(_:)`

Whether an embedded underline in the title indicates a mnemonic.

### `activated(_:)`

This signal is emitted after the row has been activated.

### `suffix(_:)`

Set the body for "suffix".
- Parameter body: The body.
- Returns: The widget.

### `prefix(_:)`

Set the body for "prefix".
- Parameter body: The body.
- Returns: The widget.
