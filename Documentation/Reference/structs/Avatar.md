**STRUCT**

# `Avatar`

A widget displaying an image, with a generated fallback.

<picture><source srcset="avatar-dark.png" media="(prefers-color-scheme: dark)"><img src="avatar.png" alt="avatar"></picture>

`AdwAvatar` is a widget that shows a round avatar.

`AdwAvatar` generates an avatar with the initials of  the
[property@Avatar:text] on top of a colored background.

The color is picked based on the hash of the [property@Avatar:text].

If [property@Avatar:show-initials] is set to `FALSE`,
[property@Avatar:icon-name] or `avatar-default-symbolic` is shown instead of
the initials.

Use [property@Avatar:custom-image] to set a custom image.

## CSS nodes

`AdwAvatar` has a single CSS node with name `avatar`.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `iconName`

The name of an icon to use as a fallback.

If no name is set, `avatar-default-symbolic` will be used.

### `showInitials`

Whether initials are used instead of an icon on the fallback avatar.

See [property@Avatar:icon-name] for how to change the fallback icon.

### `size`

The size of the avatar.

### `text`

Sets the text used to generate the fallback initials and color.

It's only used to generate the color if [property@Avatar:show-initials] is
`FALSE`.

### `app`

The application.

### `window`

The window.

## Methods
### `init(showInitials:size:)`

Initialize `Avatar`.

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

### `iconName(_:)`

The name of an icon to use as a fallback.

If no name is set, `avatar-default-symbolic` will be used.

### `showInitials(_:)`

Whether initials are used instead of an icon on the fallback avatar.

See [property@Avatar:icon-name] for how to change the fallback icon.

### `size(_:)`

The size of the avatar.

### `text(_:)`

Sets the text used to generate the fallback initials and color.

It's only used to generate the color if [property@Avatar:show-initials] is
`FALSE`.
