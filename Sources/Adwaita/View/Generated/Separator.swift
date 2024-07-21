//
//  Separator.swift
//  Adwaita
//
//  Created by auto-generation on 21.07.24.
//

import CAdw
import LevenshteinTransformations

/// `GtkSeparator` is a horizontal or vertical separator widget.
/// 
/// ![An example GtkSeparator](separator.png)
/// 
/// A `GtkSeparator` can be used to group the widgets within a window.
/// It displays a line with a shadow to make it appear sunken into the
/// interface.
/// 
/// # CSS nodes
/// 
/// `GtkSeparator` has a single CSS node with name separator. The node
/// gets one of the .horizontal or .vertical style classes.
/// 
/// # Accessibility
/// 
/// `GtkSeparator` uses the %GTK_ACCESSIBLE_ROLE_SEPARATOR role.
public struct Separator: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(View) -> View], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(View) -> View]) -> Void] = []

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    var accessibleRole: String?
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `Separator`.
    public init() {
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(gtk_separator_new(GTK_ORIENTATION_VERTICAL)?.opaque())
        for function in appearFunctions {
            function(storage, modifiers)
        }
        update(storage, modifiers: modifiers, updateProperties: true)

        return storage
    }

    /// Update the widget's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: The view modifiers.
    ///     - updateProperties: Whether to update the view's properties.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
        storage.modify { widget in



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

}
