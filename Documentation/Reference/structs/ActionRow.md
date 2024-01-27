**STRUCT**

# `ActionRow`

A [class@Gtk.ListBoxRow] used to present actions.

<picture><source srcset="action-row-dark.png" media="(prefers-color-scheme: dark)"><img src="action-row.png" alt="action-row"></picture>

The `AdwActionRow` widget can have a title, a subtitle and an icon. The row
can receive additional widgets at its end, or prefix widgets at its start.

It is convenient to present a preference and its related actions.

`AdwActionRow` is unactivatable by default, giving it an activatable widget
will automatically make it activatable, but unsetting it won't change the
row's activatability.

## AdwActionRow as GtkBuildable

The `AdwActionRow` implementation of the [iface@Gtk.Buildable] interface
supports adding a child at its end by specifying “suffix” or omitting the
“type” attribute of a <child> element.

It also supports adding a child as a prefix widget by specifying “prefix” as
the “type” attribute of a <child> element.

## CSS nodes

`AdwActionRow` has a main CSS node with name `row`.

It contains the subnode `box.header` for its main horizontal box, and
`box.title` for the vertical box containing the title and subtitle labels.

It contains subnodes `label.title` and `label.subtitle` representing
respectively the title label and subtitle label.

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

Initialize `ActionRow`.

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
