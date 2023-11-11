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
        Text("\(count)")
            .style("title-1")
            .padding(50)
            .topToolbar {
                HeaderBar.start {
                    Button(icon: .default(icon: .goPrevious)) {
                        count -= 1
                    }
                    Button(icon: .default(icon: .goNext)) {
                        count += 1
                    }
                }
            }
    }

}
```

Creates a simple counter view:

![Counter Example][image-1]

More examples are available in the [demo app][1]:

![Demo App][image-2]

## Table of Contents

- [Goals][2]
- [Widgets][3]
- [Installation][4]
- [Usage][5]
- [Thanks][6]

## Goals

_Adwaita_’s main goal is to provide an easy-to-use interface for creating GNOME apps. The backend should stay as simple as possible, while not limiting the possibilities there are with [Libadwaita][7] and [GTK][8].

If you want to use _Adwaita_ in a project, but there are widgets missing, open an [issue on GitHub][9].

## Widgets

| Name                 | Description                                                       | Widget                 |
| -------------------- | ----------------------------------------------------------------- | ---------------------- |
| Button               | A widget that triggers a function when being clicked.             | GtkButton              |
| EitherView           | A widget that displays one of its child views based on a boolean. | GtkStack               |
| HeaderBar            | A widget for creating custom title bars for windows.              | GtkHeaderBar           |
| Text                 | A widget for displaying a small amount of text.                   | GtkLabel               |
| VStack               | A widget which arranges child widgets into a single column.       | GtkBox                 |
| HStack               | A widget which arranges child widgets into a single row.          | GtkBox                 |
| List                 | A widget which arranges child widgets vertically into rows.       | GtkListBox             |
| Menu                 | A widget showing a button that toggles the appearance of a menu.  | GtkMenuButton          |
| NavigationSplitView  | A widget presenting sidebar and content side by side.             | AdwNavigationSplitView |
| ScrollView           | A container that makes its child scrollable.                      | GtkScrolledWindow      |
| StatusPage           | A page with an icon, title, and optionally description and widget.| AdwStatusPage          |
| StateWrapper         | A wrapper not affecting the UI which stores state information.    | -                      |

### View Modifiers

| Syntax                       | Description                                                                             |
| ---------------------------- | --------------------------------------------------------------------------------------- |
| `inspect(_:)`                | Edit the underlying [GTUI][10] widget.                                                  |
| `padding(_:_:)`              | Add empty space around a view.                                                          |
| `hexpand(_:)`                | Enable or disable the horizontal expansion of a view.                                   |
| `vexpand(_:)`                | Enable or disable the vertical expansion of a view.                                     |
| `halign(_:)`                 | Set the horizontal alignment of a view.                                                 |
| `valign(_:)`                 | Set the vertical alignment of a view.                                                   |
| `frame(minWidth:minHeight:)` | Set the view’s minimal width or height.                                                 |
| `frame(maxSize:)`            | Set the view’s maximal size.                                                            |
| `transition(_:)`             | Assign a transition with the view that is used if it is a direct child of an EitherView.|
| `onUpdate(_:)`               | Run a function every time a view gets updated.                                          |
| `navigationTitle(_:)`        | Add a title that is used if the view is a direct child of a NavigationView.             |
| `style(_:)`                  | Add a style class to the view.                                                          |
| `onAppear(_:)`               | Run when the view is rendered for the first time.                                       |
| `topToolbar(visible:_:)`     | Add a native toolbar to the view. Normally, it contains a HeaderBar.                    |
| `bottomToolbar(visible:_:)`  | Add a native bottom toolbar to the view.                                                |

### `Button` Modifiers
| Syntax                       | Description                                                                             |
| ---------------------------- | --------------------------------------------------------------------------------------- |
| `keyboardShortcut(_:window:)`| Create a keyboard shortcut for the window with the button's action.                     |
| `keyboardShortcut(_:app:)`   | Create a keyboard shortcut for the application with the button's action.                |

### `HeaderBar` Modifiers
| Syntax                       | Description                                                                             |
| ---------------------------- | --------------------------------------------------------------------------------------- |
| `headerBarTitle(view:)`      | Customize the title view in the header bar.                                             |

### `List` Modifiers
| Syntax                       | Description                                                                             |
| ---------------------------- | --------------------------------------------------------------------------------------- |
| `sidebarStyle()`             | Change the style of the list to match a sidebar.                                        |

### Window Types
| Name                 | Description                                                       | Widget                 |
| -------------------- | ----------------------------------------------------------------- | ---------------------- |
| Window               | A simple application window.                                      | AdwApplicationWindow   |

### Window Modifiers
| Syntax                          | Description                                                                             |
| ------------------------------- | --------------------------------------------------------------------------------------- |
| `appKeyboardShortcut(_:action:)`| Create a keyboard shortcut available in the whole the application.                      |
| `quitShortcut()`                | Create a keyboard shortcut for quitting the application with "Ctrl + q".                |

### `Window` Modifiers
| Syntax                          | Description                                                                             |
| ------------------------------- | --------------------------------------------------------------------------------------- |
| `keyboardShortcut(_:action:)`   | Create a keyboard shortcut available in one window.                                     |
| `closeShortcut()`               | Create a keyboard shortcut for closing the window with "Ctrl + w".                      |
| `overlay(windows:)`             | Add windows that attach to a window of this type when being presented.                  |

### Menu Widgets
| Name                 | Description                                                       | Widget                 |
| -------------------- | ----------------------------------------------------------------- | ---------------------- |
| MenuButton           | A button in a menu.                                               | GMenuItem              |
| MenuSection          | A collection of menu widgets grouped with lines.                  | GMenuItem              |
| Submenu              | A collection of menu widgets grouped by navigation.               | GMenuItem              |

### `MenuButton` Modifiers
| Syntax                          | Description                                                                             |
| ------------------------------- | --------------------------------------------------------------------------------------- |
| `keyboardShortcut(_:)`          | Assign a keyboard shortcut to the button's action.                                      |

## Installation
### Dependencies
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
.package(url: "https://github.com/david-swift/Adwaita", from: "0.1.0")   
```

