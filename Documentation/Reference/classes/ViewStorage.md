**CLASS**

# `ViewStorage`

Store a rendered view in a view storage.

## Properties
### `pointer`

The pointer.

### `content`

The view's content.

### `state`

The view's state (used in `StateWrapper`).

### `handlers`

The signal handlers.

### `fields`

Other properties.

## Methods
### `init(_:content:state:)`

Initialize a view storage.
- Parameters:
  - pointer: The pointer to the Gtk widget.
  - content: The view's content.
  - state: The view's state.

### `notify(name:id:connectFlags:handler:)`

Connect a handler to the observer of a property.
- Parameters:
    - name: The property's name.
    - id: The handlers id to separate form others connecting to the signal.
    - connectFlags: The GConnectFlags.
    - handler: The signal's handler.

### `connectSignal(name:id:connectFlags:argCount:handler:)`

Connect a handler to a signal.
- Parameters:
    - name: The signal's name.
    - id: The handlers id to separate form others connecting to the signal.
    - connectFlags: The GConnectFlags.
    - argCount: The number of additional arguments (without the first and the last one).
    - handler: The signal's handler.

### `connectSignal(name:id:connectFlags:argCount:handler:)`

Connect a handler to a signal.
- Parameters:
    - name: The signal's name.
    - id: The handlers id to separate form others connecting to the signal.
    - connectFlags: The GConnectFlags.
    - argCount: The number of additional arguments (without the first and the last one).
    - handler: The signal's handler.

### `modify(_:)`

Modify the view.
- Parameter modify: The modification function.

### `modify(_:_:)`

Convert the pointer to a pointer of a certain type and modify the view.
- Parameters:
    - type: The pointer's type.
    - modify: The modification function.
