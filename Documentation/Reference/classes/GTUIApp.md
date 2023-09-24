**CLASS**

# `GTUIApp`

The GTUI application.

## Properties
### `updateHandlers`

The handlers which are called when a state changes.

### `body`

The app's content.

### `sceneStorage`

The scenes that are displayed.

## Methods
### `init(_:body:)`

Initialize the GTUI application.
- Parameters:
    - id: The application id.
    - body: The application's content.

### `onActivate()`

The entry point of the application.

### `showWindow(_:)`

Focus the window with a certain id. Create the window if it doesn't already exist.
- Parameters:
    - id: The window's id.

### `addWindow(_:)`

Add a new window with the content of the window with a certain id.
- Parameters:
    - id: The window's id.
