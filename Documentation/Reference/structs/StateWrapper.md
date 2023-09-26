**STRUCT**

# `StateWrapper`

A storage for `@State` properties.

## Properties
### `content`

The content.

### `state`

The state information (from properties with the `State` wrapper).

## Methods
### `init(content:)`

Initialize a `StateWrapper`.
- Parameter content: The view content.

### `init(content:state:)`

Initialize a `StateWrapper`.
- Parameters:
  - content: The view content.
  - state: The state information.

### `update(_:)`

Update a view storage.
- Parameter storage: The view storage.

### `container()`

Get a view storage.
- Returns: The view storage.
