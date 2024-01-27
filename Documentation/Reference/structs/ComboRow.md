**STRUCT**

# `ComboRow`

A [class@Gtk.ListBoxRow] used to choose from a list of items.

<picture><source srcset="combo-row-dark.png" media="(prefers-color-scheme: dark)"><img src="combo-row.png" alt="combo-row"></picture>

The `AdwComboRow` widget allows the user to choose from a list of valid
choices. The row displays the selected choice. When activated, the row
displays a popover which allows the user to make a new choice.

Example of an `AdwComboRow` UI definition:
```xml
<object class="AdwComboRow"><property name="title" translatable="yes">Combo Row</property><property name="model"><object class="GtkStringList"><items><item translatable="yes">Foo</item><item translatable="yes">Bar</item><item translatable="yes">Baz</item></items></object></property></object>
```

The [property@ComboRow:selected] and [property@ComboRow:selected-item]
properties can be used to keep track of the selected item and react to their
changes.

`AdwComboRow` mirrors [class@Gtk.DropDown], see that widget for details.

`AdwComboRow` is [property@Gtk.ListBoxRow:activatable] if a model is set.

## CSS nodes

`AdwComboRow` has a main CSS node with name `row` and the `.combo` style
class.

Its popover has the node named `popover` with the `.menu` style class, it
contains a [class@Gtk.ScrolledWindow], which in turn contains a
[class@Gtk.ListView], both are accessible via their regular nodes.

## Accessibility

`AdwComboRow` uses the `GTK_ACCESSIBLE_ROLE_COMBO_BOX` role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `enableSearch`

Whether to show a search entry in the popup.

If set to `TRUE`, a search entry will be shown in the popup that
allows to search for items in the list.

Search requires [property@ComboRow:expression] to be set.

### `selected`

The position of the selected item.

If no item is selected, the property has the value
[const@Gtk.INVALID_LIST_POSITION]

### `useSubtitle`

Whether to use the current value as the subtitle.

If you use a custom list item factory, you will need to give the row a
name conversion expression with [property@ComboRow:expression].

If set to `TRUE`, you should not access [property@ActionRow:subtitle].

The subtitle is interpreted as Pango markup if
[property@PreferencesRow:use-markup] is set to `TRUE`.

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

Initialize `ComboRow`.

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

### `enableSearch(_:)`

Whether to show a search entry in the popup.

If set to `TRUE`, a search entry will be shown in the popup that
allows to search for items in the list.

Search requires [property@ComboRow:expression] to be set.

### `selected(_:)`

The position of the selected item.

If no item is selected, the property has the value
[const@Gtk.INVALID_LIST_POSITION]

### `useSubtitle(_:)`

Whether to use the current value as the subtitle.

If you use a custom list item factory, you will need to give the row a
name conversion expression with [property@ComboRow:expression].

If set to `TRUE`, you should not access [property@ActionRow:subtitle].

The subtitle is interpreted as Pango markup if
[property@PreferencesRow:use-markup] is set to `TRUE`.

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
