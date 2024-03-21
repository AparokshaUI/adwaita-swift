//
//  SearchBar.swift
//  Adwaita
//
//  Created by auto-generation on 20.03.24.
//

import CAdw
import LevenshteinTransformations

/// `GtkSearchBar` is a container made to have a search entry.
/// 
/// ![An example GtkSearchBar](search-bar.png)
/// 
/// It can also contain additional widgets, such as drop-down menus,
/// or buttons.  The search bar would appear when a search is started
/// through typing on the keyboard, or the application’s search mode
/// is toggled on.
/// 
/// For keyboard presses to start a search, the search bar must be told
/// of a widget to capture key events from through
/// [method@Gtk.SearchBar.set_key_capture_widget]. This widget will
/// typically be the top-level window, or a parent container of the
/// search bar. Common shortcuts such as Ctrl+F should be handled as an
/// application action, or through the menu items.
/// 
/// You will also need to tell the search bar about which entry you
/// are using as your search entry using [method@Gtk.SearchBar.connect_entry].
/// 
/// ## Creating a search bar
/// 
/// The following example shows you how to create a more complex search
/// entry.
/// 
/// [A simple example](https://gitlab.gnome.org/GNOME/gtk/tree/main/examples/search-bar.c)
/// 
/// # CSS nodes
/// 
/// ```
/// searchbar
/// ╰── revealer
/// ╰── box
/// ├── [child]
/// ╰── [button.close]
/// ```
/// 
/// `GtkSearchBar` has a main CSS node with name searchbar. It has a child
/// node with name revealer that contains a node with name box. The box node
/// contains both the CSS node of the child widget as well as an optional button
/// node which gets the .close style class applied.
/// 
/// # Accessibility
/// 
/// `GtkSearchBar` uses the %GTK_ACCESSIBLE_ROLE_SEARCH role.
public struct SearchBar: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(View) -> View], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(View) -> View]) -> Void] = []

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    var accessibleRole: String?
    /// The child widget.
    var child:  (() -> Body)?
    /// The key capture widget.
    var keyCaptureWidget:  (() -> Body)?
    /// Whether the search mode is on and the search bar shown.
    var searchModeEnabled: Bool?
    /// Whether to show the close button in the search bar.
    var showCloseButton: Bool?
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `SearchBar`.
    public init() {
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(gtk_search_bar_new()?.opaque())
        update(storage, modifiers: modifiers, updateProperties: true)
        if let childStorage = child?().widget(modifiers: modifiers).storage(modifiers: modifiers) {
            storage.content["child"] = [childStorage]
            gtk_search_bar_set_child(storage.pointer, childStorage.pointer?.cast())
        }
        if let keyCaptureWidgetStorage = keyCaptureWidget?().widget(modifiers: modifiers).storage(modifiers: modifiers) {
            storage.content["keyCaptureWidget"] = [keyCaptureWidgetStorage]
            gtk_search_bar_set_key_capture_widget(storage.pointer, keyCaptureWidgetStorage.pointer?.cast())
        }

        for function in appearFunctions {
            function(storage, modifiers)
        }
        return storage
    }

    /// Update the widget's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: The view modifiers.
    ///     - updateProperties: Whether to update the view's properties.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
        storage.modify { widget in

            if let widget = storage.content["child"]?.first {
                child?().widget(modifiers: modifiers).update(widget, modifiers: modifiers, updateProperties: updateProperties)
            }
            if let widget = storage.content["keyCaptureWidget"]?.first {
                keyCaptureWidget?().widget(modifiers: modifiers).update(widget, modifiers: modifiers, updateProperties: updateProperties)
            }
            if let showCloseButton, updateProperties {
                gtk_search_bar_set_show_close_button(widget, showCloseButton.cBool)
            }


        }
        for function in updateFunctions {
            function(storage, modifiers, updateProperties)
        }
    }

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    public func accessibleRole(_ accessibleRole: String?) -> Self {
        var newSelf = self
        newSelf.accessibleRole = accessibleRole
        
        return newSelf
    }

    /// The child widget.
    public func child(@ViewBuilder _ child: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.child = child
        
        return newSelf
    }

    /// The key capture widget.
    public func keyCaptureWidget(@ViewBuilder _ keyCaptureWidget: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.keyCaptureWidget = keyCaptureWidget
        
        return newSelf
    }

    /// Whether the search mode is on and the search bar shown.
    public func searchModeEnabled(_ searchModeEnabled: Bool? = true) -> Self {
        var newSelf = self
        newSelf.searchModeEnabled = searchModeEnabled
        
        return newSelf
    }

    /// Whether to show the close button in the search bar.
    public func showCloseButton(_ showCloseButton: Bool? = true) -> Self {
        var newSelf = self
        newSelf.showCloseButton = showCloseButton
        
        return newSelf
    }

}
