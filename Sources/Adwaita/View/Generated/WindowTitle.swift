//
//  WindowTitle.swift
//  Adwaita
//
//  Created by auto-generation on 10.02.24.
//

import CAdw
import LevenshteinTransformations

/// A helper widget for setting a window's title and subtitle.
/// 
/// <picture><source srcset="window-title-dark.png" media="(prefers-color-scheme: dark)"><img src="window-title.png" alt="window-title"></picture>
/// 
/// `AdwWindowTitle` shows a title and subtitle. It's intended to be used as the
/// title child of [class@Gtk.HeaderBar] or [class@HeaderBar].
/// 
/// ## CSS nodes
/// 
/// `AdwWindowTitle` has a single CSS node with name `windowtitle`.
public struct WindowTitle: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage) -> Void] = []

    /// The subtitle to display.
    /// 
    /// The subtitle should give the user additional details.
    var subtitle: String
    /// The title to display.
    /// 
    /// The title typically identifies the current view or content item, and
    /// generally does not use the application name.
    var title: String
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `WindowTitle`.
    public init(subtitle: String, title: String) {
        self.subtitle = subtitle
        self.title = title
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(adw_window_title_new(title, subtitle)?.opaque())
        update(storage, modifiers: modifiers, updateProperties: true)


        for function in appearFunctions {
            function(storage)
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
            if updateProperties {
                adw_window_title_set_subtitle(widget, subtitle)
            }
            if updateProperties {
                adw_window_title_set_title(widget, title)
            }


        }
        for function in updateFunctions {
            function(storage)
        }
    }

    /// The subtitle to display.
    /// 
    /// The subtitle should give the user additional details.
    public func subtitle(_ subtitle: String) -> Self {
        var newSelf = self
        newSelf.subtitle = subtitle
        
        return newSelf
    }

    /// The title to display.
    /// 
    /// The title typically identifies the current view or content item, and
    /// generally does not use the application name.
    public func title(_ title: String) -> Self {
        var newSelf = self
        newSelf.title = title
        
        return newSelf
    }

}
