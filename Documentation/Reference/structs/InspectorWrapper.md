**STRUCT**

# `InspectorWrapper`

A widget which executes a custom code on the GTUI widget when being created and updated.

## Properties
### `modify`

The custom code to edit the widget.

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
