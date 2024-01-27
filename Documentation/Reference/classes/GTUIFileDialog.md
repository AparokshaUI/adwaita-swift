**CLASS**

# `GTUIFileDialog`

A GTUI file dialog window.

## Properties
### `pointer`

The file dialog's pointer.

### `fields`

Fields for additional data.

### `selfAddr`

A link to the file dialog.

### `parent`

The parent window.

### `isImporter`

Whether the file dialog is an importer.

### `folder`

The selected folder in the file dialog.

### `onResult`

A closure triggered on selecting a file in the dialog.

### `onCancel`

A closure triggered when the dialog is canceled.

## Methods
### `init()`

Initialize the window.

### `setParentWindow(_:)`

Set the window's parent window.
- Parameter parent: The parent window.

### `setInitialName(_:)`

Set the initial name.
- Parameter name: The parent window.

### `setExtensions(_:)`

Set the allowed file extensions.
- Parameters:
    - extensions: The file extensions.

### `show()`

Display the file dialog.

### `onOpen(_:)`

Run this when a file gets opened.
- Parameter path: The file path.

### `onSave(_:)`

Run this when a file gets saved.
- Parameter path: The file path.

### `onClose()`

Run this when the user cancels the action.
