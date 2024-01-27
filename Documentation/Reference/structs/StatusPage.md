**STRUCT**

# `StatusPage`

A page used for empty/error states and similar use-cases.

<picture><source srcset="status-page-dark.png" media="(prefers-color-scheme: dark)"><img src="status-page.png" alt="status-page"></picture>

The `AdwStatusPage` widget can have an icon, a title, a description and a
custom widget which is displayed below them.

## CSS nodes

`AdwStatusPage` has a main CSS node with name `statuspage`.

`AdwStatusPage` can use the
[`.compact`](style-classes.html#compact-status-page) style class for when it
needs to fit into a small space such a sidebar or a popover.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `child`

The child widget.

### `description`

The description markup to be displayed below the title.

### `iconName`

The name of the icon to be used.

Changing this will set [property@StatusPage:paintable] to `NULL`.

### `title`

The title to be displayed below the icon.

It is not parsed as Pango markup.

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `StatusPage`.

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

### `child(_:)`

The child widget.

### `description(_:)`

The description markup to be displayed below the title.

### `iconName(_:)`

The name of the icon to be used.

Changing this will set [property@StatusPage:paintable] to `NULL`.

### `title(_:)`

The title to be displayed below the icon.

It is not parsed as Pango markup.
