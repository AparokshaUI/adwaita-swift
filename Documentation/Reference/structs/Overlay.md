**STRUCT**

# `Overlay`

A wrapper around a view for adding other views on top.

## Properties
### `child`

The child view.

### `overlay`

The overlay view.

### `overlayID`

The identifier for the overlay content.

## Methods
### `container(modifiers:)`

Get the overlay's view storage.
- Parameter modifiers: The view modifiers.
- Returns: The view storage.

### `update(_:modifiers:)`

Update the overlay's view storage.
- Parameters:
    - storage: The view storage.
    - modifiers: The view modifiers.
