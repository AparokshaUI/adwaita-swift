**STRUCT**

# `PasswordEntryRow`

A [class@EntryRow] tailored for entering secrets.

<picture><source srcset="password-entry-row-dark.png" media="(prefers-color-scheme: dark)"><img src="password-entry-row.png" alt="password-entry-row"></picture>

It does not show its contents in clear text, does not allow to copy it to the
clipboard, and shows a warning when Caps Lock is engaged. If the underlying
platform allows it, `AdwPasswordEntryRow` will also place the text in a
non-pageable memory area, to avoid it being written out to disk by the
operating system.

It offer a way to reveal the contents in clear text.

## CSS Nodes

`AdwPasswordEntryRow` has a single CSS node with name `row` that carries
`.entry` and `.password` style classes.

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

Initialize `PasswordEntryRow`.

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
