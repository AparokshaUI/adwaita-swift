**STRUCT**

# `Bin`

A widget with one child.

<picture><source srcset="bin-dark.png" media="(prefers-color-scheme: dark)"><img src="bin.png" alt="bin"></picture>

The `AdwBin` widget has only one child, set with the [property@Bin:child]
property.

It is useful for deriving subclasses, since it provides common code needed
for handling a single child widget.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `child`

The child widget of the `AdwBin`.

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `Bin`.

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

The child widget of the `AdwBin`.
