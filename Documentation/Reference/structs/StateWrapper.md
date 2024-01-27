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

### `update(_:modifiers:updateProperties:)`

Update a view storage.
- Parameters:
    - storage: The view storage.
    - modifiers: Modify views before being updated.
    - updateProperties: Whether to update properties.

### `container(modifiers:)`

Get a view storage.
- Parameter modifiers: Modify views before being updated.
- Returns: The view storage.
