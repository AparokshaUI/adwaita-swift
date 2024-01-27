**STRUCT**

# `EntryRow`

A [class@Gtk.ListBoxRow] with an embedded text entry.

<picture><source srcset="entry-row-dark.png" media="(prefers-color-scheme: dark)"><img src="entry-row.png" alt="entry-row"></picture>

`AdwEntryRow` has a title that doubles as placeholder text. It shows an icon
indicating that it's editable and can receive additional widgets before or
after the editable part.

If [property@EntryRow:show-apply-button] is set to `TRUE`, `AdwEntryRow` can
show an apply button when editing its contents. This can be useful if
changing its contents can result in an expensive operation, such as network
activity.

`AdwEntryRow` provides only minimal API and should be used with the
[iface@Gtk.Editable] API.

See also [class@PasswordEntryRow].

## AdwEntryRow as GtkBuildable

The `AdwEntryRow` implementation of the [iface@Gtk.Buildable] interface
supports adding a child at its end by specifying “suffix” or omitting the
“type” attribute of a <child> element.

It also supports adding a child as a prefix widget by specifying “prefix” as
the “type” attribute of a <child> element.

## CSS nodes

`AdwEntryRow` has a single CSS node with name `row` and the `.entry` style
class.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `activatesDefault`

Whether activating the embedded entry can activate the default widget.

### `enableEmojiCompletion`

Whether to suggest emoji replacements on the entry row.

Emoji replacement is done with :-delimited names, like `:heart:`.

### `showApplyButton`

Whether to show the apply button.

When set to `TRUE`, typing text in the entry will reveal an apply button.
Clicking it or pressing the <kbd>Enter</kbd> key will hide the button and
emit the [signal@EntryRow::apply] signal.

This is useful if changing the entry contents can trigger an expensive
operation, e.g. network activity, to avoid triggering it after typing every
character.

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

### `apply`

Emitted when the apply button is pressed.

See [property@EntryRow:show-apply-button].

### `entryActivated`

Emitted when the embedded entry is activated.

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

Initialize `EntryRow`.

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

### `activatesDefault(_:)`

Whether activating the embedded entry can activate the default widget.

### `enableEmojiCompletion(_:)`

Whether to suggest emoji replacements on the entry row.

Emoji replacement is done with :-delimited names, like `:heart:`.

### `showApplyButton(_:)`

Whether to show the apply button.

When set to `TRUE`, typing text in the entry will reveal an apply button.
Clicking it or pressing the <kbd>Enter</kbd> key will hide the button and
emit the [signal@EntryRow::apply] signal.

This is useful if changing the entry contents can trigger an expensive
operation, e.g. network activity, to avoid triggering it after typing every
character.

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

### `apply(_:)`

Emitted when the apply button is pressed.

See [property@EntryRow:show-apply-button].

### `entryActivated(_:)`

Emitted when the embedded entry is activated.

### `suffix(_:)`

Set the body for "suffix".
- Parameter body: The body.
- Returns: The widget.

### `prefix(_:)`

Set the body for "prefix".
- Parameter body: The body.
- Returns: The widget.
