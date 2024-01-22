//
//  ToolbarView.swift
//  Adwaita
//
//  Created by auto-generation on 22.01.24.
//

import CAdw
import LevenshteinTransformations

/// A widget containing a page, as well as top and/or bottom bars.
/// 
/// <picture><source srcset="toolbar-view-dark.png" media="(prefers-color-scheme: dark)"><img src="toolbar-view.png" alt="toolbar-view"></picture>
/// 
/// `AdwToolbarView` has a single content widget and one or multiple top and
/// bottom bars, shown at the top and bottom sides respectively.
/// 
/// Example of an `AdwToolbarView` UI definition:
/// ```xml
/// <object class="AdwToolbarView"><child type="top"><object class="AdwHeaderBar"/></child><property name="content"><object class="AdwPreferencesPage"><!-- ... --></object></property></object>
/// ```
/// 
/// The following kinds of top and bottom bars are supported:
/// 
/// - [class@HeaderBar]
/// - [class@TabBar]
/// - [class@ViewSwitcherBar]
/// - [class@Gtk.ActionBar]
/// - [class@Gtk.HeaderBar]
/// - [class@Gtk.PopoverMenuBar]
/// - [class@Gtk.SearchBar]
/// - Any [class@Gtk.Box] or a similar widget with the
/// [`.toolbar`](style-classes.html#toolbars) style class
/// 
/// By default, top and bottom bars are flat and scrolling content has a subtle
/// undershoot shadow, same as when using the
/// [`.undershoot-top`](style-classes.html#undershot-indicators) and
/// [`.undershoot-bottom`](style-classes.html#undershot-indicators) style
/// classes. This works well in most cases, e.g. with [class@StatusPage] or
/// [class@PreferencesPage], where the background at the top and bottom parts of
/// the page is uniform. Additionally, windows with sidebars should always use
/// this style.
/// 
/// [property@ToolbarView:top-bar-style] and
/// [property@ToolbarView:bottom-bar-style] properties can be used add an opaque
/// background and a persistent shadow to top and bottom bars, this can be useful
/// for content such as [utility panes](https://developer.gnome.org/hig/patterns/containers/utility-panes.html),
/// where some elements are adjacent to the top/bottom bars, or [class@TabView],
/// where each page can have a different background.
/// 
/// <picture style="min-width: 33%; display: inline-block;"><source srcset="toolbar-view-flat-1-dark.png" media="(prefers-color-scheme: dark)"><img src="toolbar-view-flat-1.png" alt="toolbar-view-flat-1"></picture><picture style="min-width: 33%; display: inline-block;"><source srcset="toolbar-view-flat-2-dark.png" media="(prefers-color-scheme: dark)"><img src="toolbar-view-flat-2.png" alt="toolbar-view-flat-2"></picture><picture style="min-width: 33%; display: inline-block;"><source srcset="toolbar-view-raised-dark.png" media="(prefers-color-scheme: dark)"><img src="toolbar-view-raised.png" alt="toolbar-view-raised"></picture>
/// 
/// `AdwToolbarView` ensures the top and bottom bars have consistent backdrop
/// styles and vertical spacing. For comparison:
/// 
/// <picture style="min-width: 40%; display: inline-block;"><source srcset="toolbar-view-spacing-dark.png" media="(prefers-color-scheme: dark)"><img src="toolbar-view-spacing.png" alt="toolbar-view-spacing"></picture><picture style="min-width: 40%; display: inline-block;"><source srcset="toolbar-view-spacing-box-dark.png" media="(prefers-color-scheme: dark)"><img src="toolbar-view-spacing-box.png" alt="toolbar-view-spacing-box"></picture>
/// 
/// Any top and bottom bars can also be dragged to move the window, equivalent
/// to putting them into a [class@Gtk.WindowHandle].
/// 
/// Content is typically place between top and bottom bars, but can also extend
/// behind them. This is controlled with the
/// [property@ToolbarView:extend-content-to-top-edge] and
/// [property@ToolbarView:extend-content-to-bottom-edge] properties.
/// 
/// Top and bottom bars can be hidden and revealed with an animation using the
/// [property@ToolbarView:reveal-top-bars] and
/// [property@ToolbarView:reveal-bottom-bars] properties.
/// 
/// ## `AdwToolbarView` as `GtkBuildable`
/// 
/// The `AdwToolbarView` implementation of the [iface@Gtk.Buildable] interface
/// supports adding a top bar by specifying “top” as the “type” attribute of a
/// `<child>` element, or adding a bottom bar by specifying “bottom”.
/// 
/// ## Accessibility
/// 
/// `AdwToolbarView` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
public struct ToolbarView: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage) -> Void] = []

    /// The current bottom bar height.
    /// 
    /// Bottom bar height does change depending on
    /// [property@ToolbarView:reveal-bottom-bars], including during the transition.
    /// 
    /// See [property@ToolbarView:top-bar-height].
    var bottomBarHeight: Int?
    /// The content widget.
    var content:  (() -> Body)?
    /// Whether the content widget can extend behind bottom bars.
    /// 
    /// This can be used in combination with
    /// [property@ToolbarView:reveal-bottom-bars] to show and hide toolbars in
    /// fullscreen.
    /// 
    /// See [property@ToolbarView:extend-content-to-top-edge].
    var extendContentToBottomEdge: Bool?
    /// Whether the content widget can extend behind top bars.
    /// 
    /// This can be used in combination with [property@ToolbarView:reveal-top-bars]
    /// to show and hide toolbars in fullscreen.
    /// 
    /// See [property@ToolbarView:extend-content-to-bottom-edge].
    var extendContentToTopEdge: Bool?
    /// Whether bottom bars are visible.
    /// 
    /// The transition will be animated.
    /// 
    /// This can be used in combination with
    /// [property@ToolbarView:extend-content-to-bottom-edge] to show and hide
    /// toolbars in fullscreen.
    /// 
    /// See [property@ToolbarView:reveal-top-bars].
    var revealBottomBars: Bool?
    /// Whether top bars are revealed.
    /// 
    /// The transition will be animated.
    /// 
    /// This can be used in combination with
    /// [property@ToolbarView:extend-content-to-top-edge] to show and hide toolbars
    /// in fullscreen.
    /// 
    /// See [property@ToolbarView:reveal-bottom-bars].
    var revealTopBars: Bool?
    /// The current top bar height.
    /// 
    /// Top bar height does change depending [property@ToolbarView:reveal-top-bars],
    /// including during the transition.
    /// 
    /// See [property@ToolbarView:bottom-bar-height].
    var topBarHeight: Int?
    /// The body for the widget "bottom".
    var bottom: () -> Body = { [] }
    /// The body for the widget "top".
    var top: () -> Body = { [] }
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `ToolbarView`.
    public init() {
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(adw_toolbar_view_new()?.opaque())
        update(storage, modifiers: modifiers)
        if let contentStorage = content?().widget(modifiers: modifiers).storage(modifiers: modifiers) {
            storage.content["content"] = [contentStorage]
            adw_toolbar_view_set_content(storage.pointer, contentStorage.pointer?.cast())
        }

        var bottomStorage: [ViewStorage] = []
        for view in bottom() {
            bottomStorage.append(view.storage(modifiers: modifiers))
            adw_toolbar_view_add_bottom_bar(storage.pointer, bottomStorage.last?.pointer?.cast())
        }
        storage.content["bottom"] = bottomStorage
        var topStorage: [ViewStorage] = []
        for view in top() {
            topStorage.append(view.storage(modifiers: modifiers))
            adw_toolbar_view_add_top_bar(storage.pointer, topStorage.last?.pointer?.cast())
        }
        storage.content["top"] = topStorage

        for function in appearFunctions {
            function(storage)
        }
        return storage
    }

    /// Update the widget's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: The view modifiers.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        storage.modify { widget in
            if let widget = storage.content["content"]?.first {
                content?().widget(modifiers: modifiers).update(widget, modifiers: modifiers)
            }
            if let extendContentToBottomEdge {
                adw_toolbar_view_set_extend_content_to_bottom_edge(widget, extendContentToBottomEdge.cBool)
            }
            if let extendContentToTopEdge {
                adw_toolbar_view_set_extend_content_to_top_edge(widget, extendContentToTopEdge.cBool)
            }
            if let revealBottomBars {
                adw_toolbar_view_set_reveal_bottom_bars(widget, revealBottomBars.cBool)
            }
            if let revealTopBars {
                adw_toolbar_view_set_reveal_top_bars(widget, revealTopBars.cBool)
            }

            if let bottomStorage = storage.content["bottom"] {
                for (index, view) in bottom().enumerated() {
                    if let storage = bottomStorage[safe: index] {
                        view.updateStorage(storage, modifiers: modifiers)
                    }
                }
            }
            if let topStorage = storage.content["top"] {
                for (index, view) in top().enumerated() {
                    if let storage = topStorage[safe: index] {
                        view.updateStorage(storage, modifiers: modifiers)
                    }
                }
            }

        }
        for function in updateFunctions {
            function(storage)
        }
    }

    /// The current bottom bar height.
    /// 
    /// Bottom bar height does change depending on
    /// [property@ToolbarView:reveal-bottom-bars], including during the transition.
    /// 
    /// See [property@ToolbarView:top-bar-height].
    public func bottomBarHeight(_ bottomBarHeight: Int?) -> Self {
        var newSelf = self
        newSelf.bottomBarHeight = bottomBarHeight
        
        return newSelf
    }

    /// The content widget.
    public func content(@ViewBuilder _ content: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.content = content
        
        return newSelf
    }

    /// Whether the content widget can extend behind bottom bars.
    /// 
    /// This can be used in combination with
    /// [property@ToolbarView:reveal-bottom-bars] to show and hide toolbars in
    /// fullscreen.
    /// 
    /// See [property@ToolbarView:extend-content-to-top-edge].
    public func extendContentToBottomEdge(_ extendContentToBottomEdge: Bool? = true) -> Self {
        var newSelf = self
        newSelf.extendContentToBottomEdge = extendContentToBottomEdge
        
        return newSelf
    }

    /// Whether the content widget can extend behind top bars.
    /// 
    /// This can be used in combination with [property@ToolbarView:reveal-top-bars]
    /// to show and hide toolbars in fullscreen.
    /// 
    /// See [property@ToolbarView:extend-content-to-bottom-edge].
    public func extendContentToTopEdge(_ extendContentToTopEdge: Bool? = true) -> Self {
        var newSelf = self
        newSelf.extendContentToTopEdge = extendContentToTopEdge
        
        return newSelf
    }

    /// Whether bottom bars are visible.
    /// 
    /// The transition will be animated.
    /// 
    /// This can be used in combination with
    /// [property@ToolbarView:extend-content-to-bottom-edge] to show and hide
    /// toolbars in fullscreen.
    /// 
    /// See [property@ToolbarView:reveal-top-bars].
    public func revealBottomBars(_ revealBottomBars: Bool? = true) -> Self {
        var newSelf = self
        newSelf.revealBottomBars = revealBottomBars
        
        return newSelf
    }

    /// Whether top bars are revealed.
    /// 
    /// The transition will be animated.
    /// 
    /// This can be used in combination with
    /// [property@ToolbarView:extend-content-to-top-edge] to show and hide toolbars
    /// in fullscreen.
    /// 
    /// See [property@ToolbarView:reveal-bottom-bars].
    public func revealTopBars(_ revealTopBars: Bool? = true) -> Self {
        var newSelf = self
        newSelf.revealTopBars = revealTopBars
        
        return newSelf
    }

    /// The current top bar height.
    /// 
    /// Top bar height does change depending [property@ToolbarView:reveal-top-bars],
    /// including during the transition.
    /// 
    /// See [property@ToolbarView:bottom-bar-height].
    public func topBarHeight(_ topBarHeight: Int?) -> Self {
        var newSelf = self
        newSelf.topBarHeight = topBarHeight
        
        return newSelf
    }

    /// Set the body for "bottom".
    /// - Parameter body: The body.
    /// - Returns: The widget.
    public func bottom(@ViewBuilder _ body: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.bottom = body
        return newSelf
    }
    /// Set the body for "top".
    /// - Parameter body: The body.
    /// - Returns: The widget.
    public func top(@ViewBuilder _ body: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.top = body
        return newSelf
    }
}