## Usage

* [Getting Started][12]

### Basics

* [Hello World][13]
* [Creating Views][14]
* [Windows][15]
* [Keyboard Shortcuts][16]

### Advanced

* [Creating Widgets][17]

## Thanks

### Dependencies
- [SwiftGui][18] licensed under the [GPL-3.0 license][19]

### Other Thanks
- The [contributors][20]
- [SwiftLint][21] for checking whether code style conventions are violated
- The programming language [Swift][22]
- [SourceDocs][23] used for generating the [docs][24]

[1]:    Tests/
[2]:	#goals
[3]:	#widgets
[4]:	#installation
[5]:	#usage
[6]:	#thanks
[7]:	https://gnome.pages.gitlab.gnome.org/libadwaita/doc/1-latest/index.html
[8]:	https://docs.gtk.org/gtk4/
[9]:	https://github.com/david-swift/Adwaita/issues
[10]:	https://github.com/JCWasmx86/SwiftGui
[11]:	https://brew.sh
[12]:	user-manual/GettingStarted.md
[13]:	user-manual/Basics/HelloWorld.md
[14]:   user-manual/Basics/CreatingViews.md
[15]:   user-manual/Basics/Windows.md
[16]:   user-manual/Basics/KeyboardShortcuts.md
[17]:   user-manual/Advanced/CreatingWidgets.md
[18]:	https://github.com/JCWasmx86/SwiftGui
[19]:	https://github.com/JCWasmx86/SwiftGui/blob/main/COPYING
[20]:	Contributors.md
[21]:	https://github.com/realm/SwiftLint
[22]:	https://github.com/apple/swift
[23]:	https://github.com/SourceDocs/SourceDocs
[24]:	Documentation/Reference/README.md

[image-1]: Icons/Screenshot.png
[image-2]: Icons/Demo.png
