**STRUCT**

# `LinkButton`

A `GtkLinkButton` is a button with a hyperlink.

![An example GtkLinkButton](link-button.png)

It is useful to show quick links to resources.

A link button is created by calling either [ctor@Gtk.LinkButton.new] or
[ctor@Gtk.LinkButton.new_with_label]. If using the former, the URI you
pass to the constructor is used as a label for the widget.

The URI bound to a `GtkLinkButton` can be set specifically using
[method@Gtk.LinkButton.set_uri].

By default, `GtkLinkButton` calls [method@Gtk.FileLauncher.launch] when the button
is clicked. This behaviour can be overridden by connecting to the
[signal@Gtk.LinkButton::activate-link] signal and returning %TRUE from
the signal handler.

# CSS nodes

`GtkLinkButton` has a single CSS node with name button. To differentiate
it from a plain `GtkButton`, it gets the .link style class.

# Accessibility

`GtkLinkButton` uses the %GTK_ACCESSIBLE_ROLE_LINK role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `uri`

The URI bound to this button.

### `visited`

The 'visited' state of this button.

A visited link is drawn in a different color.

### `canShrink`

Whether the size of the button can be made smaller than the natural
size of its contents.

For text buttons, setting this property will allow ellipsizing the label.

If the contents of a button are an icon or a custom widget, setting this
property has no effect.

### `child`

The child widget.

### `hasFrame`

Whether the button has a frame.

### `iconName`

The name of the icon used to automatically populate the button.

### `label`

Text of the label inside the button, if the button contains a label widget.

### `useUnderline`

If set, an underline in the text indicates that the following character is
to be used as mnemonic.

### `activate`

Emitted to animate press then release.

This is an action signal. Applications should never connect
to this signal, but use the [signal@Gtk.Button::clicked] signal.

The default bindings for this signal are all forms of the
<kbd>␣</kbd> and <kbd>Enter</kbd> keys.

### `clicked`

Emitted when the button has been activated (pressed and released).

### `app`

The application.

### `window`

The window.

## Methods
### `init(uri:)`

Initialize `LinkButton`.

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

### `uri(_:)`

The URI bound to this button.

### `visited(_:)`

The 'visited' state of this button.

A visited link is drawn in a different color.

### `canShrink(_:)`

Whether the size of the button can be made smaller than the natural
size of its contents.

For text buttons, setting this property will allow ellipsizing the label.

If the contents of a button are an icon or a custom widget, setting this
property has no effect.

### `child(_:)`

The child widget.

### `hasFrame(_:)`

Whether the button has a frame.

### `iconName(_:)`

The name of the icon used to automatically populate the button.

### `label(_:)`

Text of the label inside the button, if the button contains a label widget.

### `useUnderline(_:)`

If set, an underline in the text indicates that the following character is
to be used as mnemonic.

### `activate(_:)`

Emitted to animate press then release.

This is an action signal. Applications should never connect
to this signal, but use the [signal@Gtk.Button::clicked] signal.

The default bindings for this signal are all forms of the
<kbd>␣</kbd> and <kbd>Enter</kbd> keys.

### `clicked(_:)`

Emitted when the button has been activated (pressed and released).
