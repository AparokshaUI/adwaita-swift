**STRUCT**

# `PreferencesPage`

A page from [class@PreferencesWindow].

<picture><source srcset="preferences-page-dark.png" media="(prefers-color-scheme: dark)"><img src="preferences-page.png" alt="preferences-page"></picture>

The `AdwPreferencesPage` widget gathers preferences groups into a single page
of a preferences window.

## CSS nodes

`AdwPreferencesPage` has a single CSS node with name `preferencespage`.

## Accessibility

`AdwPreferencesPage` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `description`

The description to be displayed at the top of the page.

### `iconName`

The icon name for this page.

### `name`

The name of this page.

### `title`

The title for this page.

### `useUnderline`

Whether an embedded underline in the title indicates a mnemonic.

### `child`

The body for the widget "child".

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `PreferencesPage`.

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

The description to be displayed at the top of the page.

### `iconName(_:)`

The icon name for this page.

### `name(_:)`

The name of this page.

### `title(_:)`

The title for this page.

### `useUnderline(_:)`

Whether an embedded underline in the title indicates a mnemonic.

### `child(_:)`

Set the body for "child".
- Parameter body: The body.
- Returns: The widget.
