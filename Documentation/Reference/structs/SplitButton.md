**STRUCT**

# `SplitButton`

A combined button and dropdown widget.

<picture><source srcset="split-button-dark.png" media="(prefers-color-scheme: dark)"><img src="split-button.png" alt="split-button"></picture>

`AdwSplitButton` is typically used to present a set of actions in a menu,
but allow access to one of them with a single click.

The API is very similar to [class@Gtk.Button] and [class@Gtk.MenuButton], see
their documentation for details.

## CSS nodes

```
splitbutton[.image-button][.text-button]
├── button
│   ╰── <content>├── separator
╰── menubutton
╰── button.toggle
╰── arrow
```

`AdwSplitButton`'s CSS node is called `splitbutton`. It contains the css
nodes: `button`, `separator`, `menubutton`. See [class@Gtk.MenuButton]
documentation for the `menubutton` contents.

The main CSS node will contain the `.image-button` or `.text-button` style
classes matching the button contents. The nested button nodes will never
contain them.

## Accessibility

`AdwSplitButton` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `canShrink`

Whether the button can be smaller than the natural size of its contents.

If set to `TRUE`, the label will ellipsize.

See [property@Gtk.Button:can-shrink] and
[property@Gtk.MenuButton:can-shrink].

### `child`

The child widget.

Setting the child widget will set [property@SplitButton:label] and
[property@SplitButton:icon-name] to `NULL`.

### `dropdownTooltip`

The tooltip of the dropdown button.

The tooltip can be marked up with the Pango text markup language.

### `iconName`

The name of the icon used to automatically populate the button.

Setting the icon name will set [property@SplitButton:label] and
[property@SplitButton:child] to `NULL`.

### `label`

The label for the button.

Setting the label will set [property@SplitButton:icon-name] and
[property@SplitButton:child] to `NULL`.

### `menuModel`

The `GMenuModel` from which the popup will be created.

If the menu model is `NULL`, the dropdown is disabled.

A [class@Gtk.Popover] will be created from the menu model with
[ctor@Gtk.PopoverMenu.new_from_model]. Actions will be connected as
documented for this function.

If [property@SplitButton:popover] is already set, it will be dissociated
from the button, and the property is set to `NULL`.

### `useUnderline`

Whether an underline in the text indicates a mnemonic.

See [property@SplitButton:label].

### `activate`

Emitted to animate press then release.

This is an action signal. Applications should never connect to this signal,
but use the [signal@SplitButton::clicked] signal.

### `clicked`

Emitted when the button has been activated (pressed and released).

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `SplitButton`.

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

Whether the button can be smaller than the natural size of its contents.

If set to `TRUE`, the label will ellipsize.

See [property@Gtk.Button:can-shrink] and
[property@Gtk.MenuButton:can-shrink].

### `child(_:)`

The child widget.

Setting the child widget will set [property@SplitButton:label] and
[property@SplitButton:icon-name] to `NULL`.

### `dropdownTooltip(_:)`

The tooltip of the dropdown button.

The tooltip can be marked up with the Pango text markup language.

### `iconName(_:)`

The name of the icon used to automatically populate the button.

Setting the icon name will set [property@SplitButton:label] and
[property@SplitButton:child] to `NULL`.

### `label(_:)`

The label for the button.

Setting the label will set [property@SplitButton:icon-name] and
[property@SplitButton:child] to `NULL`.

### `menuModel(app:window:_:)`

The `GMenuModel` from which the popup will be created.

If the menu model is `NULL`, the dropdown is disabled.

A [class@Gtk.Popover] will be created from the menu model with
[ctor@Gtk.PopoverMenu.new_from_model]. Actions will be connected as
documented for this function.

If [property@SplitButton:popover] is already set, it will be dissociated
from the button, and the property is set to `NULL`.

### `useUnderline(_:)`

Whether an underline in the text indicates a mnemonic.

See [property@SplitButton:label].

### `activate(_:)`

Emitted to animate press then release.

This is an action signal. Applications should never connect to this signal,
but use the [signal@SplitButton::clicked] signal.

### `clicked(_:)`

Emitted when the button has been activated (pressed and released).
