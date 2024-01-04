**STRUCT**

# `Text`

A text widget.

## Properties
### `text`

The content.

### `lineWrapping`

Whether line wrapping is allowed.

## Methods
### `init(_:)`

Initialize a text widget.
- Parameter text: The content.

### `update(_:modifiers:)`

Update the view storage of the text widget.
- Parameters:
    - storage: The view storage.
    - modifiers: Modify views before being updated.

### `container(modifiers:)`

Get the container of the text widget.
- Returns: The view storage.

### `wrap(_:)`

Line wrapping allows the text view to span multiple lines if the width is narrow.
- Parameter wrap: Whether to allow line wrapping.
- Returns: The text.
