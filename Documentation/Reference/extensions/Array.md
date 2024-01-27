**EXTENSION**

# `Array`

## Properties
### `view`

The array's view body is the array itself.

### `cArray`

Get the C version of the array.

## Methods
### `widget(modifiers:)`

Get a widget from a collection of views.
- Parameter modifiers: Modify views before being updated.
- Returns: A widget.

### `update(_:modifiers:updateProperties:)`

Update a collection of views with a collection of view storages.
- Parameters:
    - storage: The collection of view storages.
    - modifiers: Modify views before being updated.
    - updateProperties: Whether to update properties.

### `windows()`

Get the content of an array of window scene groups.
- Returns: The array of windows.

### `checkIndex(_:)`

Check if a given index is valid for the array.
- Parameter index: The index to test.
- Returns: Return whether the index is valid or not.
