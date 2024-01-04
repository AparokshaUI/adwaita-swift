**STRUCT**

# `SpinRow`

A spin row lets the user select an integer in a certain range.

## Properties
### `title`

The title.

### `value`

The selected value.

### `min`

The minimum value.

### `max`

The maximum value.

### `step`

The increase/decrease step.

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

### `configID`

The identifier of the configuration field.

## Methods
### `init(_:value:min:max:)`

Initialize a spin row.
- Parameters:
    - title: The row's title.
    - value: The selected value.
    - min: The minimum value.
    - max: The maximum value.

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

Update the spin row.
- Parameter row: The spin row.

### `subtitle(_:)`

Set the spin row's subtitle.
- Parameter subtitle: The subtitle.
- Returns: The spin row.

### `prefix(_:)`

Set the spin row's prefix view.
- Parameter prefix: The prefix.
- Returns: The spin row.

### `suffix(_:)`

Set the spin row's suffix view.
- Parameter suffix: The suffix.
- Returns: The spin row.

### `step(_:)`

Set the difference a single click on the increase/decrease buttons makes.
- Parameter step: The increase/decrease step.
- Returns: The spin row.
