# Auto-Generated Widgets

Visit the [Libadwaita](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/1-latest/) or [Gtk](https://docs.gtk.org/gtk4/index.html) docs
and find the widget you want to implement.

There is an auto-generated interface available for many Libadwaita and Gtk widgets.
This page shows how to use them, using [AdwSplitButton](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/1-latest/class.SplitButton.html) as an example.

## The Initializer
The type name is the original type name without the prefix, in that case `SplitButton`.

Most of the widgets enable initialization with an empty initializer.
Exceptions will cause a helpful error message when trying with an empty initializer.

```swift
var view: Body {
    SplitButton()
}
```

## Simple Properties
Properties with "simple" types, such as strings (and most other types), have
a Swift equivalent with the same name in camel case.
For example, you will find the properties `label` and `dropdown-tooltip` in the docs.
They can be used in the following way:

```swift
var view: Body {
    SplitButton()
        .label("Hello")
        .dropdownTooltip("World")
}
```

Properties that are booleans can be set implicitly to `true`:

```swift
var view: Body {
    SplitButton()
        .label("Hello")
        .canShrink()
}
```

## Signals
You can connect to signals using their names.

```swift
var view: Body {
    SplitButton()
        .label("Hello")
        .clicked {
            print("Clicked")
        }
}
```

## Views and Menu Models
Properties of the type `GtkWidget` can be used in the following way:
```swift
    SplitButton()
        .child {
            ButtonContent()
                .label("Hello")
                .iconName("zoom-original-symbolic")
        }
}
```

`GMenuModel` is treated similarly:
```swift
var view: Body {
    SplitButton()
        .label("Hello")
        .menuModel(app: app) {
            MenuButton("Test") {
                print("Test")
            }
            MenuButton("World") {
                print("World")
            }
        }
}
```

## Bindings
Some properties can be changed by a user action (e.g. toggles).
They expect a binding instead of a "normal" value.
Compilation error messages will be helpful in spotting those properties.

