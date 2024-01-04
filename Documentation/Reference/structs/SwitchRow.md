**STRUCT**

# `SwitchRow`

A row representing a boolean state.

## Properties
### `title`

The title.

### `isOn`

Whether the switch is activated.

### `subtitle`

The subtitle.

### `prefix`

The prefix.

### `suffix`

The suffix.

### `prefixID`

The identifier for the prefix content.

### `suffixID`

The identifier for the suffix content.

## Methods
### `init(_:isOn:)`

Initialize a switch row.
- Parameters:
    - title: The row's title.
    - isOn: Whether the switch is on.

### `update(_:modifiers:)`

Update a view storage.
- Parameters:
    - storage: The view storage.
    - modifiers: Modify views before being updated.

### `container(modifiers:)`

Get a view storage.
- Parameter modifiers: Modify views before being updated.
- Returns: The view storage.

### `update(row:)`

Update the switch row.
- Parameter row: The switch row.

### `subtitle(_:)`

Set the switch row's subtitle.
- Parameter subtitle: The subtitle.
- Returns: The switch row.

### `prefix(_:)`

Set the switch row's prefix view.
- Parameter prefix: The prefix.
- Returns: The switch row.

### `suffix(_:)`

Set the switch row's suffix view.
- Parameter suffix: The suffix.
- Returns: The switch row.
