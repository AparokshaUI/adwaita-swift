# Hello World

![The "HelloWorld" app][image-1]

This is a beginner tutorial. We will create a simple "Hello, world!" app using _Adwaita_.

## Create the Swift Package
1. Open your terminal client and navigate to a directory you want to create the package in (e.g. `~/Documents/`).
2. Create a new folder for the package using `mkdir HelloWorld`.
3. Enter the newly created folder using `cd HelloWorld`.
4. Run `swift package init --type executable` for creating a new Swift package.
5. Open the Swift package. If you are using GNOME Builder, click on `Select a Folder…` in the view that appears after opening Builder and open the `HelloWorld` folder.

## Add the Dependency
1. Open the `Package.swift` file.
2. Add the following line of code after `name: "HelloWorld",`:
```
dependencies: [.package(url: "https://github.com/david-swift/Adwaita", from: "0.1.1")],
```

## Create the App
1. Navigate to `Sources/main.swift`.
2. An app that uses the _Adwaita_ framework has a structure that conforms to the `App` protocol. The `scene` property returns one or more windows which provide content for display. An `@main` attribute marks it as the entry point of the app.
   Replace `print("Hello, world!")` by your first app:
```swift
import Adwaita

@main
struct HelloWorld: App {

    let id = "io.github.david-swift.HelloWorld"
    var app: GTUIApp!

    var scene: Scene {
        Window(id: "content") { _ in
            Text("Hello, world!")
                .padding()
        }
    }

}
```

## Test the App
1. Run the executable Swift package (in GNOME Builder, press the play button, on the command line, use `swift run`).
   You can see that one important component of a window in GNOME is missing: The header bar.

## Add a Header Bar
1. If you add another view inside of the `Window`'s body, the views get aligned vertically:
```swift
import Adwaita

@main
struct HelloWorld: App {

    let id = "io.github.david-swift.HelloWorld"
    var app: GTUIApp!

    var scene: Scene {
        Window(id: "content") { _ in
            // Add the header bar:
            HeaderBar.empty()
            Text("Hello, world!")
                .padding()
        }
    }

}
```
2. Run the app.
 
[image-1]: ../../Icons/HelloWorld.png
