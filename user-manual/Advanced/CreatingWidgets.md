# Creating Widgets

Widgets are special views that do not provide a collection of other views as a content,
but have functions that are called when creating or updating the view.
Normally, a widget manages a GTK or Libadwaita widget using [SwiftGui][1].

## Recreate the `Text` widget
In this tutorial, we will recreate the text widget.
A widget conforms to the `Widget` protocol:
```swift
struct CustomText: Widget { }
```
You can add properties to the widget:
```swift
struct CustomText: Widget {

    var text: String

}
```
This widget can be called in a view body using `CustomText(text: "Hello, world!")`.
Now, add the two functions required by the protocol:
```swift
struct CustomText: Widget {

    var text: String

    public func container() -> ViewStorage { }
    public func update(_ storage: ViewStorage) { }

}
```

## The `container()` Function
This function initializes the widget when the widget appears for the first time.
It expects a `ViewStorage` as the return type.
In our case, this function is very simple:
```swift
func container() -> ViewStorage {
    .init(MarkupLabel(self.text))
}
```
`MarkupLabel` is defined in [SwiftGui][1].

## The `update(_:)` Function
Whenever a state of the app changes, the `update(_:)` function of the widget gets called.
You get the view storage that you have previously initialized as a parameter.
Update the storage to reflect the current state of the widget:
```swift
func update(_ storage: ViewStorage) {
    if let label = storage.view as? MarkupLabel {
        label.setText(text)
    }
}
```

## Containers
Some widgets act as containers that accept other widgets as children.
In that case, use the `ViewStorage`'s `content` property for storing their view storages.
In the `update(_:)` function, update the children's storages.
An example showcasing how to implement containers is the [VStack][2].

[1]:	https://github.com/JCWasmx86/SwiftGui
[2]:    ../../Sources/Adwaita/View/VStack.swift
