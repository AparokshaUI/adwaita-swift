**STRUCT**

# `ContentModifier`

A widget which replaces views of a specific type in its content.

## Properties
### `content`

The wrapped view.

### `modify`

The closure for the modification.

## Methods
### `container(modifiers:)`

Get the content's container.
- Parameter modifiers: Modify views before being updated.
- Returns: The content's container.

### `update(_:modifiers:updateProperties:)`

Update the content.
- Parameters:
    - storage: The content's storage.
    - modifiers: Modify views before being updated.
    - updateProperties: Whether to update properties.

### `modifyView(_:)`

Apply the modifier to a view.
- Parameter view: The view.
