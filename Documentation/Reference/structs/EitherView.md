**STRUCT**

# `EitherView`

An equivalent to GtkStack for two views.

## Properties
### `trueView`

The view that is displayed when `isTrue` is true.

### `falseView`

The view that is displayed when `isTrue` is false.

### `isTrue`

The state.

## Methods
### `init(_:_:else:)`

Initialize an `EitherView`.
- Parameters:
  - isTrue: The state.
  - _:  The view that is presented if `isTrue` is true.
  - else: The view that is presented if `isTrue` is false.

### `init(_:_:else:)`

Initialize an `EitherView`.
- Parameters:
  - isTrue: The state.
  - trueView:  The view that is presented if `isTrue` is true.
  - falseView: The view that is presented if `isTrue` is false.

### `update(_:modifiers:)`

Update an `EitherView`'s storage.
- Parameters:
    - storage: The view storage.
    - modifiers: Modify views before being updated.

### `updateContent(_:state:stack:modifiers:)`

Update the content of a view in the view storage.
- Parameters:
  - storage: The view storage.
  - state: Whether it is the true or false view.
  - stack: The stack.
  - modifiers: Modify views before being updated.

### `setVisible(_:view:)`

Set the visible content page.
- Parameters:
  - stack: The stack.
  - view: The visible view.

### `container(modifiers:)`

Get a GtkStack view storage.
- Parameter modifiers: Modify views before being updated.
- Returns: The view storage.
