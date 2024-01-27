**STRUCT**

# `Menu`

The `GtkMenuButton` widget is used to display a popup when clicked.

![An example GtkMenuButton](menu-button.png)

This popup can be provided either as a `GtkPopover` or as an abstract
`GMenuModel`.

The `GtkMenuButton` widget can show either an icon (set with the
[property@Gtk.MenuButton:icon-name] property) or a label (set with the
[property@Gtk.MenuButton:label] property). If neither is explicitly set,
a [class@Gtk.Image] is automatically created, using an arrow image oriented
according to [property@Gtk.MenuButton:direction] or the generic
“open-menu-symbolic” icon if the direction is not set.

The positioning of the popup is determined by the
[property@Gtk.MenuButton:direction] property of the menu button.

For menus, the [property@Gtk.Widget:halign] and [property@Gtk.Widget:valign]
properties of the menu are also taken into account. For example, when the
direction is %GTK_ARROW_DOWN and the horizontal alignment is %GTK_ALIGN_START,
the menu will be positioned below the button, with the starting edge
(depending on the text direction) of the menu aligned with the starting
edge of the button. If there is not enough space below the button, the
menu is popped up above the button instead. If the alignment would move
part of the menu offscreen, it is “pushed in”.

|           | start                | center                | end                |
| -         | ---                  | ---                   | ---                |
| **down**  | ![](down-start.png)  | ![](down-center.png)  | ![](down-end.png)  |
| **up**    | ![](up-start.png)    | ![](up-center.png)    | ![](up-end.png)    |
| **left**  | ![](left-start.png)  | ![](left-center.png)  | ![](left-end.png)  |
| **right** | ![](right-start.png) | ![](right-center.png) | ![](right-end.png) |

# CSS nodes

```
menubutton
╰── button.toggle
╰── <content>╰── [arrow]
```

`GtkMenuButton` has a single CSS node with name `menubutton`
which contains a `button` node with a `.toggle` style class.

If the button contains an icon, it will have the `.image-button` style class,
if it contains text, it will have `.text-button` style class. If an arrow is
visible in addition to an icon, text or a custom child, it will also have
`.arrow-button` style class.

Inside the toggle button content, there is an `arrow` node for
the indicator, which will carry one of the `.none`, `.up`, `.down`,
`.left` or `.right` style classes to indicate the direction that
the menu will appear in. The CSS is expected to provide a suitable
image for each of these cases using the `-gtk-icon-source` property.

Optionally, the `menubutton` node can carry the `.circular` style class
to request a round appearance.

# Accessibility

`GtkMenuButton` uses the %GTK_ACCESSIBLE_ROLE_BUTTON role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `active`

Whether the menu button is active.

### `alwaysShowArrow`

Whether to show a dropdown arrow even when using an icon or a custom child.

### `canShrink`

Whether the size of the button can be made smaller than the natural
size of its contents.

### `child`

The child widget.

### `hasFrame`

Whether the button has a frame.

### `iconName`

The name of the icon used to automatically populate the button.

### `label`

The label for the button.

### `menuModel`

The `GMenuModel` from which the popup will be created.

See [method@Gtk.MenuButton.set_menu_model] for the interaction
with the [property@Gtk.MenuButton:popover] property.

### `primary`

Whether the menu button acts as a primary menu.

Primary menus can be opened using the <kbd>F10</kbd> key

### `useUnderline`

If set an underscore in the text indicates a mnemonic.

### `activate`

Emitted to when the menu button is activated.

The `::activate` signal on `GtkMenuButton` is an action signal and
emitting it causes the button to pop up its menu.

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `Menu`.

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

Whether the menu button is active.

### `alwaysShowArrow(_:)`

Whether to show a dropdown arrow even when using an icon or a custom child.

### `canShrink(_:)`

Whether the size of the button can be made smaller than the natural
size of its contents.

### `child(_:)`

The child widget.

### `hasFrame(_:)`

Whether the button has a frame.

### `iconName(_:)`

The name of the icon used to automatically populate the button.

### `label(_:)`

The label for the button.

### `menuModel(app:window:_:)`

The `GMenuModel` from which the popup will be created.

See [method@Gtk.MenuButton.set_menu_model] for the interaction
with the [property@Gtk.MenuButton:popover] property.

### `primary(_:)`

Whether the menu button acts as a primary menu.

Primary menus can be opened using the <kbd>F10</kbd> key

### `useUnderline(_:)`

If set an underscore in the text indicates a mnemonic.

### `activate(_:)`

Emitted to when the menu button is activated.

The `::activate` signal on `GtkMenuButton` is an action signal and
emitting it causes the button to pop up its menu.
