**EXTENSION**

# `HeaderBar`

## Methods
### `init(titleButtons:start:end:)`

Initialize a header bar.
- Parameters:
  - titleButtons: Whether the title buttons (e.g. close button) are visible.
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

### `headerBarTitle(view:)`

Set the title widget for the header bar.
- Parameter view: The widget in the header bar.
- Returns: The header bar.
