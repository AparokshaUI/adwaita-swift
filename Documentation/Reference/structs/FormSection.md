**STRUCT**

# `FormSection`

A section usually groups forms.

## Properties
### `title`

The title.

### `content`

The content.

### `description`

The description.

### `suffix`

The suffix.

### `suffixID`

The identifier for the suffix content.

## Methods
### `init(_:content:)`

Initialize a form section.
- Parameters:
    - title: The title.
    - content: The content, usually one or more forms.

### `update(_:modifiers:)`

Update a view storage.
- Parameters:
    - storage: The view storage.
    - modifiers: Modify views before being updated.

### `container(modifiers:)`

Get a view storage.
- Parameter modifiers: Modify views before being updated.
- Returns: The view storage.

### `update(group:)`

Update the form section.
- Parameter group: The form section.

### `description(_:)`

Set the form section's description.
- Parameter description: The description.
- Returns: The form section.

### `suffix(_:)`

Set the form section's suffix view.
- Parameter suffix: The suffix.
- Returns: The form section.
