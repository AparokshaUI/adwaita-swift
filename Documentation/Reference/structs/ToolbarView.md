**STRUCT**

# `ToolbarView`

A widget containing a page, as well as top and/or bottom bars.

<picture><source srcset="toolbar-view-dark.png" media="(prefers-color-scheme: dark)"><img src="toolbar-view.png" alt="toolbar-view"></picture>

`AdwToolbarView` has a single content widget and one or multiple top and
bottom bars, shown at the top and bottom sides respectively.

Example of an `AdwToolbarView` UI definition:
```xml
<object class="AdwToolbarView"><child type="top"><object class="AdwHeaderBar"/></child><property name="content"><object class="AdwPreferencesPage"><!-- ... --></object></property></object>
```

The following kinds of top and bottom bars are supported:

- [class@HeaderBar]
- [class@TabBar]
- [class@ViewSwitcherBar]
- [class@Gtk.ActionBar]
- [class@Gtk.HeaderBar]
- [class@Gtk.PopoverMenuBar]
- [class@Gtk.SearchBar]
- Any [class@Gtk.Box] or a similar widget with the
[`.toolbar`](style-classes.html#toolbars) style class

By default, top and bottom bars are flat and scrolling content has a subtle
undershoot shadow, same as when using the
[`.undershoot-top`](style-classes.html#undershot-indicators) and
[`.undershoot-bottom`](style-classes.html#undershot-indicators) style
classes. This works well in most cases, e.g. with [class@StatusPage] or
[class@PreferencesPage], where the background at the top and bottom parts of
the page is uniform. Additionally, windows with sidebars should always use
this style.

[property@ToolbarView:top-bar-style] and
[property@ToolbarView:bottom-bar-style] properties can be used add an opaque
background and a persistent shadow to top and bottom bars, this can be useful
for content such as [utility panes](https://developer.gnome.org/hig/patterns/containers/utility-panes.html),
where some elements are adjacent to the top/bottom bars, or [class@TabView],
where each page can have a different background.

<picture style="min-width: 33%; display: inline-block;"><source srcset="toolbar-view-flat-1-dark.png" media="(prefers-color-scheme: dark)"><img src="toolbar-view-flat-1.png" alt="toolbar-view-flat-1"></picture><picture style="min-width: 33%; display: inline-block;"><source srcset="toolbar-view-flat-2-dark.png" media="(prefers-color-scheme: dark)"><img src="toolbar-view-flat-2.png" alt="toolbar-view-flat-2"></picture><picture style="min-width: 33%; display: inline-block;"><source srcset="toolbar-view-raised-dark.png" media="(prefers-color-scheme: dark)"><img src="toolbar-view-raised.png" alt="toolbar-view-raised"></picture>

`AdwToolbarView` ensures the top and bottom bars have consistent backdrop
styles and vertical spacing. For comparison:

<picture style="min-width: 40%; display: inline-block;"><source srcset="toolbar-view-spacing-dark.png" media="(prefers-color-scheme: dark)"><img src="toolbar-view-spacing.png" alt="toolbar-view-spacing"></picture><picture style="min-width: 40%; display: inline-block;"><source srcset="toolbar-view-spacing-box-dark.png" media="(prefers-color-scheme: dark)"><img src="toolbar-view-spacing-box.png" alt="toolbar-view-spacing-box"></picture>

Any top and bottom bars can also be dragged to move the window, equivalent
to putting them into a [class@Gtk.WindowHandle].

Content is typically place between top and bottom bars, but can also extend
behind them. This is controlled with the
[property@ToolbarView:extend-content-to-top-edge] and
[property@ToolbarView:extend-content-to-bottom-edge] properties.

Top and bottom bars can be hidden and revealed with an animation using the
[property@ToolbarView:reveal-top-bars] and
[property@ToolbarView:reveal-bottom-bars] properties.

## `AdwToolbarView` as `GtkBuildable`

The `AdwToolbarView` implementation of the [iface@Gtk.Buildable] interface
supports adding a top bar by specifying “top” as the “type” attribute of a
`<child>` element, or adding a bottom bar by specifying “bottom”.

## Accessibility

`AdwToolbarView` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `bottomBarHeight`

The current bottom bar height.

Bottom bar height does change depending on
[property@ToolbarView:reveal-bottom-bars], including during the transition.

See [property@ToolbarView:top-bar-height].

### `content`

The content widget.

### `extendContentToBottomEdge`

Whether the content widget can extend behind bottom bars.

This can be used in combination with
[property@ToolbarView:reveal-bottom-bars] to show and hide toolbars in
fullscreen.

See [property@ToolbarView:extend-content-to-top-edge].

### `extendContentToTopEdge`

Whether the content widget can extend behind top bars.

This can be used in combination with [property@ToolbarView:reveal-top-bars]
to show and hide toolbars in fullscreen.

See [property@ToolbarView:extend-content-to-bottom-edge].

### `revealBottomBars`

Whether bottom bars are visible.

The transition will be animated.

This can be used in combination with
[property@ToolbarView:extend-content-to-bottom-edge] to show and hide
toolbars in fullscreen.

See [property@ToolbarView:reveal-top-bars].

### `revealTopBars`

Whether top bars are revealed.

The transition will be animated.

This can be used in combination with
[property@ToolbarView:extend-content-to-top-edge] to show and hide toolbars
in fullscreen.

See [property@ToolbarView:reveal-bottom-bars].

### `topBarHeight`

The current top bar height.

Top bar height does change depending [property@ToolbarView:reveal-top-bars],
including during the transition.

See [property@ToolbarView:bottom-bar-height].

### `bottom`

The body for the widget "bottom".

### `top`

The body for the widget "top".

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `ToolbarView`.

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

### `bottomBarHeight(_:)`

The current bottom bar height.

Bottom bar height does change depending on
[property@ToolbarView:reveal-bottom-bars], including during the transition.

See [property@ToolbarView:top-bar-height].

### `content(_:)`

The content widget.

### `extendContentToBottomEdge(_:)`

Whether the content widget can extend behind bottom bars.

This can be used in combination with
[property@ToolbarView:reveal-bottom-bars] to show and hide toolbars in
fullscreen.

See [property@ToolbarView:extend-content-to-top-edge].

### `extendContentToTopEdge(_:)`

Whether the content widget can extend behind top bars.

This can be used in combination with [property@ToolbarView:reveal-top-bars]
to show and hide toolbars in fullscreen.

See [property@ToolbarView:extend-content-to-bottom-edge].

### `revealBottomBars(_:)`

Whether bottom bars are visible.

The transition will be animated.

This can be used in combination with
[property@ToolbarView:extend-content-to-bottom-edge] to show and hide
toolbars in fullscreen.

See [property@ToolbarView:reveal-top-bars].

### `revealTopBars(_:)`

Whether top bars are revealed.

The transition will be animated.

This can be used in combination with
[property@ToolbarView:extend-content-to-top-edge] to show and hide toolbars
in fullscreen.

See [property@ToolbarView:reveal-bottom-bars].

### `topBarHeight(_:)`

The current top bar height.

Top bar height does change depending [property@ToolbarView:reveal-top-bars],
including during the transition.

See [property@ToolbarView:bottom-bar-height].

### `bottom(_:)`

Set the body for "bottom".
- Parameter body: The body.
- Returns: The widget.

### `top(_:)`

Set the body for "top".
- Parameter body: The body.
- Returns: The widget.
