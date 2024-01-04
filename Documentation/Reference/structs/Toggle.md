**STRUCT**

# `Toggle`

A toggle button widget.

## Properties
### `label`

The button's label.

### `icon`

The button's icon.

### `isOn`

Whether the toggle is on.

### `isCheckButton`

Whether to use GtkCheckButton instead of GtkToggleButton

## Methods
### `init(_:icon:isOn:)`

Initialize a toggle button.
- Parameters:
  - label: The button's label.
  - icon: The button's icon.
  - isOn: Whether the toggle is on.

### `init(_:isOn:)`

Initialize a toggle button.
- Parameters:
  - label: The buttons label.
  - isOn: Whether the toggle is on.

### `update(_:modifiers:)`

Update a toggle button's view storage.
- Parameters:
    - storage: The view storage.
    - modifiers: Modify views before being updated.

### `container(modifiers:)`

Get a button's view storage.
- Parameter modifiers: Modify views before being updated.
- Returns: The button's view storage.

### `updateState(toggle:)`

Update the toggle's state.
- Parameter toggle: The toggle.

### `updateState(toggle:)`

Update the check button's state.
- Parameter toggle: The toggle.

### `checkButton()`

Use the check button style.
- Returns: The toggle.
