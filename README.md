<p align="center">
  <img width="256" alt="Adwaita Icon" src="Icons/AdwaitaIcon.png">
  <h1 align="center">Adwaita</h1>
</p>

<p align="center">
  <a href="https://david-swift.gitbook.io/adwaita/">
  User Manual
  </a>
  ·
  <a href="https://github.com/david-swift/Adwaita">
  GitHub
  </a>
  ·
  <a href="Documentation/Reference/README.md">
  Contributor Docs
  </a>
</p>

_Adwaita_ is a framework for creating user interfaces for GNOME with an API similar to SwiftUI.

The following code:

```swift
struct Example: View {

    @State private var count = 0

    var view: Body {
        HeaderBar.start {
            Button(icon: .default(icon: .goPrevious)) {
                count -= 1
            }
            Button(icon: .default(icon: .goNext)) {
                count += 1
            }
        }
        Text("\(count)")
            .padding(50)
    }

}
```

Creates a simple counter view:

![Counter Example][image-1]

## Table of Contents

- [Goals][1]
- [Widgets][2]
- [Installation][3]
- [Usage][4]
- [Thanks][5]

## Goals

_Adwaita_’s main goal is to provide an easy-to-use interface for creating GNOME apps. The back end should stay as simple as possible, while not limiting the possibilities there are with [Libadwaita][6] and [GTK][7].

If you want to use _Adwaita_ in a project, but there are widgets missing, open an [issue on GitHub][8].

## Widgets

| Name       | Description                                                       | Widget       |
| ---------- | ----------------------------------------------------------------- | ------------ |
| Button     | A widget that triggers a function when being clicked.             | GtkButton    |
| EitherView | A widget that displays one of its child views based on a boolean. | GtkStack     |
| HeaderBar  | A widget for creating custom title bars for windows.              | GtkHeaderBar |
| Text       | A widget for displaying a small amount of text.                   | GtkLabel     |
| VStack     | A widget which arranges child widgets into a single column.       | GtkBox       |

### View Modifiers

| Syntax                       | Description                                                                            |
| ---------------------------- | -------------------------------------------------------------------------------------- |
| `inspect(_:)`                | Edit the underlying [GTUI][9] widget.                                                  |
| `padding(_:_:)`              | Add empty space around a view.                                                         |
| `hexpand(_:)`                | Enable or disable the horizontal expansion of a view.                                  |
| `vexpand(_:)`                | Enable or disable the vertical expansion of a view.                                    |
| `frame(minWidth:minHeight:)` | Set the view’s minimal width or height.                                                |
| `frame(maxSize:)`            | Set the view’s maximal size.                                                           |
| `transition(_:)`             | Assign a transition with the view that is used if it is a direct child of a HeaderBar. |
| `onUpdate(_:)`               | Run a function every time a view gets updated.                                         |

## Installation
### Dependencies
If you are using a Linux distribution, install `libadwaita-devel` or `libadwaita` (or something similar, based on the package manager) as well as `gtk4-devel`, `gtk4` or similar.

On macOS, follow these steps:
1. Install [Homebrew][10].
2. Install Libadwaita (and thereby GTK 4):
```
brew install libadwaita
```

### Swift Package
1. Open your Swift package in GNOME Builder, Xcode, or any other IDE.
2. Open the `Package.swift` file.
3. Into the `Package` initializer, under `dependencies`, paste:
```swift
.package(url: "https://github.com/david-swift/Adwaita", from: "0.1.0")   
```

## Usage

* [Getting Started][11]

### Basics

* [Creating Views][12]

## Thanks

### Dependencies
- [SwiftGui][13] licensed under the [GPL-3.0 license][14]

### Other Thanks
- The [contributors][15]
- [SwiftLint][16] for checking whether code style conventions are violated
- The programming language [Swift][17]
- [SourceDocs][18] used for generating the [docs][19]

[1]:	#Goals
[2]:	#Widgets
[3]:	#Installation
[4]:	#Usage
[5]:	#Thanks
[6]:	https://gnome.pages.gitlab.gnome.org/libadwaita/doc/1-latest/index.html
[7]:	https://docs.gtk.org/gtk4/
[8]:	https://github.com/david-swift/Adwaita/issues
[9]:	https://github.com/JCWasmx86/SwiftGui
[10]:	https://brew.sh
[11]:	user-manual/GettingStarted.md
[12]:	user-manual/Basics/CreatingViews.md
[13]:	https://github.com/JCWasmx86/SwiftGui
[14]:	https://github.com/JCWasmx86/SwiftGui/blob/main/COPYING
[15]:	Contributors.md
[16]:	https://github.com/realm/SwiftLint
[17]:	https://github.com/apple/swift
[18]:	https://github.com/SourceDocs/SourceDocs
[19]:	Documentation/Reference/README.md

[image-1]: Icons/Screenshot.png
