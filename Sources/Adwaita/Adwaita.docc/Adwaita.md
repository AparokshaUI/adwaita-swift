# ``Adwaita``

_Adwaita for Swift_ is a framework for creating user interfaces for GNOME with an API similar to SwiftUI.

## Overview

Write user interfaces in a declarative way.

As an example, the following code defines a _view_ (more information: ``View``).

```swift
struct Counter: View {

    @State private var count = 0

    var view: Body {
        HStack {
            Button(icon: .default(icon: .goPrevious)) {
                count -= 1
            }
            Text("\(count)")
                .style("title-1")
                .frame(minWidth: 100)
            Button(icon: .default(icon: .goNext)) {
                count += 1
            }
        }
    }

}
```

A view can be implemented in different ways, the following screenshot showing an example.

![Screenshot of the counter app](Counter.png)

## Goals

_Adwaita for Swift_'s main goal is to provide an easy-to-use interface for creating apps for the GNOME ecosystem.
An article about the project's motivation is available on the [website of the Swift programming language](https://www.swift.org/blog/adwaita-swift/).

## Installation

### Dependencies

#### Flatpak

It is recommended to develop apps inside of a Flatpak.
That way, you don't have to install Swift or any of the dependencies on your system, and you always have access to the latest versions.
Take a look at the [template repository](https://github.com/AparokshaUI/AdwaitaTemplate).
This works on Linux only.

#### Directly on system

You can also run your apps directly on the system.

If you are using a Linux distribution, install `libadwaita-devel` or `libadwaita` (or something similar, based on the package manager) as well as `gtk4-devel`, `gtk4` or similar.

On macOS, follow these steps:
1. Install [Homebrew](https://brew.sh).
2. Install Libadwaita (and thereby GTK 4):
```
brew install libadwaita
```

### Swift package
1. Open your Swift package in GNOME Builder, Xcode, or any other IDE.
2. Open the `Package.swift` file.
3. Into the `Package` initializer, under `dependencies`, paste:
```swift
.package(url: "https://github.com/AparokshaUI/Adwaita", from: "0.1.0")   
```

## Template repository

It is recommended to develop apps on Linux inside a Flatpak.
Find more information in the [template repository](https://github.com/AparokshaUI/AdwaitaTemplate).

## Topics

### Tutorials

- <doc:Table-of-Contents>

### Basics

- <doc:CreatingViews>
- <doc:Windows>
- <doc:KeyboardShortcuts>

### Advanced

- <doc:CreatingWidgets>
- <doc:PublishingApps>
