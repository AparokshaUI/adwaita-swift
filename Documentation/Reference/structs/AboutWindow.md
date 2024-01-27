**STRUCT**

# `AboutWindow`

A structure representing an about window.

## Properties
### `id`

The window's identifier.

### `open`

Whether an instance of the window type should be opened when the app is starting up.

### `parentID`

The identifier of the window's parent.

### `appShortcuts`

The keyboard shortcuts on the app level.

### `appName`

The app's name.

### `developer`

The developer's name.

### `version`

The app version.

### `icon`

The app icon.

### `website`

The app's website.

### `path`

The path to the app data file.

## Methods
### `init(id:appName:developer:version:)`

Create a window type with a certain identifier and content.
- Parameters:
  - id: The identifier.
  - appName: The app's name.
  - developer: The developer's name.
  - version: The app version.

### `init(id:path:)`

Create a window type with a certain identifier and content.
- Parameters:
  - id: The identifier.
  - path: The path to the app data file.

### `icon(_:)`

Set the app icon.
- Parameter icon: The app icon.
- Returns: The window.

### `website(_:)`

Set the app's website.
- Parameter url: The app's website.
- Returns: The window.

### `createWindow(app:)`

Get the storage for the window.
- Parameter app: The application.
- Returns: The storage.

### `createGTUIWindow(app:)`

Get the window.
- Parameter app: The application.
- Returns: The window.

### `update(_:app:force:)`

Update a window.
- Parameters:
    - storage: The storage to update.
    - app: The application.
    - force: Whether to force update all the views.

### `updateData(window:)`

Update the data for a window.
- Parameter window: The window.
