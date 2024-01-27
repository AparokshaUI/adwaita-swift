**STRUCT**

# `Spinner`

A `GtkSpinner` widget displays an icon-size spinning animation.

It is often used as an alternative to a [class@Gtk.ProgressBar]
for displaying indefinite activity, instead of actual progress.

![An example GtkSpinner](spinner.png)

To start the animation, use [method@Gtk.Spinner.start], to stop it
use [method@Gtk.Spinner.stop].

# CSS nodes

`GtkSpinner` has a single CSS node with the name spinner.
When the animation is active, the :checked pseudoclass is
added to this node.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `spinning`

Whether the spinner is spinning

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `Spinner`.

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

### `spinning(_:)`

Whether the spinner is spinning
