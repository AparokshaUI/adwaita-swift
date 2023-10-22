**STRUCT**

# `MenuButton`

A button widget for menus.

## Properties
### `label`

The button's label.

### `handler`

The button's action handler.

### `shortcut`

The keyboard shortcut.

### `preferApplicationWindow`

Whether to prefer adding the action to the application window.

## Methods
### `init(_:window:handler:)`

Initialize a menu button.
- Parameters:
  - label: The buttons label.
  - window: Whether to prefer adding the action to the application window.
  - handler: The button's action handler.

### `addMenuItem(menu:app:window:)`

Add the button to a menu.
- Parameters:
  - menu: The menu.
  - app: The application containing the menu.
  - window: The application window containing the menu.

### `keyboardShortcut(_:)`

Create a keyboard shortcut for an application from a button.

Note that the keyboard shortcut is available after the view has been visible for the first time.
- Parameters:
    - shortcut: The keyboard shortcut.
- Returns: The button.
