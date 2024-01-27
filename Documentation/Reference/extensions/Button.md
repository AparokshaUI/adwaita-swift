**EXTENSION**

# `Button`

## Methods
### `init(_:icon:handler:)`

Initialize a button.
- Parameters:
  - label: The button's label.
  - icon: The button's icon.
  - handler: The button's action handler.

### `init(_:handler:)`

Initialize a button.
- Parameters:
  - label: The buttons label.
  - handler: The button's action handler.

### `keyboardShortcut(_:window:)`

Create a keyboard shortcut for an application window from a button.

Note that the keyboard shortcut is available after the view has been visible for the first time.
- Parameters:
    - shortcut: The keyboard shortcut.
    - window: The application window.
- Returns: The button.

### `keyboardShortcut(_:app:)`

Create a keyboard shortcut for an application from a button.

Note that the keyboard shortcut is available after the view has been visible for the first time.
- Parameters:
    - shortcut: The keyboard shortcut.
    - window: The application.
- Returns: The button.
