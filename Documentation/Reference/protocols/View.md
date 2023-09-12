**PROTOCOL**

# `View`

A structure conforming to `View` is referred to as a view.
It can be part of a body.

```swift
struct Test: View {

    var view: Body {
        AnotherView()
    }

}
```

## Properties
### `view`

The view's content.
