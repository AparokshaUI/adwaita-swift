**STRUCT**

# `PreferencesGroup`

A group of preference rows.

<picture><source srcset="preferences-group-dark.png" media="(prefers-color-scheme: dark)"><img src="preferences-group.png" alt="preferences-group"></picture>

An `AdwPreferencesGroup` represents a group or tightly related preferences,
which in turn are represented by [class@PreferencesRow].

To summarize the role of the preferences it gathers, a group can have both a
title and a description. The title will be used by [class@PreferencesWindow]
to let the user look for a preference.

## AdwPreferencesGroup as GtkBuildable

The `AdwPreferencesGroup` implementation of the [iface@Gtk.Buildable] interface
supports adding [class@PreferencesRow]s to the list by omitting "type". If "type"
is omitted and the widget isn't a [class@PreferencesRow] the child is added to
a box below the list.

When the "type" attribute of a child is `header-suffix`, the child
is set as the suffix on the end of the title and description.

## CSS nodes

`AdwPreferencesGroup` has a single CSS node with name `preferencesgroup`.

## Accessibility

`AdwPreferencesGroup` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `description`

The description for this group of preferences.

### `headerSuffix`

The header suffix widget.

Displayed above the list, next to the title and description.

Suffixes are commonly used to show a button or a spinner for the whole
group.

### `title`

The title for this group of preferences.

### `child`

The body for the widget "child".

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `PreferencesGroup`.

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

### `description(_:)`

The description for this group of preferences.

### `headerSuffix(_:)`

The header suffix widget.

Displayed above the list, next to the title and description.

Suffixes are commonly used to show a button or a spinner for the whole
group.

### `title(_:)`

The title for this group of preferences.

### `child(_:)`

Set the body for "child".
- Parameter body: The body.
- Returns: The widget.
