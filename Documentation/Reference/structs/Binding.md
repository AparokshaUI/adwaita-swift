**STRUCT**

# `Binding`

A property wrapper for a property of a view that binds the property of the parent view.

```swift
struct Grandparent: View {

    @State private var state = false

    var view: Body {
        Parent(value: $state)
    }
}

struct Parent: View {

    @Binding var value: Bool

    var view: Body {
        Child(value: $value)
    }

}

struct Child: View {

    @Binding var value: Bool

    var view: Body {
        // ...
    }

}
```

## Properties
### `wrappedValue`

The value.

### `projectedValue`

Get the value as a binding using the `$` prefix.

### `getValue`

The closure for getting the value.

### `setValue`

The closure for settings the value.

## Methods
### `init(get:set:)`

Initialize a property that is bound from a parent view.
- Parameters:
  - get: The closure for getting the value.
  - set: The closure for setting the value.

### `constant(_:)`

Initialize a property that does not react to changes in the child view.
- Parameters:
    - value: The constant value.
- Returns: The binding.
