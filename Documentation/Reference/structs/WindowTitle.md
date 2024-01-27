**STRUCT**

# `WindowTitle`

A helper widget for setting a window's title and subtitle.

<picture><source srcset="window-title-dark.png" media="(prefers-color-scheme: dark)"><img src="window-title.png" alt="window-title"></picture>

`AdwWindowTitle` shows a title and subtitle. It's intended to be used as the
title child of [class@Gtk.HeaderBar] or [class@HeaderBar].

## CSS nodes

`AdwWindowTitle` has a single CSS node with name `windowtitle`.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `subtitle`

The subtitle to display.

The subtitle should give the user additional details.

### `title`

The title to display.

The title typically identifies the current view or content item, and
generally does not use the application name.

### `app`

The application.

### `window`

The window.

## Methods
### `init(subtitle:title:)`

Initialize `WindowTitle`.

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

### `subtitle(_:)`

The subtitle to display.

The subtitle should give the user additional details.

### `title(_:)`

The title to display.

The title typically identifies the current view or content item, and
generally does not use the application name.
