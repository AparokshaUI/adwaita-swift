**EXTENSION**

# `State`

## Methods
### `init(wrappedValue:_:)`

Initialize a property representing a state in the view.
- Parameters:
    - key: The unique storage key of the property.
    - wrappedValue: The wrapped value.

### `checkFile()`

Check whether the settings file exists, and, if not, create it.

### `readValue()`

Update the local value with the value from the file.

### `writeCodableValue()`

Update the value on the file with the local value.
