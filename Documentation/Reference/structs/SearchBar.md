**STRUCT**

# `SearchBar`

`GtkSearchBar` is a container made to have a search entry.

![An example GtkSearchBar](search-bar.png)

It can also contain additional widgets, such as drop-down menus,
or buttons.  The search bar would appear when a search is started
through typing on the keyboard, or the application’s search mode
is toggled on.

For keyboard presses to start a search, the search bar must be told
of a widget to capture key events from through
[method@Gtk.SearchBar.set_key_capture_widget]. This widget will
typically be the top-level window, or a parent container of the
search bar. Common shortcuts such as Ctrl+F should be handled as an
application action, or through the menu items.

You will also need to tell the search bar about which entry you
are using as your search entry using [method@Gtk.SearchBar.connect_entry].

## Creating a search bar

The following example shows you how to create a more complex search
entry.

[A simple example](https://gitlab.gnome.org/GNOME/gtk/tree/main/examples/search-bar.c)

# CSS nodes

```
searchbar
╰── revealer
╰── box
├── [child]
╰── [button.close]
```

`GtkSearchBar` has a main CSS node with name searchbar. It has a child
node with name revealer that contains a node with name box. The box node
contains both the CSS node of the child widget as well as an optional button
node which gets the .close style class applied.

# Accessibility

`GtkSearchBar` uses the %GTK_ACCESSIBLE_ROLE_SEARCH role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `accessibleRole`

The accessible role of the given `GtkAccessible` implementation.

The accessible role cannot be changed once set.

### `child`

The child widget.

### `keyCaptureWidget`

The key capture widget.

### `searchModeEnabled`

Whether the search mode is on and the search bar shown.

### `showCloseButton`

Whether to show the close button in the search bar.

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `SearchBar`.

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

### `accessibleRole(_:)`

The accessible role of the given `GtkAccessible` implementation.

The accessible role cannot be changed once set.

### `child(_:)`

The child widget.

### `keyCaptureWidget(_:)`

The key capture widget.

### `searchModeEnabled(_:)`

Whether the search mode is on and the search bar shown.

### `showCloseButton(_:)`

Whether to show the close button in the search bar.
