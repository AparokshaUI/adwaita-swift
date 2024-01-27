**STRUCT**

# `FileDialog`

A structure representing a file dialog window.

## Properties
### `id`

The window's identifier.

### `importer`

Whether the window is an importer.

### `open`

Whether an instance of the window type should be opened when the app is starting up.

### `parentID`

The identifier of the window's parent.

### `appShortcuts`

The keyboard shortcuts on the app level.

### `initialFolder`

The initial folder.

### `initialName`

The initial file name for the file exporter.

### `extensions`

The accepted extensions for the file importer.

### `result`

The closure to run when the import or export is successful.

### `cancel`

The closure to run when the import or export is not successful.

## Methods
### `init(importer:initialFolder:extensions:onOpen:onClose:)`

Create an importer file dialog window.
- Parameters:
    - importer: The window's identifier.
    - initialFolder: The URL to the folder open when being opened.
    - extensions: The accepted file extensions.
    - folders: Whether folders are accepted.
    - onOpen: Run this when a file for importing has been chosen.
    - onClose: Run this when the user cancelled the action.

### `init(exporter:initialFolder:initialName:onSave:onClose:)`

Create an exporter file dialog window.
- Parameters:
    - exporter: The window's identifier.
    - initialFolder: The URL to the folder open when being opened.
    - initialName: The default file name.
    - onSave: Run this when a path for exporting has been chosen.
    - onClose: Run this when the user cancelled the action.

### `createWindow(app:)`

Get the storage for the window.
- Parameter app: The application.
- Returns: The storage.

### `update(_:app:force:)`

Update a window.
- Parameters:
    - storage: The storage to update.
    - app: The application.

### `update(window:)`

Update the window.
- Parameter window: The window.
