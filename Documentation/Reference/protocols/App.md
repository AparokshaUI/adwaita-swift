**PROTOCOL**

# `App`

A structure conforming to `App` is the entry point of your app.

```swift
@main
struct Test: App {

    let id = "io.github.AparokshaUI.TestApp"
    var app: GTUIApp!

    var scene: Scene {
        WindowScene()
    }

}
```

## Properties
### `id`

The app's application ID.

### `scene`

The app's windows.

### `app`

The app.

## Methods
### `init()`

An app has to have an `init()` initializer.
