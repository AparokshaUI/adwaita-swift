**STRUCT**

# `ActionRow`

A form content row showing a title and optionally a subtitle and widgets.

## Properties
### `title`

The title.

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
### `init(_:)`

Initialize an action row.
- Parameter title: The row's title.

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

Update the action row.
- Parameter row: The action row.

### `subtitle(_:)`

Set the action row's subtitle.
- Parameter subtitle: The subtitle.
- Returns: The action row.

### `prefix(_:)`

Set the action row's prefix view.
- Parameter prefix: The prefix.
- Returns: The action row.

### `suffix(_:)`

Set the action row's suffix view.
- Parameter suffix: The suffix.
- Returns: The action row.
