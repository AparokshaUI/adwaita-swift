//
//  WindowTitle.swift
//  Adwaita
//
//  Created by auto-generation on 03.08.24.
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
public struct WindowTitle: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(AnyView) -> AnyView], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(AnyView) -> AnyView]) -> Void] = []

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
    var app: AdwaitaApp?
    /// The window.
    var window: AdwaitaWindow?

    /// Initialize `WindowTitle`.
    public init(subtitle: String, title: String) {
        self.subtitle = subtitle
        self.title = title
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(modifiers: [(AnyView) -> AnyView], type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_window_title_new(title, subtitle)?.opaque())
        for function in appearFunctions {
            function(storage, modifiers)
        }
        update(storage, modifiers: modifiers, updateProperties: true, type: type)

        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The type of the app storage.
    public func update<Data>(_ storage: ViewStorage, modifiers: [(AnyView) -> AnyView], updateProperties: Bool, type: Data.Type) where Data: ViewRenderData {
        storage.modify { widget in

            if updateProperties, (storage.previousState as? Self)?.subtitle != subtitle {
                adw_window_title_set_subtitle(widget, subtitle)
            }
            if updateProperties, (storage.previousState as? Self)?.title != title {
                adw_window_title_set_title(widget, title)
            }


        }
        for function in updateFunctions {
            function(storage, modifiers, updateProperties)
        }
        if updateProperties {
            storage.previousState = self
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
