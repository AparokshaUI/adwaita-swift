**STRUCT**

# `Banner`

A banner widget.

## Properties
### `title`

The content.

### `visible`

Whether the banner is visible.

### `buttonLabel`

The button's label.

### `handler`

The button's handler.

## Methods
### `init(_:visible:)`

Initialize a text widget.
- Parameters:
    - title: The content.
    - visible: Whether the banner is visible.

### `update(_:modifiers:)`

Update the view storage of the text widget.
- Parameters:
    - storage: The view storage.
    - modifiers: Modify views before being updated.

### `container(modifiers:)`

Get the container of the text widget.
- Returns: The view storage.

### `update(banner:)`

Update the banner.
- Parameter banner: The banner.

### `button(_:handler:)`

Configure the banner's button.
- Parameters:
    - label: The button's title.
    - handler: The button's handler.
- Returns: The banner.
