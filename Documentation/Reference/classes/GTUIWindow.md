**CLASS**

# `GTUIWindow`

A GTUI window.

## Properties
### `pointer`

The window's pointer.

### `fields`

Fields for additional information.

## Methods
### `init()`

Initialize the window.

### `init(fields:)`

Initialize the window, but not the pointer.
- Parameter fields: The fields.

### `setDefaultSize(width:height:)`

Set the default window size.
- Parameters:
    - width: The width.
    - height: The height.

### `setResizability(_:)`

Set the resizability.
- Parameter resizable: Whether the window is resizable.

### `setDeletability(_:)`

Set the deletability.
- Parameter deletable: Whether the window is deletable.

### `setTitle(_:)`

Set the window title.
- Parameter title: The window's title.

### `setChild(_:)`

Set the window's child.
- Parameter child: The child.

### `show()`

Present the window.

### `observeHide(observer:)`

Observe when the window is being closed.
- Parameter observer: The signal closure.

### `close()`

Close the window.

### `setParentWindow(_:)`

Set the window's parent window.
- Parameter parent: The parent window.
