# Widgets

This is an overview of the available widgets and other components in _Adwaita_.

| Name                 | Description                                                         | Widget                 |
| -------------------- | ------------------------------------------------------------------- | ---------------------- |
| Button               | A widget that triggers a function when being clicked.               | GtkButton              |
| ViewStack            | A widget that displays one of its child views based on an id.       | GtkStack               |
| HeaderBar            | A widget for creating custom title bars for windows.                | GtkHeaderBar           |
| Text                 | A widget for displaying a small amount of text.                     | GtkLabel               |
| VStack               | A widget which arranges child widgets into a single column.         | GtkBox                 |
| HStack               | A widget which arranges child widgets into a single row.            | GtkBox                 |
| Toggle               | A button with two possible states, on and off.                      | GtkToggleButton        |
| List                 | A widget which arranges child widgets vertically into rows.         | GtkListBox             |
| Menu                 | A widget showing a button that toggles the appearance of a menu.    | GtkMenuButton          |
| NavigationSplitView  | A widget presenting sidebar and content side by side.               | AdwNavigationSplitView |
| OverlaySplitView     | A widget presenting sidebar and content side by side.               | AdwOverlaySplitView    |
| ScrollView           | A container that makes its child scrollable.                        | GtkScrolledWindow      |
| StatusPage           | A page with an icon, title, and optionally description and widget.  | AdwStatusPage          |
| Container            | Supports any widget conforming to `Libadwaita.InsertableContainer`. | Multiple widgets       |
| Carousel             | A paginated scrolling widget.                                       | AdwCarousel            |
| ViewSwitcher         | A control for switching between different views.                    | AdwViewSwitcher        |
| StateWrapper         | A wrapper not affecting the UI which stores state information.      | -                      |

### View Modifiers

| Syntax                            | Description                                                                             |
| --------------------------------- | --------------------------------------------------------------------------------------- |
| `inspect(_:)`                     | Edit the underlying [Libadwaita][10] widget.                                            |
| `padding(_:_:)`                   | Add empty space around a view.                                                          |
| `hexpand(_:)`                     | Enable or disable the horizontal expansion of a view.                                   |
| `vexpand(_:)`                     | Enable or disable the vertical expansion of a view.                                     |
| `halign(_:)`                      | Set the horizontal alignment of a view.                                                 |
| `valign(_:)`                      | Set the vertical alignment of a view.                                                   |
| `frame(minWidth:minHeight:)`      | Set the view’s minimal width or height.                                                 |
| `frame(maxSize:)`                 | Set the view’s maximal size.                                                            |
| `transition(_:)`                  | Assign a transition with the view that is used if it is a direct child of an EitherView.|
| `onUpdate(_:)`                    | Run a function every time a view gets updated.                                          |
| `navigationTitle(_:)`             | Add a title that is used if the view is a direct child of a NavigationView.             |
| `style(_:)`                       | Add a style class to the view.                                                          |
| `onAppear(_:)`                    | Run when the view is rendered for the first time.                                       |
| `inspectOnAppear(_:)`             | Edit the underlying [Libadwaita][10] class when the view is rendered for the first time.|
| `topToolbar(visible:_:)`          | Add a native toolbar to the view. Normally, it contains a HeaderBar.                    |
| `bottomToolbar(visible:_:)`       | Add a native bottom toolbar to the view.                                                |
| `modifyContent(_:modify:)`        | Replace all occurrences of a certain view type with another view.                       |
| `stopModifiers()`                 | Ignore all the `modifyContent(_:modify:)` modifiers from higher above in the view tree. |
| `toast(_:signal:)`                | Show a toast on top of the view whenever the signal gets activated.                     |
| `toast(_:signal:button:handler:)` | Show a toast with a button on top of the view whenever the signal gets activated.       |

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

### `OverlaySplitView` Modifiers
| Syntax                       | Description                                                                             |
| ---------------------------- | --------------------------------------------------------------------------------------- |
| `trailingSidebar(_:)`        | Whether the sidebar is trailing to the content view.                                    |

### `ViewSwitcher` Modifiers
| Syntax                       | Description                                                                             |
| ---------------------------- | --------------------------------------------------------------------------------------- |
| `wideDesign(_:)`             | Whether the wide view switcher design is used.                                          |

### Window Types
| Name                 | Description                                                       | Widget                 |
| -------------------- | ----------------------------------------------------------------- | ---------------------- |
| Window               | A simple application window.                                      | AdwApplicationWindow   |
| AboutWindow          | A GNOME about window.                                             | AdwAboutWindow         |

### Window Modifiers
| Syntax                          | Description                                                                             |
| ------------------------------- | --------------------------------------------------------------------------------------- |
| `appKeyboardShortcut(_:action:)`| Create a keyboard shortcut available in the whole the application.                      |
| `quitShortcut()`                | Create a keyboard shortcut for quitting the application with "Ctrl + q".                |

### `Window` Modifiers
| Syntax                                                             | Description                                                                             |
| ------------------------------------------------------------------ | --------------------------------------------------------------------------------------- |
| `keyboardShortcut(_:action:)`                                      | Create a keyboard shortcut available in one window.                                     |
| `closeShortcut()`                                                  | Create a keyboard shortcut for closing the window with "Ctrl + w".                      |
| `overlay(windows:)`                                                | Add windows that attach to a window of this type when being presented.                  |
| `fileImporter(_:initialFolder:extensions:folders:onOpen:onClose:)` | Add an import file dialog.                                                              |
| `fileExporter(_:initialFolder:initialName:onSave:onClose:)`        | Add an export file dialog.                                                              |
| `defaultSize(width:height:)`                                       | Set the window's initial size.                                                          |
| `title(_:)`                                                        | Set the window's title.                                                                 |
| `resizable(_:)`                                                    | Set the window's resizability.                                                          |
| `deletable(_:)`                                                    | Set the window's deletability.                                                          |

### `AboutWindow` Modifiers
| Syntax          | Description                                                                             |
| --------------- | --------------------------------------------------------------------------------------- |
| `icon(_:)`      | Set the app icon.                                                                       |
| `website(_:)`   | Set the app's website                                                                   |

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
