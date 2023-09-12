**STRUCT**

# `State`

A property wrapper for properties in a view that should be stored throughout view updates.

## Properties
### `wrappedValue`

Access the stored value. This updates the views when being changed.

### `projectedValue`

Get the value as a binding using the `$` prefix.

### `storage`

The stored value.

### `value`

The value with an erased type.

## Methods
### `init(wrappedValue:)`

Initialize a property representing a state in the view.
- Parameters:
    - wrappedValue: The wrapped value.

### `updateViews()`

Update all of the views.
