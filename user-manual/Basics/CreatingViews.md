# Creating Views

Views are the building blocks of your application. 
A view can be as simple as the `Text` widget you have seen in the previous tutorial, or as complex as the whole content of a single window.

## Add Views to a Window
You've already seen how to add views to a window:
```swift
import Adwaita

@main
struct HelloWorld: App {

    let id = "io.github.david-swift.HelloWorld"
    var app: GTUIApp!

    var scene: Scene {
        Window(id: "content") { _ in
            // These are the views:
            HeaderBar.empty()
            Text("Hello, world!")
                .padding()
        }
    }

}
```

In this example, the widgets `HeaderBar` and `Text` are used.
`padding` is a view modifier, a function that modifies a view, which adds some padding around the text.

## Create Custom Views
While directly adding widgets into the `Window`'s body might work for simple "Hello World" apps,
it can get very messy very quickly.
You can create custom views by declaring types that conform to the `View` protocol:
```swift
// A custom view named "ContentView":
struct ContentView: View {

    var view: Body {
        HeaderBar.empty()
        Text("Hello, world!")
            .padding()
    }

}
```

## Properties
As every structure in Swift, custom views can have properties:
```swift
struct HelloView: View {

    // The property "text":
    var text: String
    var view: Body {
        Text("Hello, \(text)!")
            .padding()
    }

}
```
This view can be called via `HelloView(text: "world")` in another view.

## State
Whenever you want to modify a property that is stored in the view's structure from your view,
wrap the property with the `@State` property wrapper:
```swift
struct MyView: View {

    // This property can be modified form within the view:
    @State private var text = "world"
    var view: Body {
        Text("Hello, \(text)!")
            .padding()
        Button("Change Text") {
            text = Bool.random() ? "world" : "John"
        }
        .padding(10, .horizontal.add(.bottom))
    }

}
```
In this example, the text property is set whenever you press the "Change Text" button.

## Change the State in Child Views
You can access state properties in child views in the same way as you would access any other property
if the child view cannot modify the state (`HelloView` is defined above):
```swift
struct MyView: View {

    @State private var text = "world"
    var view: Body {
        // "HelloView" can read the "text" property:
        HelloView(text: text)
        Button("Change Text") {
            text = Bool.random() ? "world" : "John"
        }
        .padding(10, .horizontal.add(.bottom))
    }

}
```

If the child view should be able to modify the state, use the `Binding` property wrapper in the child view
and pass the property with a dollar sign (`$`) to that view.
```swift
struct MyView: View {

    @State private var text = "world"
    var view: Body {
        HelloView(text: text)
        // Pass the editable text property to the child view:
        ChangeTextView(text: $text)
    }

}

struct ChangeTextView: View {

    // Accept the editable text property:
    @Binding var text: String
    var view: Body {
        Button("Change Text") {
            // Binding properties can be used the same way as state properties:
            text = Bool.random() ? "world" : "John"
        }
        .padding(10, .horizontal.add(.bottom))
    }

}
```

Whenever you modify a state property (directly or indirectly through bindings),
the user interface gets automatically updated to reflect that change.
