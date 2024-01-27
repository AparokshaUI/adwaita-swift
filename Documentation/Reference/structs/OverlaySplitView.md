**STRUCT**

# `OverlaySplitView`

A widget presenting sidebar and content side by side or as an overlay.

<picture><source srcset="overlay-split-view-dark.png" media="(prefers-color-scheme: dark)"><img src="overlay-split-view.png" alt="overlay-split-view"></picture><picture><source srcset="overlay-split-view-collapsed-dark.png" media="(prefers-color-scheme: dark)"><img src="overlay-split-view-collapsed.png" alt="overlay-split-view-collapsed"></picture>

`AdwOverlaySplitView` has two children: sidebar and content, and displays
them side by side.

When [property@OverlaySplitView:collapsed] is set to `TRUE`, the sidebar is
instead shown as an overlay above the content widget.

The sidebar can be hidden or shown using the
[property@OverlaySplitView:show-sidebar] property.

Sidebar can be displayed before or after the content, this can be controlled
with the [property@OverlaySplitView:sidebar-position] property.

Collapsing the split view automatically hides the sidebar widget, and
uncollapsing it shows the sidebar. If this behavior is not desired, the
[property@OverlaySplitView:pin-sidebar] property can be used to override it.

`AdwOverlaySplitView` supports an edge swipe gesture for showing the sidebar,
and a swipe from the sidebar for hiding it. Gestures are only supported on
touchscreen, but not touchpad. Gestures can be controlled with the
[property@OverlaySplitView:enable-show-gesture] and
[property@OverlaySplitView:enable-hide-gesture] properties.

See also [class@NavigationSplitView].

`AdwOverlaySplitView` is typically used together with an [class@Breakpoint]
setting the `collapsed` property to `TRUE` on small widths, as follows:

```xml
<object class="AdwWindow"><property name="width-request">360</property><property name="height-request">200</property><property name="default-width">800</property><property name="default-height">800</property><child><object class="AdwBreakpoint"><condition>max-width: 400sp</condition><setter object="split_view" property="collapsed">True</setter></object></child><property name="content"><object class="AdwOverlaySplitView" id="split_view"><property name="sidebar"><!-- ... --></property><property name="content"><!-- ... --></property></object></property></object>
```

`AdwOverlaySplitView` is often used for implementing the
[utility pane](https://developer.gnome.org/hig/patterns/containers/utility-panes.html)
pattern.

## Sizing

When not collapsed, `AdwOverlaySplitView` changes the sidebar width
depending on its own width.

If possible, it tries to allocate a fraction of the total width, controlled
with the [property@OverlaySplitView:sidebar-width-fraction] property.

The sidebar also has minimum and maximum sizes, controlled with the
[property@OverlaySplitView:min-sidebar-width] and
[property@OverlaySplitView:max-sidebar-width] properties.

The minimum and maximum sizes are using the length unit specified with the
[property@OverlaySplitView:sidebar-width-unit].

By default, sidebar is using 25% of the total width, with 180sp as the
minimum size and 280sp as the maximum size.

When collapsed, the preferred width fraction is ignored and the sidebar uses
[property@OverlaySplitView:max-sidebar-width] when possible.

## Header Bar Integration

When used inside `AdwOverlaySplitView`, [class@HeaderBar] will automatically
hide the window buttons in the middle.

## `AdwOverlaySplitView` as `GtkBuildable`

The `AdwOverlaySplitView` implementation of the [iface@Gtk.Buildable]
interface supports setting the sidebar widget by specifying “sidebar” as the
“type” attribute of a `<child>` element, Specifying “content” child type or
omitting it results in setting the content widget.

## CSS nodes

`AdwOverlaySplitView` has a single CSS node with the name
`overlay-split-view`.

It contains two nodes with the name `widget`, containing the sidebar and
content children.

When not collapsed, they have the `.sidebar-view` and `.content-view` style
classes respectively.

```
overlay-split-view
├── widget.sidebar-pane
│   ╰── [sidebar child]
╰── widget.content-pane
╰── [content child]
```

When collapsed, the one containing the sidebar child has the `.background`
style class and the other one has no style classes.

```
overlay-split-view
├── widget.background
│   ╰── [sidebar child]
╰── widget
╰── [content child]
```

## Accessibility

`AdwOverlaySplitView` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `collapsed`

Whether the split view is collapsed.

When collapsed, the sidebar widget is presented as an overlay above the
content widget, otherwise they are displayed side by side.

### `content`

The content widget.

### `enableHideGesture`

Whether the sidebar can be closed with a swipe gesture.

Only touchscreen swipes are supported.

### `enableShowGesture`

Whether the sidebar can be opened with an edge swipe gesture.

Only touchscreen swipes are supported.

### `maxSidebarWidth`

The maximum sidebar width.

Maximum width is affected by
[property@OverlaySplitView:sidebar-width-unit].

The sidebar widget can still be allocated with larger width if its own
minimum width exceeds it.

### `minSidebarWidth`

The minimum sidebar width.

Minimum width is affected by
[property@OverlaySplitView:sidebar-width-unit].

The sidebar widget can still be allocated with larger width if its own
minimum width exceeds it.

### `pinSidebar`

Whether the sidebar widget is pinned.

By default, collapsing @self automatically hides the sidebar widget, and
uncollapsing it shows the sidebar. If set to `TRUE`, sidebar visibility
never changes on its own.

### `showSidebar`

Whether the sidebar widget is shown.

### `sidebar`

The sidebar widget.

### `sidebarWidthFraction`

The preferred sidebar width as a fraction of the total width.

The preferred width is additionally limited by
[property@OverlaySplitView:min-sidebar-width] and
[property@OverlaySplitView:max-sidebar-width].

The sidebar widget can be allocated with larger width if its own minimum
width exceeds the preferred width.

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `OverlaySplitView`.

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

### `collapsed(_:)`

Whether the split view is collapsed.

When collapsed, the sidebar widget is presented as an overlay above the
content widget, otherwise they are displayed side by side.

### `content(_:)`

The content widget.

### `enableHideGesture(_:)`

Whether the sidebar can be closed with a swipe gesture.

Only touchscreen swipes are supported.

### `enableShowGesture(_:)`

Whether the sidebar can be opened with an edge swipe gesture.

Only touchscreen swipes are supported.

### `maxSidebarWidth(_:)`

The maximum sidebar width.

Maximum width is affected by
[property@OverlaySplitView:sidebar-width-unit].

The sidebar widget can still be allocated with larger width if its own
minimum width exceeds it.

### `minSidebarWidth(_:)`

The minimum sidebar width.

Minimum width is affected by
[property@OverlaySplitView:sidebar-width-unit].

The sidebar widget can still be allocated with larger width if its own
minimum width exceeds it.

### `pinSidebar(_:)`

Whether the sidebar widget is pinned.

By default, collapsing @self automatically hides the sidebar widget, and
uncollapsing it shows the sidebar. If set to `TRUE`, sidebar visibility
never changes on its own.

### `showSidebar(_:)`

Whether the sidebar widget is shown.

### `sidebar(_:)`

The sidebar widget.

### `sidebarWidthFraction(_:)`

The preferred sidebar width as a fraction of the total width.

The preferred width is additionally limited by
[property@OverlaySplitView:min-sidebar-width] and
[property@OverlaySplitView:max-sidebar-width].

The sidebar widget can be allocated with larger width if its own minimum
width exceeds the preferred width.
