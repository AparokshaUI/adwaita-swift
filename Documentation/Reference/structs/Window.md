**STRUCT**

# `Window`

A structure representing an application window type.

Note that multiple instances of a window can be opened at the same time.

## Properties
### `id`

The window's identifier.

### `content`

The window's content.

### `open`

Whether an instance of the window type should be opened when the app is starting up.

### `parentID`

The identifier of the window's parent.

### `shortcuts`

The keyboard shortcuts.

### `appShortcuts`

The keyboard shortcuts on the app level.

### `defaultSize`

The default window size.

### `title`

The window's title.

### `resizable`

Whether the window is resizable.

### `deletable`

Whether the window is deletable.

### `signals`

The signals for the importers and exporters.

## Methods
### `init(id:open:content:)`

Create a window type with a certain identifier and user interface.
- Parameters:
  - id: The identifier.
  - open: The number of instances of the window type when the app is starting.
  - content: The window's content.

### `createWindow(app:)`

Get the storage for the window.
- Parameter app: The application.
- Returns: The storage.

### `createGTUIWindow(app:)`

Get the window.
- Parameter app: The application.
- Returns: The window.

### `getViewStorage(window:)`

Get the storage of the content view.
- Parameter window: The window.
- Returns: The storage of the content of the window.

### `update(_:app:)`

Update a window storage's content.
- Parameter storage: The storage to update.

### `setProperties(window:)`

Set some general propreties of the window.
- Parameter window: The window.

### `overlay(windows:)`

Add windows that overlay the last instance of this window if presented.
- Parameter windows: The windows.
- Returns: The new windows and this window.

### `fileImporter(_:initialFolder:extensions:folders:onOpen:onClose:)`

Add an importer file dialog to the window.
- Parameters:
    - signal: The signal for opening the dialog.
    - initialFolder: The URL to the folder open when being opened.
    - extensions: The accepted file extensions.
    - folders: Whether folders are accepted.
    - onOpen: Run this when a file for importing has been chosen.
    - onClose: Run this when the user cancelled the action.

### `fileExporter(_:initialFolder:initialName:onSave:onClose:)`

Add an exporter file dialog to the window.
- Parameters:
    - signal: The signal for opening the dialog.
    - initialFolder: The URL to the folder open when being opened.
    - initialName: The default file name.
    - onSave: Run this when a path for exporting has been chosen.
    - onClose: Run this when the user cancelled the action.

### `keyboardShortcut(_:action:)`

Add a keyboard shortcut.
- Parameters:
    - shortcut: The keyboard shortcut.
    - action: The closure to execute when the keyboard shortcut is pressed.
- Returns: The window.

### `updateShortcuts(window:)`

Update the keyboard shortcuts.
- Parameter window: The application window.

### `closeShortcut()`

Add the shortcut "<Ctrl>w" which closes the window.
- Returns: The window.

### `defaultSize(width:height:)`

Set the window's default size.
- Parameters:
    - width: The window's width.
    - height: The window's height.
- Returns: The window.

### `title(_:)`

Set the window's title.
- Parameter title: The title.
- Returns: The window.

### `resizable(_:)`

Set whether the window is resizable.
- Parameter resizable: The resizability.
- Returns: The window.

### `deletable(_:)`

Set whether the window is deletable.
- Parameter resizable: The deletability.
- Returns: The window.
