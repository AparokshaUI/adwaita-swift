# Windows

![Multiple windows in an app built with _Adwaita_][image-1]

Windows in _Adwaita_ are not actually single windows in the user interface,
but rather instructions on how to create one type of window.

## The Simplest Case
In the "HelloWorld" app, we have created a single window app.
Whenever that window was closed using the "x" button, the app terminated.
We can add multiple windows to an app. 
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

## Showing Windows
Every app contains the property `app`. 
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
or focusing the window that already exists of that type.
It should be used for opening windows that cannot be presented more than once
and for moving a window that is already open into the foreground.

## Adding Windows
You can call the `addWindow(_:parent:)` function instead of the `showWindow(_:)`
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

## Customizing the Initial Number of Windows
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

## Add Modal Windows
Modal windows are windows that attach to another window.
Currently, it makes only sense to attach modal windows to windows that don't exist more than once.
```swift
@main
struct HelloWorld: App {

    let id = "io.github.david_swift.HelloWorld"
    var app: GTUIApp!

    var scene: Scene {
        Window(id: "content") { _ in
            // ...
        }
        // Add modal windows
        .overlay {
            Window(id: "overlay") { _ in
                // ...
            }
        }
    }

}
```

[image-1]: ../../Icons/TwoWindows.png
