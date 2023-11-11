**STRUCT**

# `List`

A list box widget.

## Properties
### `elements`

The elements.

### `content`

The content.

### `selection`

The identifier of the selected element.

## Methods
### `init(_:selection:content:)`

Initialize `List`.
- Parameters:
  - elements: The elements.
  - selection: The identifier of the selected element.
  - content: The view for an element.

### `update(_:modifiers:)`

Update a view storage.
- Parameters:
    - storage: The view storage.
    - modifiers: Modify views before being updated.

### `container(modifiers:)`

Get a view storage.
- Parameter modifiers: Modify views before being updated.
- Returns: The view storage.

### `updateSelection(box:)`

Update the list's selection.
- Parameter box: The list box.

### `sidebarStyle()`

Add the "navigation-sidebar" style class.
