//
//  ModifierWrapper.swift
//  Adwaita
//
//  Created by david-swift on 04.09.24.
//

import CAdw

/// A wrapper for view modifiers for any view.
struct ModifierWrapper: AdwaitaWidget {

    /// The view.
    var content: AnyView
    /// The padding.
    var padding: Int?
    /// The padding edges.
    var edges: Set<Edge>?
    /// Whether to expand horizontally.
    var hexpand: Bool?
    /// Whether to expand vertically.
    var vexpand: Bool?
    /// The horizontal alignment.
    var halign: Alignment?
    /// The vertical alignment.
    var valign: Alignment?
    /// The minimum width.
    var minWidth: Int?
    /// The minimum height.
    var minHeight: Int?
    /// The style class.
    var style: String?
    /// Whether the style is active.
    var styleActive: Bool?
    /// Whether the view is insensitive.
    var insensitive: Bool?
    /// Whether the view is visible.
    var visible: Bool?
    /// The tooltip.
    var tooltip: String?

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The view render data type.
    /// - Returns: The view storage.
    func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let content = content.storage(data: data, type: type)
        let storage = ViewStorage(content.pointer, content: [.mainContent: [content]])
        update(storage, data: data, updateProperties: true, type: type)
        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The view render data type.
    func update<Data>(
        _ storage: ViewStorage,
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        if let storage = storage.content[.mainContent]?.first {
            content.updateStorage(storage, data: data, updateProperties: updateProperties, type: type)
        }
        guard updateProperties else {
            return
        }
        update1(storage, data: data, updateProperties: updateProperties, type: type)
        update2(storage, data: data, updateProperties: updateProperties, type: type)
        storage.previousState = self
    }

    /// Update part 1 of the properties.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The view render data type.
    func update1<Data>(
        _ storage: ViewStorage,
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        let previousState = storage.previousState as? Self
        if let padding, let edges, previousState?.padding != padding || previousState?.edges != edges {
            if edges.contains(.leading) { gtk_widget_set_margin_start(storage.opaquePointer?.cast(), padding.cInt) }
            if edges.contains(.trailing) { gtk_widget_set_margin_end(storage.opaquePointer?.cast(), padding.cInt) }
            if edges.contains(.top) { gtk_widget_set_margin_top(storage.opaquePointer?.cast(), padding.cInt) }
            if edges.contains(.bottom) { gtk_widget_set_margin_bottom(storage.opaquePointer?.cast(), padding.cInt) }
        }
        if let hexpand, previousState?.hexpand != hexpand {
            gtk_widget_set_hexpand(storage.opaquePointer?.cast(), hexpand.cBool)
        }
        if let vexpand, previousState?.vexpand != vexpand {
            gtk_widget_set_vexpand(storage.opaquePointer?.cast(), vexpand.cBool)
        }
        if let halign, previousState?.halign != halign {
            gtk_widget_set_halign(storage.opaquePointer?.cast(), halign.cAlign)
        }
        if let valign, previousState?.valign != valign {
            gtk_widget_set_valign(storage.opaquePointer?.cast(), valign.cAlign)
        }
    }

    /// Update part 2 of the properties.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The view render data type.
    func update2<Data>(
        _ storage: ViewStorage,
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        let previousState = storage.previousState as? Self
        if minWidth != previousState?.minWidth || minHeight != previousState?.minHeight {
            gtk_widget_set_size_request(storage.opaquePointer?.cast(), minWidth?.cInt ?? 1, minHeight?.cInt ?? -1)
        }
        if let style, let styleActive, previousState?.styleActive != styleActive {
            if styleActive {
                gtk_widget_add_css_class(storage.opaquePointer?.cast(), style)
            } else {
                gtk_widget_remove_css_class(storage.opaquePointer?.cast(), style)
            }
        }
        if let insensitive, previousState?.insensitive != insensitive {
            gtk_widget_set_sensitive(storage.opaquePointer?.cast(), insensitive ? 0 : 1)
        }
        if let visible, previousState?.visible != visible {
            gtk_widget_set_visible(storage.opaquePointer?.cast(), visible.cBool)
        }
        if let tooltip, previousState?.tooltip != tooltip {
            gtk_widget_set_tooltip_markup(storage.opaquePointer?.cast(), tooltip)
        }
    }

}

extension AnyView {

    /// Add padding around a view.
    /// - Parameters:
    ///   - padding: The size of the padding.
    ///   - edges: The edges which are affected by the padding.
    /// - Returns: A view.
    public func padding(_ padding: Int = 10, _ edges: Set<Edge> = .all) -> AnyView {
        ModifierWrapper(content: self, padding: padding, edges: edges)
    }

    /// Enable or disable the horizontal expansion.
    /// - Parameter enabled: Whether it is enabled or disabled.
    /// - Returns: A view.
    public func hexpand(_ enabled: Bool = true) -> AnyView {
        ModifierWrapper(content: self, hexpand: enabled)
    }

    /// Enable or disable the vertical expansion.
    /// - Parameter enabled: Whether it is enabled or disabled.
    /// - Returns: A view.
    public func vexpand(_ enabled: Bool = true) -> AnyView {
        ModifierWrapper(content: self, vexpand: enabled)
    }

    /// Set the horizontal alignment.
    /// - Parameter align: The alignment.
    /// - Returns: A view.
    public func halign(_ align: Alignment) -> AnyView {
        ModifierWrapper(content: self, halign: align)
    }

    /// Set the vertical alignment.
    /// - Parameter align: The alignment.
    /// - Returns: A view.
    public func valign(_ align: Alignment) -> AnyView {
        ModifierWrapper(content: self, valign: align)
    }

    /// Set the view's minimal width or height.
    /// - Parameters:
    ///   - minWidth: The minimal width.
    ///   - minHeight: The minimal height.
    /// - Returns: A view.
    public func frame(minWidth: Int? = nil, minHeight: Int? = nil) -> AnyView {
        ModifierWrapper(content: self, minWidth: minWidth, minHeight: minHeight)
    }

    /// Add a style class to the view.
    /// - Parameters:
    ///     - style: The style class.
    ///     - active: Whether the style is currently applied.
    /// - Returns: A view.
    public func style(_ style: String, active: Bool = true) -> AnyView {
        ModifierWrapper(content: self, style: style, styleActive: active)
    }

    /// Make the view insensitive (useful e.g. in overlays).
    /// - Parameter insensitive: Whether the view is insensitive.
    /// - Returns: A view.
    public func insensitive(_ insensitive: Bool = true) -> AnyView {
        ModifierWrapper(content: self, insensitive: insensitive)
    }

    /// Set the view's visibility.
    /// - Parameter visible: Whether the view is visible.
    /// - Returns: A view.
    public func visible(_ visible: Bool = true) -> AnyView {
        ModifierWrapper(content: self, visible: visible)
    }

    /// Add a tooltip to the widget.
    /// - Parameter tooltip: The tooltip text.
    /// - Returns: A view.
    public func tooltip(_ tooltip: String) -> AnyView {
        ModifierWrapper(content: self, tooltip: tooltip)
    }

}
