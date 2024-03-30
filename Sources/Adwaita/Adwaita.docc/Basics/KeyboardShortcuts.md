# Keyboard shortcuts

Keyboard shortcuts can be attached to individual windows or whole applications.

## About keyboard shortcuts
Keyboard shortcuts are represented as a `String`.
You can add a single character by adding itself to the string, e.g. `"n"`.
The F keys are written as `"F1"`, `"F2"`, etc.
For character keys, write the lowercase name instead of the symbol, such as `"minus"` instead of `"-"`.

Add modifiers to the shortcut using the following string modifiers:
- `.shift()`
- `.ctrl()`
- `.alt()`
- `.meta()`
- `.super()`
- `.hyper()`

As an example, the following syntax represents the `Ctrl + N` shortcut: `"n".ctrl()`.

## Add shortcuts to a window
Add a keyboard shortcut to an invividual window. It is only available in that window.
```swift
import Adwaita

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
        // Add the shortcut "Ctrl + W" for closing the window
        .keyboardShortcut("w".ctrl()) { window in
            window.close()
        }
    }

}
```

## Add shortcuts to an app
Add a keyboard to an app so that the shortcut is available in every top-level window.
```swift
import Adwaita

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
        // Add the shortcut "Ctrl + Q" for terminating the app
        .appKeyboardShortcut("q".ctrl()) { app in
            app.quit()
        }
    }

}
```

## Create shortcuts from a menu
The most elegant way for adding keyboard shortcuts is in many cases adding them via menus.
Here is an example using a menu button:
```swift
struct TestView: View {

    var app: GTUIApp

    var view: Body {
        Menu(icon: .default(icon: .openMenu), app: app) {
            MenuButton("New Window", window: false) {
                app.addWindow("main")
            }
            // Add a keyboard shortcut to the app.
            .keyboardShortcut("n".ctrl())
        }
    }

}
```
Add the keyboard shortcut to a single window by specifying the `window` parameter in the initializer of `Menu`,
and removing `window: false` in the initializer of `MenuButton`.

## Create shortcuts from a button
It's possible to easily create a keyboard shortcut from a button.
Use `appKeyboardShortcut` instead of `keyboardShortcut` for shortcuts on an application level.
Note that the shortcut gets activated after presenting the view for the first time.
```swift
struct HelloView: View {

    var window: GTUIWindow

    var view: Body {
        Button("New Item") {
            print("New Item")
        }
        // Add a keyboard shortcut to the window "window".
        .keyboardShortcut("n".ctrl().shift(), window: window)
    }

}
```

