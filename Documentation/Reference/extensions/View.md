**EXTENSION**

# `View`

## Methods
### `widget()`

Wrap the view into a widget.
- Returns: The widget.

### `updateStorage(_:)`

Update a storage to a view.
- Parameter storage: The storage.

### `storage()`

Get a storage.
- Returns: The storage.

### `inspect(_:)`

Modify a GTUI widget before being displayed.
- Parameter modify: Modify the widget.
- Returns: A view.

### `padding(_:_:)`

Add padding around a view.
- Parameters:
  - padding: The size of the padding.
  - edges: The edges which are affected by the padding.
- Returns: A view.

### `hexpand(_:)`

Enable or disable the horizontal expansion.
- Parameter enabled: Whether it is enabled or disabled.
- Returns: A view.

### `vexpand(_:)`

Enable or disable the vertical expansion.
- Parameter enabled: Whether it is enabled or disabled.
- Returns: A view.

### `frame(minWidth:minHeight:)`

Set the view's minimal width or height.
- Parameters:
  - minWidth: The minimal width.
  - minHeight: The minimal height.
- Returns: A view.

### `frame(maxSize:)`

Set the view's maximal size.
- Parameter maxSize: The maximal size.
- Returns: A view.

### `transition(_:)`

Set the view's transition.
- Parameter transition: The transition.
- Returns: A view.

### `onUpdate(_:)`

Run a function when the view gets an update.
- Parameter onUpdate: The function.
- Returns: A view.
