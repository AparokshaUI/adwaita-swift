**STRUCT**

# `ProgressBar`

`GtkProgressBar` is typically used to display the progress of a long
running operation.

It provides a visual clue that processing is underway. `GtkProgressBar`
can be used in two different modes: percentage mode and activity mode.

![An example GtkProgressBar](progressbar.png)

When an application can determine how much work needs to take place
(e.g. read a fixed number of bytes from a file) and can monitor its
progress, it can use the `GtkProgressBar` in percentage mode and the
user sees a growing bar indicating the percentage of the work that
has been completed. In this mode, the application is required to call
[method@Gtk.ProgressBar.set_fraction] periodically to update the progress bar.

When an application has no accurate way of knowing the amount of work
to do, it can use the `GtkProgressBar` in activity mode, which shows
activity by a block moving back and forth within the progress area. In
this mode, the application is required to call [method@Gtk.ProgressBar.pulse]
periodically to update the progress bar.

There is quite a bit of flexibility provided to control the appearance
of the `GtkProgressBar`. Functions are provided to control the orientation
of the bar, optional text can be displayed along with the bar, and the
step size used in activity mode can be set.

# CSS nodes

```
progressbar[.osd]
├── [text]
╰── trough[.empty][.full]
╰── progress[.pulse]
```

`GtkProgressBar` has a main CSS node with name progressbar and subnodes with
names text and trough, of which the latter has a subnode named progress. The
text subnode is only present if text is shown. The progress subnode has the
style class .pulse when in activity mode. It gets the style classes .left,
.right, .top or .bottom added when the progress 'touches' the corresponding
end of the GtkProgressBar. The .osd class on the progressbar node is for use
in overlays like the one Epiphany has for page loading progress.

# Accessibility

`GtkProgressBar` uses the %GTK_ACCESSIBLE_ROLE_PROGRESS_BAR role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `fraction`

The fraction of total work that has been completed.

### `inverted`

Invert the direction in which the progress bar grows.

### `pulseStep`

The fraction of total progress to move the bounding block when pulsed.

### `showText`

Sets whether the progress bar will show a text in addition
to the bar itself.

The shown text is either the value of the [property@Gtk.ProgressBar:text]
property or, if that is %NULL, the [property@Gtk.ProgressBar:fraction]
value, as a percentage.

To make a progress bar that is styled and sized suitably for showing text
(even if the actual text is blank), set [property@Gtk.ProgressBar:show-text]
to %TRUE and [property@Gtk.ProgressBar:text] to the empty string (not %NULL).

### `text`

Text to be displayed in the progress bar.

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `ProgressBar`.

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

### `fraction(_:)`

The fraction of total work that has been completed.

### `inverted(_:)`

Invert the direction in which the progress bar grows.

### `pulseStep(_:)`

The fraction of total progress to move the bounding block when pulsed.

### `showText(_:)`

Sets whether the progress bar will show a text in addition
to the bar itself.

The shown text is either the value of the [property@Gtk.ProgressBar:text]
property or, if that is %NULL, the [property@Gtk.ProgressBar:fraction]
value, as a percentage.

To make a progress bar that is styled and sized suitably for showing text
(even if the actual text is blank), set [property@Gtk.ProgressBar:show-text]
to %TRUE and [property@Gtk.ProgressBar:text] to the empty string (not %NULL).

### `text(_:)`

Text to be displayed in the progress bar.
