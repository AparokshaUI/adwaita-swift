//
//  Spinner.swift
//  Adwaita
//
//  Created by auto-generation on 19.07.24.
//

import CAdw
import LevenshteinTransformations

/// A `GtkSpinner` widget displays an icon-size spinning animation.
/// 
/// It is often used as an alternative to a [class@Gtk.ProgressBar]
/// for displaying indefinite activity, instead of actual progress.
/// 
/// ![An example GtkSpinner](spinner.png)
/// 
/// To start the animation, use [method@Gtk.Spinner.start], to stop it
/// use [method@Gtk.Spinner.stop].
/// 
/// # CSS nodes
/// 
/// `GtkSpinner` has a single CSS node with the name spinner.
/// When the animation is active, the :checked pseudoclass is
/// added to this node.
public struct Spinner: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(View) -> View], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(View) -> View]) -> Void] = []

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    var accessibleRole: String?
    /// Whether the spinner is spinning
    var spinning: Bool?
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `Spinner`.
    public init() {
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(gtk_spinner_new()?.opaque())
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

            if let spinning, updateProperties {
                gtk_spinner_set_spinning(widget, spinning.cBool)
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

    /// Whether the spinner is spinning
    public func spinning(_ spinning: Bool? = true) -> Self {
        var newSelf = self
        newSelf.spinning = spinning
        
        return newSelf
    }

}
