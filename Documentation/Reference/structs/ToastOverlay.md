**STRUCT**

# `ToastOverlay`

A widget showing toasts above its content.

<picture><source srcset="toast-overlay-dark.png" media="(prefers-color-scheme: dark)"><img src="toast-overlay.png" alt="toast-overlay"></picture>

Much like [class@Gtk.Overlay], `AdwToastOverlay` is a container with a single
main child, on top of which it can display a [class@Toast], overlaid.
Toasts can be shown with [method@ToastOverlay.add_toast].

See [class@Toast] for details.

## CSS nodes

```
toastoverlay
├── [child]
├── toast
┊   ├── widget
┊   │   ├── [label.heading]
│   ╰── [custom title]
├── [button]
╰── button.circular.flat
```

`AdwToastOverlay`'s CSS node is called `toastoverlay`. It contains the child,
as well as zero or more `toast` subnodes.

Each of the `toast` nodes contains a `widget` subnode, optionally a `button`
subnode, and another `button` subnode with `.circular` and `.flat` style
classes.

The `widget` subnode contains a `label` subnode with the `.heading` style
class, or a custom widget provided by the application.

## Accessibility

`AdwToastOverlay` uses the `GTK_ACCESSIBLE_ROLE_TAB_GROUP` role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `child`

The child widget.

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `ToastOverlay`.

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

The child widget.
