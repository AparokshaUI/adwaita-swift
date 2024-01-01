**STRUCT**

# `Container`

A container widget.

## Properties
### `elements`

The elements.

### `content`

The content.

### `container`

Get the container for initialization.

### `elementsID`

The identifier of the elements storage.

## Methods
### `init(_:content:container:)`

Initialize `Container`.
- Parameters:
  - elements: The elements.
  - content: The view for an element.
  - container: Get the initial Libadwaita container widget.

### `update(_:modifiers:)`

Update a view storage.
- Parameters:
    - storage: The view storage.
    - modifiers: Modify views before being updated.

### `container(modifiers:)`

Get a view storage.
- Parameter modifiers: Modify views before being updated.
- Returns: The view storage.

### `updateContainer(_:content:modifiers:)`

Update the container's content.
- Parameters:
    - container: The container.
    - content: The content's view storage.
    - modifiers: The view modifiers.

### `getWidget(element:modifiers:)`

Get the view storage of an element.
- Parameters:
    - element: The element.
    - modifiers: The modifiers.
- Returns: The view storage.
