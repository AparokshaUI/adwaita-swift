**STRUCT**

# `Clamp`

A widget constraining its child to a given size.

<picture><source srcset="clamp-wide-dark.png" media="(prefers-color-scheme: dark)"><img src="clamp-wide.png" alt="clamp-wide"></picture><picture><source srcset="clamp-narrow-dark.png" media="(prefers-color-scheme: dark)"><img src="clamp-narrow.png" alt="clamp-narrow"></picture>

The `AdwClamp` widget constrains the size of the widget it contains to a
given maximum size. It will constrain the width if it is horizontal, or the
height if it is vertical. The expansion of the child from its minimum to its
maximum size is eased out for a smooth transition.

If the child requires more than the requested maximum size, it will be
allocated the minimum size it can fit in instead.

`AdwClamp` can scale with the text scale factor, use the
[property@ClampLayout:unit] property to enable that behavior.

## CSS nodes

`AdwClamp` has a single CSS node with name `clamp`.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `child`

The child widget of the `AdwClamp`.

### `maximumSize`

The maximum size allocated to the child.

It is the width if the clamp is horizontal, or the height if it is vertical.

### `tighteningThreshold`

The size above which the child is clamped.

Starting from this size, the clamp will tighten its grip on the child,
slowly allocating less and less of the available size up to the maximum
allocated size. Below that threshold and below the maximum size, the child
will be allocated all the available size.

If the threshold is greater than the maximum size to allocate to the child,
the child will be allocated all the size up to the maximum.
If the threshold is lower than the minimum size to allocate to the child,
that size will be used as the tightening threshold.

Effectively, tightening the grip on the child before it reaches its maximum
size makes transitions to and from the maximum size smoother when resizing.

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `Clamp`.

### `container(modifiers:)`

Get the widget's view storage.
- Parameter modifiers: The view modifiers.
- Returns: The view storage.

### `update(_:modifiers:updateProperties:)`

Update the widget's view storage.
- Parameters:
    - storage: The view storage.
    - modifiers: The view modifiers.
    - updateProperties: Whether to update the view's properties.

### `child(_:)`

The child widget of the `AdwClamp`.

### `maximumSize(_:)`

The maximum size allocated to the child.

It is the width if the clamp is horizontal, or the height if it is vertical.

### `tighteningThreshold(_:)`

The size above which the child is clamped.

Starting from this size, the clamp will tighten its grip on the child,
slowly allocating less and less of the available size up to the maximum
allocated size. Below that threshold and below the maximum size, the child
will be allocated all the available size.

If the threshold is greater than the maximum size to allocate to the child,
the child will be allocated all the size up to the maximum.
If the threshold is lower than the minimum size to allocate to the child,
that size will be used as the tightening threshold.

Effectively, tightening the grip on the child before it reaches its maximum
size makes transitions to and from the maximum size smoother when resizing.
