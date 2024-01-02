**STRUCT**

# `State`

A property wrapper for properties in a view that should be stored throughout view updates.

## Properties
### `wrappedValue`

Access the stored value. This updates the views when being changed.

### `projectedValue`

Get the value as a binding using the `$` prefix.

### `rawValue`

Get and set the value without updating the views.

### `content`

The stored value.

### `writeValue`

The function for updating the value in the settings file.

### `value`

The value with an erased type.

## Methods
### `init(wrappedValue:)`

Initialize a property representing a state in the view.
- Parameters:
    - wrappedValue: The wrapped value.

### `updateViews()`

Update all of the views.

### `dirPath()`

Get the settings directory path.
- Returns: The path.

### `filePath()`

Get the settings file path.
- Returns: The path.
