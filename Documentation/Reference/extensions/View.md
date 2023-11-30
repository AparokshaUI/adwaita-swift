**EXTENSION**

# `View`

## Methods
### `widget(modifiers:)`

Wrap the view into a widget.
- Parameter modifiers: Modify views before being updated.
- Returns: The widget.

### `updateStorage(_:modifiers:)`

Update a storage to a view.
- Parameters:
    - storage: The storage.
    - modifiers: Modify views before being updated.

### `storage(modifiers:)`

Get a storage.
- Parameter modifiers: Modify views before being updated.
- Returns: The storage.

### `getModified(modifiers:)`

### `onAppear(_:)`

Run a function when the view appears for the first time.
- Parameter closure: The function.
- Returns: A view.

### `frame(maxSize:)`

Set the view's maximal size.
- Parameter maxSize: The maximal size.
- Returns: A view.

### `modifyContent(_:modify:)`

Replace every occurrence of a certain view type in the content.
- Parameters:
    - type: The view type.
    - modify: Modify the view.
- Returns: A view.

### `inspect(_:)`

Modify a GTUI widget before being displayed and when being updated.
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

### `halign(_:)`

Set the horizontal alignment.
- Parameter align: The alignment.
- Returns: A view.

### `valign(_:)`

Set the vertical alignment.
- Parameter align: The alignment.
- Returns: A view.

### `frame(minWidth:minHeight:)`

Set the view's minimal width or height.
- Parameters:
  - minWidth: The minimal width.
  - minHeight: The minimal height.
- Returns: A view.

### `transition(_:)`

Set the view's transition.
- Parameter transition: The transition.
- Returns: A view.

### `navigationTitle(_:)`

Set the view's navigation title.
- Parameter label: The navigation title.
- Returns: A view.

### `style(_:)`

Add a style class to the view.
- Parameter style: The style class.
- Returns: A view.

### `onUpdate(_:)`

Run a function when the view gets an update.
- Parameter onUpdate: The function.
- Returns: A view.

### `stopModifiers()`

Remove all of the content modifiers for the wrapped views.
- Returns: A view.

### `toast(_:signal:)`

Present a toast when the signal gets activated.
- Parameters:
    - title: The title of the toast.
    - signal: The signal which activates the presentation of a toast.
- Returns: A view.

### `toast(_:signal:button:handler:)`

Present a toast with a button when the signal gets activated.
- Parameters:
    - title: The title of the toast.
    - signal: The signal which activates the presentation of a toast.
    - button: The button's label.
    - handler: The handler for the button.
- Returns: A view.

### `topToolbar(visible:_:)`

Add a top toolbar to the view.
- Parameters:
  - toolbar: The toolbar's content.
  - visible: Whether the toolbar is visible.
- Returns: A view.

### `bottomToolbar(visible:_:)`

Add a bottom toolbar to the view.
- Parameters:
  - toolbar: The toolbar's content.
  - visible: Whether the toolbar is visible.
- Returns: A view.
