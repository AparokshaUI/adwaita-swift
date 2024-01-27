**PROTOCOL**

# `Widget`

A widget is a view that know about its GTUI widget.

## Methods
### `container(modifiers:)`

The view storage.
- Parameter modifiers: Modify views before being updated.

### `update(_:modifiers:updateProperties:)`

Update the stored content.
- Parameters:
    - storage: The storage to update.
    - modifiers: Modify views before being updated
    - updateProperties: Whether to update the view's properties.
