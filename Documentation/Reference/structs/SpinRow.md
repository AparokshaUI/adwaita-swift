**STRUCT**

# `SpinRow`

An [class@ActionRow] with an embedded spin button.

<picture><source srcset="spin-row-dark.png" media="(prefers-color-scheme: dark)"><img src="spin-row.png" alt="spin-row"></picture>

Example of an `AdwSpinRow` UI definition:

```xml
<object class="AdwSpinRow"><property name="title" translatable="yes">Spin Row</property><property name="adjustment"><object class="GtkAdjustment"><property name="lower">0</property><property name="upper">100</property><property name="value">50</property><property name="page-increment">10</property><property name="step-increment">1</property></object></property></object>
```

See [class@Gtk.SpinButton] for details.

## CSS nodes

`AdwSpinRow` has the same structure as [class@ActionRow], as well as the
`.spin` style class on the main node.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `activatableWidget`

The widget to activate when the row is activated.

The row can be activated either by clicking on it, calling
[method@ActionRow.activate], or via mnemonics in the title.
See the [property@PreferencesRow:use-underline] property to enable
mnemonics.

The target widget will be activated by emitting the
[signal@Gtk.Widget::mnemonic-activate] signal on it.

### `climbRate`

The acceleration rate when you hold down a button or key.

### `digits`

The number of decimal places to display.

### `iconName`

The icon name for this row.

### `numeric`

Whether non-numeric characters should be ignored.

### `snapToTicks`

Whether invalid values are snapped to the nearest step increment.

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

### `title`

The title of the preference represented by this row.

The title is interpreted as Pango markup unless
[property@PreferencesRow:use-markup] is set to `FALSE`.

### `titleLines`

The number of lines at the end of which the title label will be ellipsized.

If the value is 0, the number of lines won't be limited.

### `titleSelectable`

Whether the user can copy the title from the label.

See also [property@Gtk.Label:selectable].

### `useMarkup`

Whether to use Pango markup for the title label.

Subclasses may also use it for other labels, such as subtitle.

See also [func@Pango.parse_markup].

### `useUnderline`

Whether an embedded underline in the title indicates a mnemonic.

### `value`

The current value.

### `wrap`

Whether the spin row should wrap upon reaching its limits.

### `activated`

This signal is emitted after the row has been activated.

### `input`

Emitted to convert the user's input into a double value.

The signal handler is expected to use [method@Gtk.Editable.get_text] to
retrieve the text of the spinbutton and set new_value to the new value.

The default conversion uses [func@GLib.strtod].

See [signal@Gtk.SpinButton::input].

### `output`

Emitted to tweak the formatting of the value for display.

See [signal@Gtk.SpinButton::output].

### `wrapped`

Emitted right after the spinbutton wraps.

See [signal@Gtk.SpinButton::wrapped].

### `suffix`

The body for the widget "suffix".

### `prefix`

The body for the widget "prefix".

### `app`

The application.

### `window`

The window.

## Methods
### `init(climbRate:digits:)`

Initialize `SpinRow`.

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

### `activatableWidget(_:)`

The widget to activate when the row is activated.

The row can be activated either by clicking on it, calling
[method@ActionRow.activate], or via mnemonics in the title.
See the [property@PreferencesRow:use-underline] property to enable
mnemonics.

The target widget will be activated by emitting the
[signal@Gtk.Widget::mnemonic-activate] signal on it.

### `climbRate(_:)`

The acceleration rate when you hold down a button or key.

### `digits(_:)`

The number of decimal places to display.

### `iconName(_:)`

The icon name for this row.

### `numeric(_:)`

Whether non-numeric characters should be ignored.

### `snapToTicks(_:)`

Whether invalid values are snapped to the nearest step increment.

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

### `title(_:)`

The title of the preference represented by this row.

The title is interpreted as Pango markup unless
[property@PreferencesRow:use-markup] is set to `FALSE`.

### `titleLines(_:)`

The number of lines at the end of which the title label will be ellipsized.

If the value is 0, the number of lines won't be limited.

### `titleSelectable(_:)`

Whether the user can copy the title from the label.

See also [property@Gtk.Label:selectable].

### `useMarkup(_:)`

Whether to use Pango markup for the title label.

Subclasses may also use it for other labels, such as subtitle.

See also [func@Pango.parse_markup].

### `useUnderline(_:)`

Whether an embedded underline in the title indicates a mnemonic.

### `value(_:)`

The current value.

### `wrap(_:)`

Whether the spin row should wrap upon reaching its limits.

### `activated(_:)`

This signal is emitted after the row has been activated.

### `input(_:)`

Emitted to convert the user's input into a double value.

The signal handler is expected to use [method@Gtk.Editable.get_text] to
retrieve the text of the spinbutton and set new_value to the new value.

The default conversion uses [func@GLib.strtod].

See [signal@Gtk.SpinButton::input].

### `output(_:)`

Emitted to tweak the formatting of the value for display.

See [signal@Gtk.SpinButton::output].

### `wrapped(_:)`

Emitted right after the spinbutton wraps.

See [signal@Gtk.SpinButton::wrapped].

### `suffix(_:)`

Set the body for "suffix".
- Parameter body: The body.
- Returns: The widget.

### `prefix(_:)`

Set the body for "prefix".
- Parameter body: The body.
- Returns: The widget.
