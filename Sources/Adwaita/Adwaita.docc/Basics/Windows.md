# Windows

Windows in _Adwaita_ are not actually single windows in the user interface,
but rather instructions on how to create one type of window.

## The simplest case
A single window app is an app having exactly one window, and when this window is closed, the app terminates.
We can add multiple windows to an app as well. 
Whenever the last one disappears, the app terminates.
```swift
@main
struct HelloWorld: App {

    let id = "io.github.david_swift.HelloWorld"
    var app: GTUIApp!

    var scene: Scene {
        Window(id: "content") { _ in
            HeaderBar.empty()
            Text("Hello, world!")
                .padding()
        }
        // Add a second window:
        Window(id: "window-2") { _ in
            HeaderBar.empty()
            Text("Window 2")
                .padding()
        }
    }

}
```

## Showing windows
Every app contains the property ``App/app``. 
You can use this property for running functions that affect the whole app, e.g. quitting the app.
Another use case is showing a window:
```swift
@main
struct HelloWorld: App {

    let id = "io.github.david_swift.HelloWorld"
    var app: GTUIApp!

    var scene: Scene {
        Window(id: "content") { _ in
            HeaderBar.empty()
            Text("Hello, world!")
                .padding()
        }
        Window(id: "control") { _ in
            HeaderBar.empty()
            Button("Show Window") {
                // Show the window with the identifier "content":
                app.showWindow("content")
            }
            .padding()
        }
    }

}
```
"Showing" a window means creating an instance of the window type if there isn't one,
or focusing the window that already exists of that type otherwise.
It should be used for opening windows that cannot be presented more than once
and for moving a window that is already open into the foreground.

## Adding windows
You can call the ``GTUIApp/addWindow(_:parent:)`` function instead of ``GTUIApp/showWindow(_:)``
if you want to add and focus another instance of a window type:
```swift
@main
struct HelloWorld: App {

    let id = "io.github.david_swift.HelloWorld"
    var app: GTUIApp!

    var scene: Scene {
        Window(id: "content") { _ in
            HeaderBar.empty()
            Text("Hello, world!")
                .padding()
        }
        Window(id: "control") { _ in
            HeaderBar.empty()
            Button("Add Window") {
                // Add a new instance of the "content" window type
                app.addWindow("content")
            }
            .padding()
        }
    }

}
```
It can be used to add an overlay window to a certain instance of a window type
by specifying the `parent` parameter, e.g. in the example above:
```swift
Window(id: "control") { window in
    HeaderBar.empty()
    Button("Add Child Window") {
        // Add the new instance as a child window of this window
        app.addWindow("content", parent: window)
    }
    .padding()
}
```

## Customizing the initial number of windows
By default, every window type of the app's scene appears once when the app starts.
It's possible to customize how many windows are being presented at the app's startup:
```swift
@main
struct HelloWorld: App {

    let id = "io.github.david_swift.HelloWorld"
    var app: GTUIApp!

    var scene: Scene {
        // Open no window of the "content" type
        Window(id: "content", open: 0) { _ in
            HeaderBar.empty()
            Text("Hello, world!")
                .padding()
        }
        // Open two windows of the "control" type
        Window(id: "control", open: 2) { _ in
            HeaderBar.empty()
            Button("Show Window") {
                app.addWindow("content")
            }
            .padding()
        }
    }

}
```
