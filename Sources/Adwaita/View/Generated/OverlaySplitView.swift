//
//  OverlaySplitView.swift
//  Adwaita
//
//  Created by auto-generation on 15.08.24.
//

import CAdw
import LevenshteinTransformations

/// A widget presenting sidebar and content side by side or as an overlay.
/// 
/// <picture><source srcset="overlay-split-view-dark.png" media="(prefers-color-scheme: dark)"><img src="overlay-split-view.png" alt="overlay-split-view"></picture><picture><source srcset="overlay-split-view-collapsed-dark.png" media="(prefers-color-scheme: dark)"><img src="overlay-split-view-collapsed.png" alt="overlay-split-view-collapsed"></picture>
/// 
/// `AdwOverlaySplitView` has two children: sidebar and content, and displays
/// them side by side.
/// 
/// When [property@OverlaySplitView:collapsed] is set to `TRUE`, the sidebar is
/// instead shown as an overlay above the content widget.
/// 
/// The sidebar can be hidden or shown using the
/// [property@OverlaySplitView:show-sidebar] property.
/// 
/// Sidebar can be displayed before or after the content, this can be controlled
/// with the [property@OverlaySplitView:sidebar-position] property.
/// 
/// Collapsing the split view automatically hides the sidebar widget, and
/// uncollapsing it shows the sidebar. If this behavior is not desired, the
/// [property@OverlaySplitView:pin-sidebar] property can be used to override it.
/// 
/// `AdwOverlaySplitView` supports an edge swipe gesture for showing the sidebar,
/// and a swipe from the sidebar for hiding it. Gestures are only supported on
/// touchscreen, but not touchpad. Gestures can be controlled with the
/// [property@OverlaySplitView:enable-show-gesture] and
/// [property@OverlaySplitView:enable-hide-gesture] properties.
/// 
/// See also [class@NavigationSplitView].
/// 
/// `AdwOverlaySplitView` is typically used together with an [class@Breakpoint]
/// setting the `collapsed` property to `TRUE` on small widths, as follows:
/// 
/// ```xml
/// <object class="AdwWindow"><property name="width-request">360</property><property name="height-request">200</property><property name="default-width">800</property><property name="default-height">800</property><child><object class="AdwBreakpoint"><condition>max-width: 400sp</condition><setter object="split_view" property="collapsed">True</setter></object></child><property name="content"><object class="AdwOverlaySplitView" id="split_view"><property name="sidebar"><!-- ... --></property><property name="content"><!-- ... --></property></object></property></object>
/// ```
/// 
/// `AdwOverlaySplitView` is often used for implementing the
/// [utility pane](https://developer.gnome.org/hig/patterns/containers/utility-panes.html)
/// pattern.
/// 
/// ## Sizing
/// 
/// When not collapsed, `AdwOverlaySplitView` changes the sidebar width
/// depending on its own width.
/// 
/// If possible, it tries to allocate a fraction of the total width, controlled
/// with the [property@OverlaySplitView:sidebar-width-fraction] property.
/// 
/// The sidebar also has minimum and maximum sizes, controlled with the
/// [property@OverlaySplitView:min-sidebar-width] and
/// [property@OverlaySplitView:max-sidebar-width] properties.
/// 
/// The minimum and maximum sizes are using the length unit specified with the
/// [property@OverlaySplitView:sidebar-width-unit].
/// 
/// By default, sidebar is using 25% of the total width, with 180sp as the
/// minimum size and 280sp as the maximum size.
/// 
/// When collapsed, the preferred width fraction is ignored and the sidebar uses
/// [property@OverlaySplitView:max-sidebar-width] when possible.
/// 
/// ## Header Bar Integration
/// 
/// When used inside `AdwOverlaySplitView`, [class@HeaderBar] will automatically
/// hide the window buttons in the middle.
/// 
/// ## `AdwOverlaySplitView` as `GtkBuildable`
/// 
/// The `AdwOverlaySplitView` implementation of the [iface@Gtk.Buildable]
/// interface supports setting the sidebar widget by specifying “sidebar” as the
/// “type” attribute of a `<child>` element, Specifying “content” child type or
/// omitting it results in setting the content widget.
/// 
/// ## CSS nodes
/// 
/// `AdwOverlaySplitView` has a single CSS node with the name
/// `overlay-split-view`.
/// 
/// It contains two nodes with the name `widget`, containing the sidebar and
/// content children.
/// 
/// When not collapsed, they have the `.sidebar-view` and `.content-view` style
/// classes respectively.
/// 
/// ```
/// overlay-split-view
/// ├── widget.sidebar-pane
/// │   ╰── [sidebar child]
/// ╰── widget.content-pane
/// ╰── [content child]
/// ```
/// 
/// When collapsed, the one containing the sidebar child has the `.background`
/// style class and the other one has no style classes.
/// 
/// ```
/// overlay-split-view
/// ├── widget.background
/// │   ╰── [sidebar child]
/// ╰── widget
/// ╰── [content child]
/// ```
/// 
/// ## Accessibility
/// 
/// `AdwOverlaySplitView` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
public struct OverlaySplitView: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, WidgetData, Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, WidgetData) -> Void] = []

    /// Whether the split view is collapsed.
    /// 
    /// When collapsed, the sidebar widget is presented as an overlay above the
    /// content widget, otherwise they are displayed side by side.
    var collapsed: Bool?
    /// The content widget.
    var content: (() -> Body)?
    /// Whether the sidebar can be closed with a swipe gesture.
    /// 
    /// Only touchscreen swipes are supported.
    var enableHideGesture: Bool?
    /// Whether the sidebar can be opened with an edge swipe gesture.
    /// 
    /// Only touchscreen swipes are supported.
    var enableShowGesture: Bool?
    /// The maximum sidebar width.
    /// 
    /// Maximum width is affected by
    /// [property@OverlaySplitView:sidebar-width-unit].
    /// 
    /// The sidebar widget can still be allocated with larger width if its own
    /// minimum width exceeds it.
    var maxSidebarWidth: Double?
    /// The minimum sidebar width.
    /// 
    /// Minimum width is affected by
    /// [property@OverlaySplitView:sidebar-width-unit].
    /// 
    /// The sidebar widget can still be allocated with larger width if its own
    /// minimum width exceeds it.
    var minSidebarWidth: Double?
    /// Whether the sidebar widget is pinned.
    /// 
    /// By default, collapsing @self automatically hides the sidebar widget, and
    /// uncollapsing it shows the sidebar. If set to `TRUE`, sidebar visibility
    /// never changes on its own.
    var pinSidebar: Bool?
    /// Whether the sidebar widget is shown.
    var showSidebar: Binding<Bool>?
    /// The sidebar widget.
    var sidebar: (() -> Body)?
    /// The preferred sidebar width as a fraction of the total width.
    /// 
    /// The preferred width is additionally limited by
    /// [property@OverlaySplitView:min-sidebar-width] and
    /// [property@OverlaySplitView:max-sidebar-width].
    /// 
    /// The sidebar widget can be allocated with larger width if its own minimum
    /// width exceeds the preferred width.
    var sidebarWidthFraction: Double?

    /// Initialize `OverlaySplitView`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The view render data type.
    /// - Returns: The view storage.
    public func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_overlay_split_view_new()?.opaque())
        for function in appearFunctions {
            function(storage, data)
        }
        update(storage, data: data, updateProperties: true, type: type)
        if let contentStorage = content?().storage(data: data, type: type) {
            storage.content["content"] = [contentStorage]
            adw_overlay_split_view_set_content(storage.opaquePointer, contentStorage.opaquePointer?.cast())
        }
        if let sidebarStorage = sidebar?().storage(data: data, type: type) {
            storage.content["sidebar"] = [sidebarStorage]
            adw_overlay_split_view_set_sidebar(storage.opaquePointer, sidebarStorage.opaquePointer?.cast())
        }

        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The view render data type.
    public func update<Data>(_ storage: ViewStorage, data: WidgetData, updateProperties: Bool, type: Data.Type) where Data: ViewRenderData {
        storage.modify { widget in

        storage.notify(name: "show-sidebar") {
            let newValue = adw_overlay_split_view_get_show_sidebar(storage.opaquePointer) != 0
if let showSidebar, newValue != showSidebar.wrappedValue {
    showSidebar.wrappedValue = newValue
}
        }
            if let collapsed, updateProperties, (storage.previousState as? Self)?.collapsed != collapsed {
                adw_overlay_split_view_set_collapsed(widget, collapsed.cBool)
            }
            if let widget = storage.content["content"]?.first {
                content?().updateStorage(widget, data: data, updateProperties: updateProperties, type: type)
            }
            if let enableHideGesture, updateProperties, (storage.previousState as? Self)?.enableHideGesture != enableHideGesture {
                adw_overlay_split_view_set_enable_hide_gesture(widget, enableHideGesture.cBool)
            }
            if let enableShowGesture, updateProperties, (storage.previousState as? Self)?.enableShowGesture != enableShowGesture {
                adw_overlay_split_view_set_enable_show_gesture(widget, enableShowGesture.cBool)
            }
            if let maxSidebarWidth, updateProperties, (storage.previousState as? Self)?.maxSidebarWidth != maxSidebarWidth {
                adw_overlay_split_view_set_max_sidebar_width(widget, maxSidebarWidth)
            }
            if let minSidebarWidth, updateProperties, (storage.previousState as? Self)?.minSidebarWidth != minSidebarWidth {
                adw_overlay_split_view_set_min_sidebar_width(widget, minSidebarWidth)
            }
            if let pinSidebar, updateProperties, (storage.previousState as? Self)?.pinSidebar != pinSidebar {
                adw_overlay_split_view_set_pin_sidebar(widget, pinSidebar.cBool)
            }
            if let showSidebar, updateProperties, (adw_overlay_split_view_get_show_sidebar(storage.opaquePointer) != 0) != showSidebar.wrappedValue {
                adw_overlay_split_view_set_show_sidebar(storage.opaquePointer, showSidebar.wrappedValue.cBool)
            }
            if let widget = storage.content["sidebar"]?.first {
                sidebar?().updateStorage(widget, data: data, updateProperties: updateProperties, type: type)
            }
            if let sidebarWidthFraction, updateProperties, (storage.previousState as? Self)?.sidebarWidthFraction != sidebarWidthFraction {
                adw_overlay_split_view_set_sidebar_width_fraction(widget, sidebarWidthFraction)
            }


        }
        for function in updateFunctions {
            function(storage, data, updateProperties)
        }
        if updateProperties {
            storage.previousState = self
        }
    }

    /// Whether the split view is collapsed.
    /// 
    /// When collapsed, the sidebar widget is presented as an overlay above the
    /// content widget, otherwise they are displayed side by side.
    public func collapsed(_ collapsed: Bool? = true) -> Self {
        var newSelf = self
        newSelf.collapsed = collapsed
        
        return newSelf
    }

    /// The content widget.
    public func content(@ViewBuilder _ content: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.content = content
        
        return newSelf
    }

    /// Whether the sidebar can be closed with a swipe gesture.
    /// 
    /// Only touchscreen swipes are supported.
    public func enableHideGesture(_ enableHideGesture: Bool? = true) -> Self {
        var newSelf = self
        newSelf.enableHideGesture = enableHideGesture
        
        return newSelf
    }

    /// Whether the sidebar can be opened with an edge swipe gesture.
    /// 
    /// Only touchscreen swipes are supported.
    public func enableShowGesture(_ enableShowGesture: Bool? = true) -> Self {
        var newSelf = self
        newSelf.enableShowGesture = enableShowGesture
        
        return newSelf
    }

    /// The maximum sidebar width.
    /// 
    /// Maximum width is affected by
    /// [property@OverlaySplitView:sidebar-width-unit].
    /// 
    /// The sidebar widget can still be allocated with larger width if its own
    /// minimum width exceeds it.
    public func maxSidebarWidth(_ maxSidebarWidth: Double?) -> Self {
        var newSelf = self
        newSelf.maxSidebarWidth = maxSidebarWidth
        
        return newSelf
    }

    /// The minimum sidebar width.
    /// 
    /// Minimum width is affected by
    /// [property@OverlaySplitView:sidebar-width-unit].
    /// 
    /// The sidebar widget can still be allocated with larger width if its own
    /// minimum width exceeds it.
    public func minSidebarWidth(_ minSidebarWidth: Double?) -> Self {
        var newSelf = self
        newSelf.minSidebarWidth = minSidebarWidth
        
        return newSelf
    }

    /// Whether the sidebar widget is pinned.
    /// 
    /// By default, collapsing @self automatically hides the sidebar widget, and
    /// uncollapsing it shows the sidebar. If set to `TRUE`, sidebar visibility
    /// never changes on its own.
    public func pinSidebar(_ pinSidebar: Bool? = true) -> Self {
        var newSelf = self
        newSelf.pinSidebar = pinSidebar
        
        return newSelf
    }

    /// Whether the sidebar widget is shown.
    public func showSidebar(_ showSidebar: Binding<Bool>?) -> Self {
        var newSelf = self
        newSelf.showSidebar = showSidebar
        
        return newSelf
    }

    /// The sidebar widget.
    public func sidebar(@ViewBuilder _ sidebar: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.sidebar = sidebar
        
        return newSelf
    }

    /// The preferred sidebar width as a fraction of the total width.
    /// 
    /// The preferred width is additionally limited by
    /// [property@OverlaySplitView:min-sidebar-width] and
    /// [property@OverlaySplitView:max-sidebar-width].
    /// 
    /// The sidebar widget can be allocated with larger width if its own minimum
    /// width exceeds the preferred width.
    public func sidebarWidthFraction(_ sidebarWidthFraction: Double?) -> Self {
        var newSelf = self
        newSelf.sidebarWidthFraction = sidebarWidthFraction
        
        return newSelf
    }

}
