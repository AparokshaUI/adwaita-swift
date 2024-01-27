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

### `forceUpdates`

Whether to force update the views when the value changes.

### `writeValue`

The function for updating the value in the settings file.

### `value`

The value with an erased type.

## Methods
### `init(wrappedValue:forceUpdates:)`

Initialize a property representing a state in the view.
- Parameters:
    - wrappedValue: The wrapped value.
    - forceUpdates: Whether to force update all available views when the property gets modified.

### `updateViews(force:)`

Update all of the views.
- Parameter force: Whether to force all views to update.

### `userDataDir()`

The directory used for storing user data.
- Returns: The URL.

### `copy(_:)`

Copy a text to the clipboard.
- Parameter text: The text.

### `dirPath()`

Get the settings directory path.
- Returns: The path.

### `filePath()`

Get the settings file path.
- Returns: The path.
