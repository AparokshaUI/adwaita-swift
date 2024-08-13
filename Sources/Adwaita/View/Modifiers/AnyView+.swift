//
//  AnyView+.swift
//  Adwaita
//
//  Created by david-swift on 01.08.24.
//

import CAdw
import Foundation

extension AnyView {

    /// Set the view's aspect ratio.
    /// - Parameter aspectRatio: The aspect ratio.
    public func aspectRatio(_ aspectRatio: Float) -> AspectFrame {
        .init(ratio: aspectRatio)
            .child { self }
    }

    /// Add a top toolbar to the view.
    /// - Parameters:
    ///   - toolbar: The toolbar's content.
    ///   - visible: Whether the toolbar is visible.
    /// - Returns: A view.
    public func topToolbar(visible: Bool = true, @ViewBuilder _ toolbar: @escaping () -> Body) -> ToolbarView {
        .init()
            .content { self }
            .top(toolbar)
            .revealTopBars(visible)
    }

    /// Add a bottom toolbar to the view.
    /// - Parameters:
    ///   - toolbar: The toolbar's content.
    ///   - visible: Whether the toolbar is visible.
    /// - Returns: A view.
    public func bottomToolbar(visible: Bool = true, @ViewBuilder _ toolbar: @escaping () -> Body) -> ToolbarView {
        .init()
            .content { self }
            .bottom(toolbar)
            .revealBottomBars(visible)
    }

    /// Add an overlay view.
    /// - Parameters:
    ///     - overlay: The overlay view.
    /// - Returns: A view.
    public func overlay(@ViewBuilder _ overlay: @escaping () -> Body) -> Overlay {
        .init()
            .child { self }
            .overlay(overlay)
    }

    /// Add padding around a view.
    /// - Parameters:
    ///   - padding: The size of the padding.
    ///   - edges: The edges which are affected by the padding.
    /// - Returns: A view.
    public func padding(_ padding: Int = 10, _ edges: Set<Edge> = .all) -> AnyView {
        inspect { widget, updateProperties in
            if updateProperties {
                if edges.contains(.leading) { gtk_widget_set_margin_start(widget.opaquePointer?.cast(), padding.cInt) }
                if edges.contains(.trailing) { gtk_widget_set_margin_end(widget.opaquePointer?.cast(), padding.cInt) }
                if edges.contains(.top) { gtk_widget_set_margin_top(widget.opaquePointer?.cast(), padding.cInt) }
                if edges.contains(.bottom) { gtk_widget_set_margin_bottom(widget.opaquePointer?.cast(), padding.cInt) }
            }
        }
    }

    /// Enable or disable the horizontal expansion.
    /// - Parameter enabled: Whether it is enabled or disabled.
    /// - Returns: A view.
    public func hexpand(_ enabled: Bool = true) -> AnyView {
        inspect { storage, updateProperties in
            if updateProperties {
                gtk_widget_set_hexpand(storage.opaquePointer?.cast(), enabled.cBool)
            }
        }
    }

    /// Enable or disable the vertical expansion.
    /// - Parameter enabled: Whether it is enabled or disabled.
    /// - Returns: A view.
    public func vexpand(_ enabled: Bool = true) -> AnyView {
        inspect { storage, updateProperties in
            if updateProperties {
                gtk_widget_set_vexpand(storage.opaquePointer?.cast(), enabled.cBool)
            }
        }
    }

    /// Set the horizontal alignment.
    /// - Parameter align: The alignment.
    /// - Returns: A view.
    public func halign(_ align: Alignment) -> AnyView {
        inspect { storage, updateProperties in
            if updateProperties {
                gtk_widget_set_halign(storage.opaquePointer?.cast(), align.cAlign)
            }
        }
    }

    /// Set the vertical alignment.
    /// - Parameter align: The alignment.
    /// - Returns: A view.
    public func valign(_ align: Alignment) -> AnyView {
        inspect { storage, updateProperties in
            if updateProperties {
                gtk_widget_set_valign(storage.opaquePointer?.cast(), align.cAlign)
            }
        }
    }

    /// Set the view's minimal width or height.
    /// - Parameters:
    ///   - minWidth: The minimal width.
    ///   - minHeight: The minimal height.
    /// - Returns: A view.
    public func frame(minWidth: Int? = nil, minHeight: Int? = nil) -> AnyView {
        inspect { storage, updateProperties in
            if updateProperties {
                gtk_widget_set_size_request(storage.opaquePointer?.cast(), minWidth?.cInt ?? 1, minHeight?.cInt ?? -1)
            }
        }
    }

    /// Set the view's transition.
    /// - Parameter transition: The transition.
    /// - Returns: A view.
    public func transition(_ transition: Transition) -> AnyView {
        inspect { storage, updateProperties in
            if updateProperties {
                storage.fields[.transition] = transition
            }
        }
    }

