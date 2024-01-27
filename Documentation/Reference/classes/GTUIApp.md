**CLASS**

# `GTUIApp`

The GTUI application.

## Properties
### `updateHandlers`

The handlers which are called when a state changes.

### `appID`

The app's id for the file name for storing the data.

### `pointer`

The pointer to the application.

### `fields`

Fields for additional information.

### `body`

The app's content.

### `sceneStorage`

The scenes that are displayed.

### `overwriteParentID`

A string signaling that the parent should not be overwritten.

## Methods
### `init(_:body:)`

Initialize the GTUI application.
- Parameters:
    - id: The application id.
    - body: The application's content.

### `onActivate()`

The entry point of the application.

### `run()`

Run the application.

### `addKeyboardShortcut(_:id:window:handler:)`

Add a keyboard shortcut to the application.
- Parameters:
    - shortcut: The keyboard shortcut.
    - id: The action's id.
    - window: Optionally an application window.
    - handler: The action's handler.

### `showWindow(_:)`

Focus the window with a certain id. Create the window if it doesn't already exist.
- Parameters:
    - id: The window's id.

### `addWindow(_:parent:)`

Add a new window with the content of the window with a certain id.
- Parameters:
    - id: The window's id.
    - parent: The parent window.

### `setParentWindows()`

Set the parents of every window having a parent window.

### `quit()`

Terminate the application.
