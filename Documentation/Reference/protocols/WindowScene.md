**PROTOCOL**

# `WindowScene`

A structure representing the content for a certain window type.

## Properties
### `id`

The window type's identifier.

### `open`

The number of instances of the window at the startup.

## Methods
### `createWindow(app:)`

Get the storage for the window.
- Parameter app: The application.
- Returns: The storage.

### `update(_:)`

Update a window storage's content.
- Parameter storage: The storage to update.
