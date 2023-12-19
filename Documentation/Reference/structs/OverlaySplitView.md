**STRUCT**

# `OverlaySplitView`

An overlay split view widget.

## Properties
### `sidebar`

The sidebar's content.

### `content`

The split view's main content.

### `trailing`

Whether the sidebar is at the trailing position.

### `sidebarID`

The sidebar content's id.

### `contentID`

The main content's id.

## Methods
### `init(sidebar:content:)`

Initialize an overlay split view.
- Parameters:
  - sidebar: The sidebar content.
  - content: The main content.

### `trailingSidebar(_:)`

The position of the sidebar.
- Parameter trailing: Whether the sidebar is at the trailing position.
- Returns: The navigation split view.

### `container(modifiers:)`

Get the container of the overlay split view widget.
- Parameter modifiers: Modify views before being updated.
- Returns: The view storage.

### `update(_:modifiers:)`

Update the view storage of the overlay split view widget.
- Parameters:
    - storage: The view storage.
    - modifiers: Modify views before being updated.

### `updatePosition(_:)`

Update the sidebar's position in the split view.
