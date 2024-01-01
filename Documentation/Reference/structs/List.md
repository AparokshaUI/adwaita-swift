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

### `elementsID`

The identifier of the elements storage.

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

### `updateList(box:content:modifiers:)`

Update the list's content and selection.
- Parameters:
    - box: The list box.
    - content: The content's view storage.
    - modifiers: The view modifiers.

### `updateSelection(box:)`

Update the list's selection.
- Parameter box: The list box.

### `getWidget(element:modifiers:)`

Get the view storage of an element.
- Parameters:
    - element: The element.
    - modifiers: The modifiers.
- Returns: The view storage.

### `sidebarStyle()`

Add the "navigation-sidebar" style class.
