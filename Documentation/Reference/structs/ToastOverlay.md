**STRUCT**

# `ToastOverlay`

A wrapper around a view presenting toasts.

## Properties
### `signal`

The signal for showing the toast./// Present a toast when the signal gets activated.

### `child`

The child view.

### `title`

The title of the toast.

### `button`

Information about the button if available (label and handler).

## Methods
### `container(modifiers:)`

Get the overlay's view storage.
- Parameter modifiers: The view modifiers.
- Returns: The view storage.

### `update(_:modifiers:)`

Update the overlay's view storage.
- Parameters:
    - storage: The view storage.
    - modifiers: The view modifiers.

### `setVisibility(_:)`

Add a toast if the signal is active.
- Parameter overlay: The toast overlay.
