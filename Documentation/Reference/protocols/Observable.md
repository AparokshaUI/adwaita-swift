**PROTOCOL**

# `Observable`

A protocol allowing a class to be observed by a view, window or app.

Views, windows and apps will automatically observe all of its children with an observable type.

```swift
@Observable
class ViewState {

   var boolean = false

}

@View
struct TestView {

    private let state = ViewState()
    
    var view: Body {
        // ...
    }

}
```

## Properties
### `didChange`

This function gets called when a property changes.

A view will automatically add a function to this variable.
