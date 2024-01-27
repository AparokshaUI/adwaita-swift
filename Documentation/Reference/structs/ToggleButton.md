**STRUCT**

# `ToggleButton`

A `GtkToggleButton` is a button which remains “pressed-in” when
clicked.

Clicking again will cause the toggle button to return to its normal state.

A toggle button is created by calling either [ctor@Gtk.ToggleButton.new] or
[ctor@Gtk.ToggleButton.new_with_label]. If using the former, it is advisable
to pack a widget, (such as a `GtkLabel` and/or a `GtkImage`), into the toggle
button’s container. (See [class@Gtk.Button] for more information).

The state of a `GtkToggleButton` can be set specifically using
[method@Gtk.ToggleButton.set_active], and retrieved using
[method@Gtk.ToggleButton.get_active].

To simply switch the state of a toggle button, use
[method@Gtk.ToggleButton.toggled].

## Grouping

Toggle buttons can be grouped together, to form mutually exclusive
groups - only one of the buttons can be toggled at a time, and toggling
another one will switch the currently toggled one off.

To add a `GtkToggleButton` to a group, use [method@Gtk.ToggleButton.set_group].

## CSS nodes

`GtkToggleButton` has a single CSS node with name button. To differentiate
it from a plain `GtkButton`, it gets the `.toggle` style class.

## Accessibility

`GtkToggleButton` uses the %GTK_ACCESSIBLE_ROLE_TOGGLE_BUTTON role.

## Creating two `GtkToggleButton` widgets.

```c
static void
output_state (GtkToggleButton *source,
gpointer         user_data)
{
g_print ("Toggle button "%s" is active: %s",
gtk_button_get_label (GTK_BUTTON (source)),
gtk_toggle_button_get_active (source) ? "Yes" : "No");
}

static void
make_toggles (void)
{
GtkWidget *window, *toggle1, *toggle2;
GtkWidget *box;
const char *text;

window = gtk_window_new ();
box = gtk_box_new (GTK_ORIENTATION_VERTICAL, 12);

text = "Hi, I’m toggle button one";
toggle1 = gtk_toggle_button_new_with_label (text);

g_signal_connect (toggle1, "toggled",
G_CALLBACK (output_state),
NULL);
gtk_box_append (GTK_BOX (box), toggle1);

text = "Hi, I’m toggle button two";
toggle2 = gtk_toggle_button_new_with_label (text);
g_signal_connect (toggle2, "toggled",
G_CALLBACK (output_state),
NULL);
gtk_box_append (GTK_BOX (box), toggle2);

gtk_window_set_child (GTK_WINDOW (window), box);
gtk_window_present (GTK_WINDOW (window));
}
```

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `active`

If the toggle button should be pressed in.

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

### `toggled`

Emitted whenever the `GtkToggleButton`'s state is changed.

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

Initialize `ToggleButton`.

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

If the toggle button should be pressed in.

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

### `toggled(_:)`

Emitted whenever the `GtkToggleButton`'s state is changed.

### `activate(_:)`

Emitted to animate press then release.

This is an action signal. Applications should never connect
to this signal, but use the [signal@Gtk.Button::clicked] signal.

The default bindings for this signal are all forms of the
<kbd>␣</kbd> and <kbd>Enter</kbd> keys.

### `clicked(_:)`

Emitted when the button has been activated (pressed and released).
