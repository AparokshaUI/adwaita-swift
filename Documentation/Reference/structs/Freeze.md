**STRUCT**

# `Freeze`

State whether to update the child views or not.

## Properties
### `freeze`

Whether not to update the child view.

### `content`

The wrapped view.

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
