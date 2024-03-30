# Creating widgets

Widgets are special views that do not provide a collection of other views as a content,
but have functions that are called when creating or updating the view.
Normally, a widget manages a GTK or Libadwaita widget using the C API.

## Recreate the Text widget
In this tutorial, we will recreate the ``Text`` widget.
A widget conforms to the ``Widget`` protocol:
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
import CAdw

struct CustomText: Widget {

    var text: String

    public func container(modifiers: [(View) -> View]) -> ViewStorage { }
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) { }

}
```
Import CAdw which exposes the whole C Libadwaita and Gtk API to Swift.

## The `container(modifiers:)` function
This function initializes the widget when the widget appears for the first time.
It expects a ``ViewStorage`` as the return type.
In our case, this function is very simple:
```swift
func container(modifiers: [(View) -> View]) -> ViewStorage {
    .init(gtk_label_new(text)?.opaque())
}
```

## The `update(_:modifiers:updateProperties:)` function
Whenever a state of the app changes, the ``Widget/update(_:modifiers:updateProperties:)`` function of the widget gets called.
You get the view storage that you have previously initialized as a parameter.
Update the storage to reflect the current state of the widget:
```swift
func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
    if updateProperties {
        gtk_label_set_label(storage.pointer, text)
    }
}
```

## Containers
Some widgets act as containers that accept other widgets as children.
In that case, use the ``ViewStorage``'s `content` property for storing their view storages.
In the ``Widget/update(_:modifiers:updateProperties:)`` function, update the children's storages.
Take a look at the code of the container widgets in this library as a reference.
