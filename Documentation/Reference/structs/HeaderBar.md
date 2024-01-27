**STRUCT**

# `HeaderBar`

A title bar widget.

<picture><source srcset="header-bar-dark.png" media="(prefers-color-scheme: dark)"><img src="header-bar.png" alt="header-bar"></picture>

`AdwHeaderBar` is similar to [class@Gtk.HeaderBar], but provides additional
features compared to it. Refer to `GtkHeaderBar` for details. It is typically
used as a top bar within [class@ToolbarView].

## Navigation View Integration

When placed inside an [class@NavigationPage], `AdwHeaderBar` will display the
page title instead of window title.

When used together with [class@NavigationView] or [class@NavigationSplitView],
it will also display a back button that can be used to go back to the previous
page. The button also has a context menu, allowing to pop multiple pages at
once, potentially across multiple navigation views. In rare scenarios, set
[property@HeaderBar:show-back-button] to `FALSE` to disable the back button
if it's unwanted (e.g. in an extra header bar on the same page).

## Split View Integration

When placed inside `AdwNavigationSplitView` or `AdwOverlaySplitView`,
`AdwHeaderBar` will automatically hide the title buttons other than at the
edges of the window.

## Centering Policy

[property@HeaderBar:centering-policy] allows to enforce strict centering of
the title widget. This can be useful for entries inside [class@Clamp].

## Title Buttons

Unlike `GtkHeaderBar`, `AdwHeaderBar` allows to toggle title button
visibility for each side individually, using the
[property@HeaderBar:show-start-title-buttons] and
[property@HeaderBar:show-end-title-buttons] properties.

## CSS nodes

```
headerbar
╰── windowhandle
╰── box
├── widget
│   ╰── box.start
│       ├── windowcontrols.start
│       ├── widget
│       │   ╰── [button.back]
│       ╰── [other children]
├── widget
│   ╰── [Title Widget]
╰── widget
╰── box.end
├── [other children]
╰── windowcontrols.end
```

`AdwHeaderBar`'s CSS node is called `headerbar`. It contains a `windowhandle`
subnode, which contains a `box` subnode, which contains three `widget`
subnodes at the start, center and end of the header bar. The start and end
subnotes contain a `box` subnode with the `.start` and `.end` style classes
respectively, and the center node contains a node that represents the title.

Each of the boxes contains a `windowcontrols` subnode, see
[class@Gtk.WindowControls] for details, as well as other children.

When [property@HeaderBar:show-back-button] is `TRUE`, the start box also
contains a node with the name `widget` that contains a node with the name
`button` and `.back` style class.

## Accessibility

`AdwHeaderBar` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `decorationLayout`

The decoration layout for buttons.

If this property is not set, the
[property@Gtk.Settings:gtk-decoration-layout] setting is used.

The format of the string is button names, separated by commas. A colon
separates the buttons that should appear at the start from those at the
end. Recognized button names are minimize, maximize, close and icon (the
window icon).

For example, “icon:minimize,maximize,close” specifies an icon at the start,
and minimize, maximize and close buttons at the end.

### `showBackButton`

Whether the header bar can show the back button.

The back button will never be shown unless the header bar is placed inside an
[class@NavigationView]. Usually, there is no reason to set this to `FALSE`.

### `showEndTitleButtons`

Whether to show title buttons at the end of the header bar.

See [property@HeaderBar:show-start-title-buttons] for the other side.

Which buttons are actually shown and where is determined by the
[property@HeaderBar:decoration-layout] property, and by the state of the
window (e.g. a close button will not be shown if the window can't be
closed).

### `showStartTitleButtons`

Whether to show title buttons at the start of the header bar.

See [property@HeaderBar:show-end-title-buttons] for the other side.

Which buttons are actually shown and where is determined by the
[property@HeaderBar:decoration-layout] property, and by the state of the
window (e.g. a close button will not be shown if the window can't be
closed).

### `showTitle`

Whether the title widget should be shown.

### `titleWidget`

The title widget to display.

When set to `NULL`, the header bar will display the title of the window it
is contained in.

To use a different title, use [class@WindowTitle]:

```xml
<object class="AdwHeaderBar"><property name="title-widget"><object class="AdwWindowTitle"><property name="title" translatable="yes">Title</property></object></property></object>
```

### `start`

The body for the widget "start".

### `end`

The body for the widget "end".

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `HeaderBar`.

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

### `decorationLayout(_:)`

The decoration layout for buttons.

If this property is not set, the
[property@Gtk.Settings:gtk-decoration-layout] setting is used.

The format of the string is button names, separated by commas. A colon
separates the buttons that should appear at the start from those at the
end. Recognized button names are minimize, maximize, close and icon (the
window icon).

For example, “icon:minimize,maximize,close” specifies an icon at the start,
and minimize, maximize and close buttons at the end.

### `showBackButton(_:)`

Whether the header bar can show the back button.

The back button will never be shown unless the header bar is placed inside an
[class@NavigationView]. Usually, there is no reason to set this to `FALSE`.

### `showEndTitleButtons(_:)`

Whether to show title buttons at the end of the header bar.

See [property@HeaderBar:show-start-title-buttons] for the other side.

Which buttons are actually shown and where is determined by the
[property@HeaderBar:decoration-layout] property, and by the state of the
window (e.g. a close button will not be shown if the window can't be
closed).

### `showStartTitleButtons(_:)`

Whether to show title buttons at the start of the header bar.

See [property@HeaderBar:show-end-title-buttons] for the other side.

Which buttons are actually shown and where is determined by the
[property@HeaderBar:decoration-layout] property, and by the state of the
window (e.g. a close button will not be shown if the window can't be
closed).

### `showTitle(_:)`

Whether the title widget should be shown.

### `titleWidget(_:)`

The title widget to display.

When set to `NULL`, the header bar will display the title of the window it
is contained in.

To use a different title, use [class@WindowTitle]:

```xml
<object class="AdwHeaderBar"><property name="title-widget"><object class="AdwWindowTitle"><property name="title" translatable="yes">Title</property></object></property></object>
```

### `start(_:)`

Set the body for "start".
- Parameter body: The body.
- Returns: The widget.

### `end(_:)`

Set the body for "end".
- Parameter body: The body.
- Returns: The widget.
