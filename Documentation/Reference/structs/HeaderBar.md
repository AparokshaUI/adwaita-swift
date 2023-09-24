**STRUCT**

# `HeaderBar`

A header bar widget.

## Properties
### `start`

The start content of the header bar.

### `end`

The end content of the header bar.

### `startID`

The start content's id.

### `endID`

The end content's id.

## Methods
### `init(start:end:)`

Initialize a header bar.
- Parameters:
  - start: The start content.
  - end: The end content.

### `empty()`

Initialize an empty header bar.
- Returns: The header bar.

### `start(start:)`

Initialize a header bar with only views at the start.
- Parameter start: The views.
- Returns: The header bar.

### `end(end:)`

Initialize a header bar with only views at the end.
- Parameter start: The views.
- Returns: The header bar.

### `update(_:)`

Update a header bar's view storage.
- Parameter storage: The view storage.

### `container()`

Get the container for a header bar.
- Returns: The view storage.
