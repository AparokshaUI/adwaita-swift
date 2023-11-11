**STRUCT**

# `NavigationSplitView`

A navigation split view widget.

## Properties
### `sidebar`

The sidebar's content.

### `content`

The split view's main content.

### `sidebarID`

The sidebar content's id.

### `contentID`

The main content's id.

## Methods
### `init(sidebar:content:)`

Initialize a navigation split view.
- Parameters:
  - sidebar: The sidebar content.
  - content: The main content.

### `container(modifiers:)`

Get the container of the navigation split view widget.
- Parameter modifiers: Modify views before being updated.
- Returns: The view storage.

### `update(_:modifiers:)`

Update the view storage of the navigation split view widget.
- Parameters:
    - storage: The view storage.
    - modifiers: Modify views before being updated.
