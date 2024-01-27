**STRUCT**

# `ViewStack`

A widget holding multiple children but only displaying one.

## Properties
### `content`

The stack's active content.

### `id`

The stack's active identifier.

## Methods
### `init(id:view:)`

Initialize the stack.
- Parameters:
    - id: The identifier of the current view.
    - view: The current view.

### `init(element:view:)`

Initialize the stack.
- Parameters:
    - element: The current identifiable element.
    - view: The current view.

### `container(modifiers:)`

Get a stack's view storage.
- Parameter modifiers: Modify views before being updated.
- Returns: The stack's view storage.

### `update(_:modifiers:updateProperties:)`

Update a stack's view storage.
- Parameters:
    - storage: The view storage.
    - modifiers: Modify views before being updated.
    - updateProperties: Whether to update properties.
