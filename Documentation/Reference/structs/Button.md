**STRUCT**

# `Button`

The `GtkButton` widget is generally used to trigger a callback function that is
called when the button is pressed.

![An example GtkButton](button.png)

The `GtkButton` widget can hold any valid child widget. That is, it can hold
almost any other standard `GtkWidget`. The most commonly used child is the
`GtkLabel`.

# CSS nodes

`GtkButton` has a single CSS node with name button. The node will get the
style classes .image-button or .text-button, if the content is just an
image or label, respectively. It may also receive the .flat style class.
When activating a button via the keyboard, the button will temporarily
gain the .keyboard-activating style class.

Other style classes that are commonly used with `GtkButton` include
.suggested-action and .destructive-action. In special cases, buttons
can be made round by adding the .circular style class.

Button-like widgets like [class@Gtk.ToggleButton], [class@Gtk.MenuButton],
[class@Gtk.VolumeButton], [class@Gtk.LockButton], [class@Gtk.ColorButton]
or [class@Gtk.FontButton] use style classes such as .toggle, .popup, .scale,
.lock, .color on the button node to differentiate themselves from a plain
`GtkButton`.

# Accessibility

`GtkButton` uses the %GTK_ACCESSIBLE_ROLE_BUTTON role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

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
### `init()`

Initialize `Button`.

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