    /// Set the view's navigation title.
    /// - Parameter label: The navigation title.
    /// - Returns: A view.
    public func navigationTitle(_ label: String) -> AnyView {
        inspect { storage, updateProperties in
            if updateProperties {
                storage.fields[.navigationLabel] = label
            }
        }
    }

    /// Add a style class to the view.
    /// - Parameters:
    ///     - style: The style class.
    ///     - active: Whether the style is currently applied.
    /// - Returns: A view.
    public func style(_ style: String, active: Bool = true) -> AnyView {
        inspect { storage, updateProperties in
            guard updateProperties else {
                return
            }
            if active {
                gtk_widget_add_css_class(storage.opaquePointer?.cast(), style)
            } else {
                gtk_widget_remove_css_class(storage.opaquePointer?.cast(), style)
            }
        }
    }

    /// Make a button or similar widget use accent colors.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func suggested(_ active: Bool = true) -> AnyView {
        style("suggested-action", active: active)
    }

    /// Make a button or similar widget use destructive colors.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func destructive(_ active: Bool = true) -> AnyView {
        style("destructive-action", active: active)
    }

    /// Make a button or similar widget use flat appearance.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func flat(_ active: Bool = true) -> AnyView {
        style("flat", active: active)
    }

    /// Make a button or similar widget use the regular appearance instead of the flat one.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func raised(_ active: Bool = true) -> AnyView {
        style("raised", active: active)
    }

    /// Make a button or similar widget round.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func circular(_ active: Bool = true) -> AnyView {
        style("circular", active: active)
    }

    /// Make a button or similar widget appear as a pill.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func pill(_ active: Bool = true) -> AnyView {
        style("pill", active: active)
    }

    /// Make the view partially transparent.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func dimLabel(_ active: Bool = true) -> AnyView {
        style("dim-label", active: active)
    }

    /// Use a title typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func title1(_ active: Bool = true) -> AnyView {
        style("title-1", active: active)
    }

    /// Use a title typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func title2(_ active: Bool = true) -> AnyView {
        style("title-2", active: active)
    }

    /// Use a title typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func title3(_ active: Bool = true) -> AnyView {
        style("title-3", active: active)
    }

    /// Use a title typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func title4(_ active: Bool = true) -> AnyView {
        style("title-4", active: active)
    }

    /// Use the heading typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func heading(_ active: Bool = true) -> AnyView {
        style("heading", active: active)
    }

    /// Use the body typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func body(_ active: Bool = true) -> AnyView {
        style("body", active: active)
    }

    /// Use the caption heading typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func captionHeading(_ active: Bool = true) -> AnyView {
        style("caption-heading", active: active)
    }

    /// Use the caption typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func caption(_ active: Bool = true) -> AnyView {
        style("caption", active: active)
    }

    /// Use the monospace typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func monospace(_ active: Bool = true) -> AnyView {
        style("monospace", active: active)
    }

    /// Use the numeric typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func numeric(_ active: Bool = true) -> AnyView {
        style("numeric", active: active)
    }

    /// Apply the accent color.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func accent(_ active: Bool = true) -> AnyView {
        style("accent", active: active)
    }

    /// Apply the success color.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func success(_ active: Bool = true) -> AnyView {
        style("success", active: active)
    }

    /// Apply the warning color.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func warning(_ active: Bool = true) -> AnyView {
        style("warning", active: active)
    }

    /// Apply the error color.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func error(_ active: Bool = true) -> AnyView {
        style("error", active: active)
    }

    /// Apply the card style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func card(_ active: Bool = true) -> AnyView {
        style("card", active: active)
    }

    /// Apply an icon dropshadow.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    ///
    /// Use for icons larger than 32x32 pixels.
    public func iconDropshadow(_ active: Bool = true) -> AnyView {
        style("icon-dropshadow", active: active)
    }

    /// Use for icons smaller than or equal to 32x32 pixels.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func lowresIcon(_ active: Bool = true) -> AnyView {
        style("lowres-icon", active: active)
    }

    /// Use the OSD style class.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func osd(_ active: Bool = true) -> AnyView {
        style("osd", active: active)
    }

    /// Give a view the default window background and foreground colors.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func backgroundStyle(_ active: Bool = true) -> AnyView {
        style("background", active: active)
    }

    /// Give a view the default view background and foreground colors.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func viewStyle(_ active: Bool = true) -> AnyView {
        style("view", active: active)
    }

    /// Give a view the default border.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func frameStyle(_ active: Bool = true) -> AnyView {
        style("frame", active: active)
    }

}
