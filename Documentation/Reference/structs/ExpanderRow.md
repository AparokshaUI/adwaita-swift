**STRUCT**

# `ExpanderRow`

A [class@Gtk.ListBoxRow] used to reveal widgets.

<picture><source srcset="expander-row-dark.png" media="(prefers-color-scheme: dark)"><img src="expander-row.png" alt="expander-row"></picture>

The `AdwExpanderRow` widget allows the user to reveal or hide widgets below
it. It also allows the user to enable the expansion of the row, allowing to
disable all that the row contains.

## AdwExpanderRow as GtkBuildable

The `AdwExpanderRow` implementation of the [iface@Gtk.Buildable] interface
supports adding a child as an suffix widget by specifying “suffix” as the
“type” attribute of a <child> element.

It also supports adding it as a prefix widget by specifying “prefix” as the
“type” attribute of a <child> element.

## CSS nodes

`AdwExpanderRow` has a main CSS node with name `row` and the `.expander`
style class. It has the `.empty` style class when it contains no children.

It contains the subnodes `row.header` for its main embedded row,
`list.nested` for the list it can expand, and `image.expander-row-arrow` for
its arrow.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `enableExpansion`

Whether expansion is enabled.

### `expanded`

Whether the row is expanded.

### `iconName`

The icon name for this row.

### `showEnableSwitch`

Whether the switch enabling the expansion is visible.

### `subtitle`

The subtitle for this row.

The subtitle is interpreted as Pango markup unless
[property@PreferencesRow:use-markup] is set to `FALSE`.

### `subtitleLines`

The number of lines at the end of which the subtitle label will be
ellipsized.

If the value is 0, the number of lines won't be limited.

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

### `rows`

The body for the widget "rows".

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

Initialize `ExpanderRow`.

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

### `enableExpansion(_:)`

Whether expansion is enabled.

### `expanded(_:)`

Whether the row is expanded.

### `iconName(_:)`

The icon name for this row.

### `showEnableSwitch(_:)`

Whether the switch enabling the expansion is visible.

### `subtitle(_:)`

The subtitle for this row.

The subtitle is interpreted as Pango markup unless
[property@PreferencesRow:use-markup] is set to `FALSE`.

### `subtitleLines(_:)`

The number of lines at the end of which the subtitle label will be
ellipsized.

If the value is 0, the number of lines won't be limited.

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

### `rows(_:)`

Set the body for "rows".
- Parameter body: The body.
- Returns: The widget.

### `suffix(_:)`

Set the body for "suffix".
- Parameter body: The body.
- Returns: The widget.

### `prefix(_:)`

Set the body for "prefix".
- Parameter body: The body.
- Returns: The widget.
