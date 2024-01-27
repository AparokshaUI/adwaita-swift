**STRUCT**

# `Banner`

A bar with contextual information.

<picture><source srcset="banner-dark.png" media="(prefers-color-scheme: dark)"><img src="banner.png" alt="banner"></picture>

Banners are hidden by default, use [property@Banner:revealed] to show them.

Banners have a title, set with [property@Banner:title]. Titles can be marked
up with Pango markup, use [property@Banner:use-markup] to enable it.

The title will be shown centered or left-aligned depending on available
space.

Banners can optionally have a button with text on it, set through
[property@Banner:button-label]. The button can be used with a `GAction`,
or with the [signal@Banner::button-clicked] signal.

## CSS nodes

`AdwBanner` has a main CSS node with the name `banner`.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `buttonLabel`

The label to show on the button.

If set to `""` or `NULL`, the button won't be shown.

The button can be used with a `GAction`, or with the
[signal@Banner::button-clicked] signal.

### `revealed`

Whether the banner is currently revealed.

### `title`

The title for this banner.

See also: [property@Banner:use-markup].

### `useMarkup`

Whether to use Pango markup for the banner title.

See also [func@Pango.parse_markup].

### `buttonClicked`

This signal is emitted after the action button has been clicked.

It can be used as an alternative to setting an action.

### `app`

The application.

### `window`

The window.

## Methods
### `init(title:)`

Initialize `Banner`.

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

### `buttonLabel(_:)`

The label to show on the button.

If set to `""` or `NULL`, the button won't be shown.

The button can be used with a `GAction`, or with the
[signal@Banner::button-clicked] signal.

### `revealed(_:)`

Whether the banner is currently revealed.

### `title(_:)`

The title for this banner.

See also: [property@Banner:use-markup].

### `useMarkup(_:)`

Whether to use Pango markup for the banner title.

See also [func@Pango.parse_markup].

### `buttonClicked(_:)`

This signal is emitted after the action button has been clicked.

It can be used as an alternative to setting an action.
