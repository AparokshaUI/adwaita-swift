**STRUCT**

# `Menu`

A menu button widget.

## Properties
### `label`

The button's label.

### `icon`

The button's icon.

### `content`

The menu's content.

### `app`

The application.

### `window`

The window.

## Methods
### `init(_:icon:app:window:content:)`

Initialize a menu button.
- Parameters:
  - label: The button's label.
  - icon: The button's icon.
  - app: The application.
  - window: The application window.
  - content: The menu's content.

### `init(_:app:window:content:)`

Initialize a menu button.
- Parameters:
  - label: The buttons label.
  - app: The application.
  - window: The application window.
  - content: The menu's content.

### `update(_:modifiers:)`

Update a button's view storage.
- Parameters:
    - storage: The view storage.
    - modifiers: Modify views before being updated.

### `container(modifiers:)`

Get a button's view storage.
- Parameter modifiers: Modify views before being updated.
- Returns: The button's view storage.
