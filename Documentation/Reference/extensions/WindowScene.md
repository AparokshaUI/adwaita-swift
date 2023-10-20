**EXTENSION**

# `WindowScene`

## Properties
### `scene`

The window scene's body is itself.

## Methods
### `appKeyboardShortcut(_:action:)`

Add a keyboard shortcut that is available for the whole app.
- Parameters:
    - shortcut: The keyboard shortcut.
    - The closure to execute.

### `updateAppShortcuts(app:)`

Update the app shortcuts.

Call this function in types of window scene.

### `quitShortcut()`

Add the shortcut "<Ctrl>q" which terminates the application.
- Returns: The app.
