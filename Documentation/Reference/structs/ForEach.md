**STRUCT**

# `ForEach`

A dynamic list but without a list design in the user interface.

## Properties
### `elements`

The dynamic widget elements.

### `content`

The dynamic widget content.

### `horizontal`

Whether the list is horizontal.

## Methods
### `init(_:horizontal:content:)`

Initialize `ForEach`.

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
