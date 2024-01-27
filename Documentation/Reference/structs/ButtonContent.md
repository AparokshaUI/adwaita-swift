**STRUCT**

# `ButtonContent`

A helper widget for creating buttons.

<picture><source srcset="button-content-dark.png" media="(prefers-color-scheme: dark)"><img src="button-content.png" alt="button-content"></picture>

`AdwButtonContent` is a box-like widget with an icon and a label.

It's intended to be used as a direct child of [class@Gtk.Button],
[class@Gtk.MenuButton] or [class@SplitButton], when they need to have both an
icon and a label, as follows:

```xml
<object class="GtkButton"><property name="child"><object class="AdwButtonContent"><property name="icon-name">document-open-symbolic</property><property name="label" translatable="yes">_Open</property><property name="use-underline">True</property></object></property></object>
```

`AdwButtonContent` handles style classes and connecting the mnemonic to the
button automatically.

## CSS nodes

```
buttoncontent
├── image
╰── label
```

`AdwButtonContent`'s CSS node is called `buttoncontent`. It contains the
subnodes `image` and `label`.

When inside a `GtkButton` or `AdwSplitButton`, the button will receive the
`.image-text-button` style class. When inside a `GtkMenuButton`, the
internal `GtkButton` will receive it instead.

## Accessibility

`AdwButtonContent` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `canShrink`

Whether the button can be smaller than the natural size of its contents.

If set to `TRUE`, the label will ellipsize.

See [property@Gtk.Button:can-shrink].

### `iconName`

The name of the displayed icon.

If empty, the icon is not shown.

### `label`

The displayed label.

### `useUnderline`

Whether an underline in the text indicates a mnemonic.

The mnemonic can be used to activate the parent button.

See [property@ButtonContent:label].

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `ButtonContent`.

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

See [property@Gtk.Button:can-shrink].

### `iconName(_:)`

The name of the displayed icon.

If empty, the icon is not shown.

### `label(_:)`

The displayed label.

### `useUnderline(_:)`

Whether an underline in the text indicates a mnemonic.

The mnemonic can be used to activate the parent button.

See [property@ButtonContent:label].
