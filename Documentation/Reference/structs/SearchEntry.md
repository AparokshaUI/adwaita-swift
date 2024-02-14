**STRUCT**

# `SearchEntry`

`GtkSearchEntry` is an entry widget that has been tailored for use
as a search entry.

The main API for interacting with a `GtkSearchEntry` as entry
is the `GtkEditable` interface.

![An example GtkSearchEntry](search-entry.png)

It will show an inactive symbolic “find” icon when the search
entry is empty, and a symbolic “clear” icon when there is text.
Clicking on the “clear” icon will empty the search entry.

To make filtering appear more reactive, it is a good idea to
not react to every change in the entry text immediately, but
only after a short delay. To support this, `GtkSearchEntry`
emits the [signal@Gtk.SearchEntry::search-changed] signal which
can be used instead of the [signal@Gtk.Editable::changed] signal.

The [signal@Gtk.SearchEntry::previous-match],
[signal@Gtk.SearchEntry::next-match] and
[signal@Gtk.SearchEntry::stop-search] signals can be used to
implement moving between search results and ending the search.

Often, `GtkSearchEntry` will be fed events by means of being
placed inside a [class@Gtk.SearchBar]. If that is not the case,
you can use [method@Gtk.SearchEntry.set_key_capture_widget] to
let it capture key input from another widget.

`GtkSearchEntry` provides only minimal API and should be used with
the [iface@Gtk.Editable] API.

## CSS Nodes

```
entry.search
╰── text
```

`GtkSearchEntry` has a single CSS node with name entry that carries
a `.search` style class, and the text node is a child of that.

## Accessibility

`GtkSearchEntry` uses the %GTK_ACCESSIBLE_ROLE_SEARCH_BOX role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `accessibleRole`

The accessible role of the given `GtkAccessible` implementation.

The accessible role cannot be changed once set.

### `activatesDefault`

Whether to activate the default widget when Enter is pressed.

### `cursorPosition`

The current position of the insertion cursor in chars.

### `editable`

Whether the entry contents can be edited.

### `enableUndo`

If undo/redo should be enabled for the editable.

### `maxWidthChars`

The desired maximum width of the entry, in characters.

### `placeholderText`

The text that will be displayed in the `GtkSearchEntry`
when it is empty and unfocused.

### `searchDelay`

The delay in milliseconds from last keypress to the search
changed signal.

### `selectionBound`

The position of the opposite end of the selection from the cursor in chars.

### `text`

The contents of the entry.

### `widthChars`

Number of characters to leave space for in the entry.

### `xalign`

The horizontal alignment, from 0 (left) to 1 (right).

Reversed for RTL layouts.

### `activate`

Emitted when the entry is activated.

The keybindings for this signal are all forms of the Enter key.

### `changed`

Emitted at the end of a single user-visible operation on the
contents.

E.g., a paste operation that replaces the contents of the
selection will cause only one signal emission (even though it
is implemented by first deleting the selection, then inserting
the new content, and may cause multiple ::notify::text signals
to be emitted).

### `deleteText`

Emitted when text is deleted from the widget by the user.

The default handler for this signal will normally be responsible for
deleting the text, so by connecting to this signal and then stopping
the signal with g_signal_stop_emission(), it is possible to modify the
range of deleted text, or prevent it from being deleted entirely.

The @start_pos and @end_pos parameters are interpreted as for
[method@Gtk.Editable.delete_text].

### `insertText`

Emitted when text is inserted into the widget by the user.

The default handler for this signal will normally be responsible
for inserting the text, so by connecting to this signal and then
stopping the signal with g_signal_stop_emission(), it is possible
to modify the inserted text, or prevent it from being inserted entirely.

### `nextMatch`

Emitted when the user initiates a move to the next match
for the current search string.

This is a [keybinding signal](class.SignalAction.html).

Applications should connect to it, to implement moving
between matches.

The default bindings for this signal is Ctrl-g.

### `previousMatch`

Emitted when the user initiates a move to the previous match
for the current search string.

This is a [keybinding signal](class.SignalAction.html).

Applications should connect to it, to implement moving
between matches.

The default bindings for this signal is Ctrl-Shift-g.

### `searchChanged`

Emitted with a delay. The length of the delay can be
changed with the [property@Gtk.SearchEntry:search-delay]
property.

### `searchStarted`

Emitted when the user initiated a search on the entry.

### `stopSearch`

Emitted when the user stops a search via keyboard input.

This is a [keybinding signal](class.SignalAction.html).

Applications should connect to it, to implement hiding
the search entry in this case.

The default bindings for this signal is Escape.

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `SearchEntry`.

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

### `activatesDefault(_:)`

Whether to activate the default widget when Enter is pressed.

### `cursorPosition(_:)`

The current position of the insertion cursor in chars.

### `editable(_:)`

Whether the entry contents can be edited.

### `enableUndo(_:)`

If undo/redo should be enabled for the editable.

### `maxWidthChars(_:)`

The desired maximum width of the entry, in characters.

### `placeholderText(_:)`

The text that will be displayed in the `GtkSearchEntry`
when it is empty and unfocused.

### `searchDelay(_:)`

The delay in milliseconds from last keypress to the search
changed signal.

### `selectionBound(_:)`

The position of the opposite end of the selection from the cursor in chars.

### `text(_:)`

The contents of the entry.

### `widthChars(_:)`

Number of characters to leave space for in the entry.

### `xalign(_:)`

The horizontal alignment, from 0 (left) to 1 (right).

Reversed for RTL layouts.

### `activate(_:)`

Emitted when the entry is activated.

The keybindings for this signal are all forms of the Enter key.

### `changed(_:)`

Emitted at the end of a single user-visible operation on the
contents.

E.g., a paste operation that replaces the contents of the
selection will cause only one signal emission (even though it
is implemented by first deleting the selection, then inserting
the new content, and may cause multiple ::notify::text signals
to be emitted).

### `deleteText(_:)`

Emitted when text is deleted from the widget by the user.

The default handler for this signal will normally be responsible for
deleting the text, so by connecting to this signal and then stopping
the signal with g_signal_stop_emission(), it is possible to modify the
range of deleted text, or prevent it from being deleted entirely.

The @start_pos and @end_pos parameters are interpreted as for
[method@Gtk.Editable.delete_text].

### `insertText(_:)`

Emitted when text is inserted into the widget by the user.

The default handler for this signal will normally be responsible
for inserting the text, so by connecting to this signal and then
stopping the signal with g_signal_stop_emission(), it is possible
to modify the inserted text, or prevent it from being inserted entirely.

### `nextMatch(_:)`

Emitted when the user initiates a move to the next match
for the current search string.

This is a [keybinding signal](class.SignalAction.html).

Applications should connect to it, to implement moving
between matches.

The default bindings for this signal is Ctrl-g.

### `previousMatch(_:)`

Emitted when the user initiates a move to the previous match
for the current search string.

This is a [keybinding signal](class.SignalAction.html).

Applications should connect to it, to implement moving
between matches.

The default bindings for this signal is Ctrl-Shift-g.

### `searchChanged(_:)`

Emitted with a delay. The length of the delay can be
changed with the [property@Gtk.SearchEntry:search-delay]
property.

### `searchStarted(_:)`

Emitted when the user initiated a search on the entry.

### `stopSearch(_:)`

Emitted when the user stops a search via keyboard input.

This is a [keybinding signal](class.SignalAction.html).

Applications should connect to it, to implement hiding
the search entry in this case.

The default bindings for this signal is Escape.
