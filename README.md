<p align="center">
  <img width="256" alt="Adwaita Icon" src="Icons/AdwaitaIcon.png">
  <h1 align="center">Adwaita for Swift</h1>
</p>

<p align="center">
  <a href="https://aparokshaui.github.io/adwaita-swift/">
  Documentation
  </a>
  ·
  <a href="https://github.com/AparokshaUI/Adwaita">
  GitHub
  </a>
</p>

_Adwaita_ is a framework for creating user interfaces for GNOME with an API similar to SwiftUI.

The following code:

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

Describes a simple counter view:

![Counter Example][image-1]

More examples are available in the [demo app][1].

## Table of Contents

- [Goals][2]
- [Widgets][3]
- [Installation][4]
- [Usage][5]
- [Thanks][6]

## Goals

_Adwaita_’s main goal is to provide an easy-to-use interface for creating GNOME apps. The backend should stay as simple as possible, while not limiting the possibilities there are with [Libadwaita][7] and [GTK][8].

If you want to use _Adwaita_ in a project, but there are widgets missing, open an [issue on GitHub][9].

Find more information about the project's motivation in [this blog post](https://www.swift.org/blog/adwaita-swift/).

## Widgets

An overview of the widgets supported by _Adwaita_ is available [here](user-manual/Information/Widgets.md).

## Installation
### Dependencies
#### Flatpak

It is recommended to develop apps inside of a Flatpak.
That way, you don't have to install Swift or any of the dependencies on your system, and you always have access to the latest versions.
Take a look at the [template repository](https://github.com/AparokshaUI/AdwaitaTemplate).
This works on Linux only.

#### Directly on System

You can also run your apps directly on the system.

If you are using a Linux distribution, install `libadwaita-devel` or `libadwaita` (or something similar, based on the package manager) as well as `gtk4-devel`, `gtk4` or similar.

On macOS, follow these steps:
1. Install [Homebrew][11].
2. Install Libadwaita (and thereby GTK 4):
```
brew install libadwaita
```

### Swift Package
1. Open your Swift package in GNOME Builder, Xcode, or any other IDE.
2. Open the `Package.swift` file.
3. Into the `Package` initializer, under `dependencies`, paste:
```swift
.package(url: "https://github.com/AparokshaUI/Adwaita", from: "0.1.0")   
```

## Usage

I recommend using the [template repository](https://github.com/AparokshaUI/AdwaitaTemplate) as a starting point.

Follow the [interactive tutorial](https://aparokshaui.github.io/adwaita-swift/tutorials/table-of-contents) or [read the docs](https://aparokshaui.github.io/adwaita-swift/documentation/adwaita) in order to get to know _Adwaita for Swift_.

## Thanks

### Dependencies
- [XMLCoder][18] licensed under the [MIT license][19]
- [Levenshtein Transformations](https://github.com/david-swift/LevenshteinTransformations) licensed under the [MIT license](https://github.com/david-swift/LevenshteinTransformations/blob/main/LICENSE.md)

### Other Thanks
- The [contributors][20]
- The auto-generation of widgets is based on [Swift Cross UI](https://github.com/stackotter/swift-cross-ui)
- [SwiftLint][21] for checking whether code style conventions are violated
- The programming language [Swift][22]

[1]:    Tests/
[2]:	#goals
[3]:	#widgets
[4]:	#installation
[5]:	#usage
[6]:	#thanks
[7]:	https://gnome.pages.gitlab.gnome.org/libadwaita/doc/1-latest/index.html
[8]:	https://docs.gtk.org/gtk4/
[9]:	https://github.com/AparokshaUI/Adwaita/issues
[10]:	https://github.com/AparokshaUI/Libadwaita
[11]:	https://brew.sh
[12]:	user-manual/GettingStarted.md
[13]:	user-manual/Basics/HelloWorld.md
[14]:   user-manual/Basics/CreatingViews.md
[15]:   user-manual/Basics/Windows.md
[16]:   user-manual/Basics/KeyboardShortcuts.md
[17]:   user-manual/Advanced/CreatingWidgets.md
[18]:	https://github.com/CoreOffice/XMLCoder
[19]:	https://github.com/CoreOffice/XMLCoder/blob/main/LICENSE
[20]:	Contributors.md
[21]:	https://github.com/realm/SwiftLint
[22]:	https://github.com/apple/swift
[23]:	https://github.com/SourceDocs/SourceDocs

[image-1]: Icons/Counter.png
[image-2]: Icons/Demo.png
