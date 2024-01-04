**STRUCT**

# `ComboRow`

A row for selecting an element out of a list of elements.

## Properties
### `title`

The title.

### `selection`

The selected element.

### `content`

The content.

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

### `elementsID`

The identifier for the elements.

## Methods
### `init(_:selection:values:)`

Initialize a combo row.
- Parameters:
    - title: The row's title.
    - selection: The selected value.
    - values: The available values.

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

Update the combo row.
- Parameter row: The combo row.

### `subtitle(_:)`

Set the combo row's subtitle.
- Parameter subtitle: The subtitle.
- Returns: The combo row.

### `prefix(_:)`

Set the combo row's prefix view.
- Parameter prefix: The prefix.
- Returns: The combo row.

### `suffix(_:)`

Set the combo row's suffix view.
- Parameter suffix: The suffix.
- Returns: The combo row.
