# Creating views

Views are the building blocks of your application. 
A view can be as simple as the ``Text`` widget, or as complex as the whole content of a single window.

## Add views to a window
You can add views to a window:
```swift
import Adwaita

@main
struct HelloWorld: App {

    let id = "io.github.david_swift.HelloWorld"
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

In this example, the widgets ``HeaderBar`` and ``Text`` are used.
`padding` is a view modifier, a function that modifies a view, which adds some padding around the text.

## Create custom views
While directly adding widgets into the ``Window``'s body might work for very simple apps,
it can get messy very quickly.
Create custom views by declaring types that conform to the ``View`` protocol:
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
Whenever you want to modify a property that is stored in the view's structure from within your view,
wrap the property with the ``State`` property wrapper:
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

## Change the state in child views
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

If the child view should be able to modify the state, use the ``Binding`` property wrapper in the child view
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

If you have a more complex type and want to pass a property of the type as a binding,
you can simply access the property on the binding.

```swift
HelloView(text: $complexType.text)
```

Whenever you modify a state property (directly or indirectly through bindings),
the user interface gets automatically updated to reflect that change.

## Save state values between app launches
It's possible to automatically save a value that conforms to `Codable` whenever it changes to a file.
The value in the file is read when the view containing the state value appears for the first time (e.g. when the user launches the app).

Use the following syntax, where `"text"` is a unique identifier.
```swift
@State("text") private var text = "world"
```

You can organize your content by specifying a custom folder path which will be appended to the XDG data home directory.
```swift
@State("text", folder: "io.github.david_swift.HelloWorld/my-view") private var text = "world"
```
