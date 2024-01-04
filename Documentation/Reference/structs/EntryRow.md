**STRUCT**

# `EntryRow`

A form content row accepting text input.

## Properties
### `title`

The title.

### `text`

The text.

### `prefix`

The prefix.

### `suffix`

The suffix.

### `onSubmit`

The handler that gets executed when the user submits the content.

### `password`

Whether the password entry row should be used.

### `prefixID`

The identifier for the prefix content.

### `suffixID`

The identifier for the suffix content.

## Methods
### `init(_:text:)`

Initialize an entry row.
- Parameters:
    - title: The row's title.
    - text: The text.

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

Update the entry row.
- Parameter row: The entry row.

### `onSubmit(_:)`

Set the entry row's subtitle.
- Parameter subtitle: The subtitle.
- Returns: The entry row.

### `prefix(_:)`

Set the entry row's prefix view.
- Parameter prefix: The prefix.
- Returns: The entry row.

### `suffix(_:)`

Set the entry row's suffix view.
- Parameter suffix: The suffix.
- Returns: The entry row.

### `secure()`

Let the user securely enter private text.
- Returns: The entry row.
