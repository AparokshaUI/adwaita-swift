**ENUM**

# `ViewBuilder`

The ``ViewBuilder`` is a result builder for views.

## Methods
### `buildBlock(_:)`

Build combined results from statement blocks.
- Parameter components: The components.
- Returns: The components in a component.

### `buildExpression(_:)`

Translate an element into a ``ViewBuilder.Component``.
- Parameter element: The element to translate.
- Returns: A component created from the element.

### `buildExpression(_:)`

Translate an array of elements into a ``ViewBuilder.Component``.
- Parameter elements: The elements to translate.
- Returns: A component created from the element.

### `buildExpression(_:)`

Fetch a component.
- Parameter component: A component.
- Returns: The component.

### `buildOptional(_:)`

Enables support for `if` statements without an `else`.
- Parameter component: An optional component.
- Returns: A nonoptional component.

### `buildEither(first:)`

Enables support for `if`-`else` and `switch` statements.
- Parameter component: A component.
- Returns: The component.

### `buildEither(second:)`

Enables support for `if`-`else` and `switch` statements.
- Parameter component: A component.
- Returns: The component.

### `buildFinalResult(_:)`

Convert a component to an array of elements.
- Parameter component: The component to convert.
- Returns: The generated array of elements.
