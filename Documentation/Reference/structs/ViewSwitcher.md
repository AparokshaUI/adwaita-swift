**STRUCT**

# `ViewSwitcher`

A picker used for indicating multiple views.

It normally controls a `ViewStack` (e.g. via `switch` statements).

## Properties
### `selection`

The selected element.

### `wide`

Whether the wide style is used, that means the icons and titles are on the same line.

## Methods
### `init(selection:)`

Initialize a view switcher.
- Parameter selection: The selected element.

### `container(modifiers:)`

Get a view switcher's view storage.
- Parameter modifiers: Modify views before being updated.
- Returns: The view storage.

### `update(_:modifiers:)`

Update a view switcher's view storage.
- Parameters:
    - storage: The view storage.
    - modifiers: Modify views before being updated.

### `updateSwitcher(switcher:)`

Update a view switcher's style and selection.
- Parameter switcher: The view switcher.

### `wideDesign(_:)`

Set whether to use the wide design.
- Parameter wide: Whether to use the wide design.
- Returns: The view switcher.
