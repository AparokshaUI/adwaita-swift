**PROTOCOL**

# `WindowScene`

A structure representing the content for a certain window type.

## Properties
### `id`

The window type's identifier.

### `parentID`

The identifier of the window's parent window.

### `open`

The number of instances of the window at the startup.

### `appShortcuts`

The keyboard shortcuts on the application's level.

## Methods
### `createWindow(app:)`

Get the storage for the window.
- Parameter app: The application.
- Returns: The storage.

### `update(_:app:force:)`

Update a window storage's content.
- Parameters:
    - storage: The storage to update.
    - app: The application.
    - force: Whether to force update all the views.
