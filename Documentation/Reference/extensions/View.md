**EXTENSION**

# `View`

## Methods
### `widget(modifiers:)`

Wrap the view into a widget.
- Parameter modifiers: Modify views before being updated.
- Returns: The widget.

### `updateStorage(_:modifiers:updateProperties:)`

Update a storage to a view.
- Parameters:
    - storage: The storage.
    - modifiers: Modify views before being updated.
    - updateProperties: Whether to update properties.

### `getState()`

### `storage(modifiers:)`

Get a storage.
- Parameter modifiers: Modify views before being updated.
- Returns: The storage.

### `getModified(modifiers:)`

### `inspectOnAppear(_:)`

Run a function on the widget when it appears for the first time.
- Parameter closure: The function.
- Returns: A view.

### `onAppear(_:)`

Run a function when the view appears for the first time.
- Parameter closure: The function.
- Returns: A view.

### `onClick(handler:)`

Run a function when the widget gets clicked.
- Parameter handler: The function.
- Returns: A view.

### `frame(maxSize:)`

Set the view's maximum width.
- Parameter maxSize: The maximum width.
- Returns: A view.

### `frame(maxWidth:)`

Set the view's maximum width.
- Parameter maxWidth: The maximum width.
- Returns: A view.

### `frame(maxHeight:)`

Set the view's maximum height.
- Parameter maxHeight: The maximum height.
- Returns: A view.

### `modifyContent(_:modify:)`

Replace every occurrence of a certain view type in the content.
- Parameters:
    - type: The view type.
    - modify: Modify the view.
- Returns: A view.

### `freeze(_:)`

Prevent a view from being updated.
- Parameter freeze: Whether to freeze the view.
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

### `insensitive(_:)`

Make the view insensitive (useful e.g. in overlays).
- Parameter insensitive: Whether the view is insensitive.
- Returns: A view.

### `visible(_:)`

Set the view's visibility.
- Parameter visible: Whether the view is visible.
- Returns: A view.

### `focused(_:)`

Bind to the view's focus.
- Parameter focus: Whether the view is focused.
- Returns: A view.

### `focus(_:)`

Bind a signal that focuses the view.
- Parameter focus: Whether the view is focused.
- Returns: A view.

### `stopModifiers()`

Remove all of the content modifiers for the wrapped views.
- Returns: A view.

### `popover(visible:content:)`

Add a popover on top of the view.
- Parameters:
    - visible: Whether the popover is displayed.
    - content: The popover's content.
- Returns: The view.

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

### `verticalCenter()`

Wrap the view in a vertical stack and center vertically.
- Returns: The view.

### `horizontalCenter()`

Wrap the view in a horizontal stack and center horizontally.
- Returns: The view.

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

### `overlay(_:)`

Add an overlay view.
- Parameters:
    - overlay: The overlay view.
- Returns: A view.
