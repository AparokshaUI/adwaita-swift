**EXTENSION**

# `State`

## Methods
### `init(wrappedValue:_:folder:forceUpdates:)`

Initialize a property representing a state in the view.
- Parameters:
    - wrappedValue: The wrapped value.
    - key: The unique storage key of the property.
    - folder: The path to the folder containing the JSON file.
    - forceUpdates: Whether to force update all available views when the property gets modified.

The folder path will be appended to the XDG data home directory.

### `checkFile()`

Check whether the settings file exists, and, if not, create it.

### `readValue()`

Update the local value with the value from the file.

### `writeCodableValue()`

Update the value on the file with the local value.
