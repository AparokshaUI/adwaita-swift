//
//  HeaderBar.swift
//  Adwaita
//
//  Created by auto-generation on 10.02.24.
//

import CAdw
import LevenshteinTransformations

/// A title bar widget.
/// 
/// <picture><source srcset="header-bar-dark.png" media="(prefers-color-scheme: dark)"><img src="header-bar.png" alt="header-bar"></picture>
/// 
/// `AdwHeaderBar` is similar to [class@Gtk.HeaderBar], but provides additional
/// features compared to it. Refer to `GtkHeaderBar` for details. It is typically
/// used as a top bar within [class@ToolbarView].
/// 
/// ## Navigation View Integration
/// 
/// When placed inside an [class@NavigationPage], `AdwHeaderBar` will display the
/// page title instead of window title.
/// 
/// When used together with [class@NavigationView] or [class@NavigationSplitView],
/// it will also display a back button that can be used to go back to the previous
/// page. The button also has a context menu, allowing to pop multiple pages at
/// once, potentially across multiple navigation views. In rare scenarios, set
/// [property@HeaderBar:show-back-button] to `FALSE` to disable the back button
/// if it's unwanted (e.g. in an extra header bar on the same page).
/// 
/// ## Split View Integration
/// 
/// When placed inside `AdwNavigationSplitView` or `AdwOverlaySplitView`,
/// `AdwHeaderBar` will automatically hide the title buttons other than at the
/// edges of the window.
/// 
/// ## Centering Policy
/// 
/// [property@HeaderBar:centering-policy] allows to enforce strict centering of
/// the title widget. This can be useful for entries inside [class@Clamp].
/// 
/// ## Title Buttons
/// 
/// Unlike `GtkHeaderBar`, `AdwHeaderBar` allows to toggle title button
/// visibility for each side individually, using the
/// [property@HeaderBar:show-start-title-buttons] and
/// [property@HeaderBar:show-end-title-buttons] properties.
/// 
/// ## CSS nodes
/// 
/// ```
/// headerbar
/// ╰── windowhandle
/// ╰── box
/// ├── widget
/// │   ╰── box.start
/// │       ├── windowcontrols.start
/// │       ├── widget
/// │       │   ╰── [button.back]
/// │       ╰── [other children]
/// ├── widget
/// │   ╰── [Title Widget]
/// ╰── widget
/// ╰── box.end
/// ├── [other children]
/// ╰── windowcontrols.end
/// ```
/// 
/// `AdwHeaderBar`'s CSS node is called `headerbar`. It contains a `windowhandle`
/// subnode, which contains a `box` subnode, which contains three `widget`
/// subnodes at the start, center and end of the header bar. The start and end
/// subnotes contain a `box` subnode with the `.start` and `.end` style classes
/// respectively, and the center node contains a node that represents the title.
/// 
/// Each of the boxes contains a `windowcontrols` subnode, see
/// [class@Gtk.WindowControls] for details, as well as other children.
/// 
/// When [property@HeaderBar:show-back-button] is `TRUE`, the start box also
/// contains a node with the name `widget` that contains a node with the name
/// `button` and `.back` style class.
/// 
/// ## Accessibility
/// 
/// `AdwHeaderBar` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
public struct HeaderBar: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage) -> Void] = []

    /// The decoration layout for buttons.
    /// 
    /// If this property is not set, the
    /// [property@Gtk.Settings:gtk-decoration-layout] setting is used.
    /// 
    /// The format of the string is button names, separated by commas. A colon
    /// separates the buttons that should appear at the start from those at the
    /// end. Recognized button names are minimize, maximize, close and icon (the
    /// window icon).
    /// 
    /// For example, “icon:minimize,maximize,close” specifies an icon at the start,
    /// and minimize, maximize and close buttons at the end.
    var decorationLayout: String?
    /// Whether the header bar can show the back button.
    /// 
    /// The back button will never be shown unless the header bar is placed inside an
    /// [class@NavigationView]. Usually, there is no reason to set this to `FALSE`.
    var showBackButton: Bool?
    /// Whether to show title buttons at the end of the header bar.
    /// 
    /// See [property@HeaderBar:show-start-title-buttons] for the other side.
    /// 
    /// Which buttons are actually shown and where is determined by the
    /// [property@HeaderBar:decoration-layout] property, and by the state of the
    /// window (e.g. a close button will not be shown if the window can't be
    /// closed).
    var showEndTitleButtons: Bool?
    /// Whether to show title buttons at the start of the header bar.
    /// 
    /// See [property@HeaderBar:show-end-title-buttons] for the other side.
    /// 
    /// Which buttons are actually shown and where is determined by the
    /// [property@HeaderBar:decoration-layout] property, and by the state of the
    /// window (e.g. a close button will not be shown if the window can't be
    /// closed).
    var showStartTitleButtons: Bool?
    /// Whether the title widget should be shown.
    var showTitle: Bool?
    /// The title widget to display.
    /// 
    /// When set to `NULL`, the header bar will display the title of the window it
    /// is contained in.
    /// 
    /// To use a different title, use [class@WindowTitle]:
    /// 
    /// ```xml
    /// <object class="AdwHeaderBar"><property name="title-widget"><object class="AdwWindowTitle"><property name="title" translatable="yes">Title</property></object></property></object>
    /// ```
    var titleWidget:  (() -> Body)?
    /// The body for the widget "start".
    var start: () -> Body = { [] }
    /// The body for the widget "end".
    var end: () -> Body = { [] }
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `HeaderBar`.
    public init() {
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(adw_header_bar_new()?.opaque())
        update(storage, modifiers: modifiers, updateProperties: true)
        if let titleWidgetStorage = titleWidget?().widget(modifiers: modifiers).storage(modifiers: modifiers) {
            storage.content["titleWidget"] = [titleWidgetStorage]
            adw_header_bar_set_title_widget(storage.pointer, titleWidgetStorage.pointer?.cast())
        }

        var startStorage: [ViewStorage] = []
        for view in start() {
            startStorage.append(view.storage(modifiers: modifiers))
            adw_header_bar_pack_start(storage.pointer, startStorage.last?.pointer?.cast())
        }
        storage.content["start"] = startStorage
        var endStorage: [ViewStorage] = []
        for view in end() {
            endStorage.append(view.storage(modifiers: modifiers))
            adw_header_bar_pack_end(storage.pointer, endStorage.last?.pointer?.cast())
        }
        storage.content["end"] = endStorage

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
            if let decorationLayout, updateProperties {
                adw_header_bar_set_decoration_layout(widget, decorationLayout)
            }
            if let showBackButton, updateProperties {
                adw_header_bar_set_show_back_button(widget, showBackButton.cBool)
            }
            if let showEndTitleButtons, updateProperties {
                adw_header_bar_set_show_end_title_buttons(widget, showEndTitleButtons.cBool)
            }
            if let showStartTitleButtons, updateProperties {
                adw_header_bar_set_show_start_title_buttons(widget, showStartTitleButtons.cBool)
            }
            if let showTitle, updateProperties {
                adw_header_bar_set_show_title(widget, showTitle.cBool)
            }
            if let widget = storage.content["titleWidget"]?.first {
                titleWidget?().widget(modifiers: modifiers).update(widget, modifiers: modifiers, updateProperties: updateProperties)
            }

            if let startStorage = storage.content["start"] {
                for (index, view) in start().enumerated() {
                    if let storage = startStorage[safe: index] {
                        view.updateStorage(
                            storage,
                            modifiers: modifiers,
                            updateProperties: updateProperties
                        )
                    }
                }
            }
            if let endStorage = storage.content["end"] {
                for (index, view) in end().enumerated() {
                    if let storage = endStorage[safe: index] {
                        view.updateStorage(
                            storage,
                            modifiers: modifiers,
                            updateProperties: updateProperties
                        )
                    }
                }
            }

        }
        for function in updateFunctions {
            function(storage)
        }
    }

    /// The decoration layout for buttons.
    /// 
    /// If this property is not set, the
    /// [property@Gtk.Settings:gtk-decoration-layout] setting is used.
    /// 
    /// The format of the string is button names, separated by commas. A colon
    /// separates the buttons that should appear at the start from those at the
    /// end. Recognized button names are minimize, maximize, close and icon (the
    /// window icon).
    /// 
    /// For example, “icon:minimize,maximize,close” specifies an icon at the start,
    /// and minimize, maximize and close buttons at the end.
    public func decorationLayout(_ decorationLayout: String?) -> Self {
        var newSelf = self
        newSelf.decorationLayout = decorationLayout
        
        return newSelf
    }

    /// Whether the header bar can show the back button.
    /// 
    /// The back button will never be shown unless the header bar is placed inside an
    /// [class@NavigationView]. Usually, there is no reason to set this to `FALSE`.
    public func showBackButton(_ showBackButton: Bool? = true) -> Self {
        var newSelf = self
        newSelf.showBackButton = showBackButton
        
        return newSelf
    }

    /// Whether to show title buttons at the end of the header bar.
    /// 
    /// See [property@HeaderBar:show-start-title-buttons] for the other side.
    /// 
    /// Which buttons are actually shown and where is determined by the
    /// [property@HeaderBar:decoration-layout] property, and by the state of the
    /// window (e.g. a close button will not be shown if the window can't be
    /// closed).
    public func showEndTitleButtons(_ showEndTitleButtons: Bool? = true) -> Self {
        var newSelf = self
        newSelf.showEndTitleButtons = showEndTitleButtons
        
        return newSelf
    }

    /// Whether to show title buttons at the start of the header bar.
    /// 
    /// See [property@HeaderBar:show-end-title-buttons] for the other side.
    /// 
    /// Which buttons are actually shown and where is determined by the
    /// [property@HeaderBar:decoration-layout] property, and by the state of the
    /// window (e.g. a close button will not be shown if the window can't be
    /// closed).
    public func showStartTitleButtons(_ showStartTitleButtons: Bool? = true) -> Self {
        var newSelf = self
        newSelf.showStartTitleButtons = showStartTitleButtons
        
        return newSelf
    }

    /// Whether the title widget should be shown.
    public func showTitle(_ showTitle: Bool? = true) -> Self {
        var newSelf = self
        newSelf.showTitle = showTitle
        
        return newSelf
    }

    /// The title widget to display.
    /// 
    /// When set to `NULL`, the header bar will display the title of the window it
    /// is contained in.
    /// 
    /// To use a different title, use [class@WindowTitle]:
    /// 
    /// ```xml
    /// <object class="AdwHeaderBar"><property name="title-widget"><object class="AdwWindowTitle"><property name="title" translatable="yes">Title</property></object></property></object>
    /// ```
    public func titleWidget(@ViewBuilder _ titleWidget: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.titleWidget = titleWidget
        
        return newSelf
    }

    /// Set the body for "start".
    /// - Parameter body: The body.
    /// - Returns: The widget.
    public func start(@ViewBuilder _ body: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.start = body
        return newSelf
    }
    /// Set the body for "end".
    /// - Parameter body: The body.
    /// - Returns: The widget.
    public func end(@ViewBuilder _ body: @escaping () -> Body) -> Self {
        var newSelf = self
        newSelf.end = body
        return newSelf
    }
}
