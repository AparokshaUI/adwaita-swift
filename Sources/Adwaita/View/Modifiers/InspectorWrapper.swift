//
//  InspectorWrapper.swift
//  Adwaita
//
//  Created by david-swift on 10.09.23.
//

import CAdw

/// A widget which executes a custom code on the GTUI widget when being created and updated.
struct InspectorWrapper: Widget {

    /// The custom code to edit the widget.
    var modify: (ViewStorage) -> Void
    /// The wrapped view.
    var content: View

    /// Get the content's container.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The content's container.
    func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = content.storage(modifiers: modifiers)
        modify(storage)
        return storage
    }

    /// Update the content.
    /// - Parameters:
    ///     - storage: The content's storage.
    ///     - modifiers: Modify views before being updated.
    ///     - updateProperties: Whether to update properties.
    func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
        content.updateStorage(storage, modifiers: modifiers, updateProperties: updateProperties)
        modify(storage)
    }

}

extension View {

    /// The identifier for the focus event controller.
    static var focus: String { "focus" }

    /// Modify a GTUI widget before being displayed and when being updated.
    /// - Parameter modify: Modify the widget.
    /// - Returns: A view.
    public func inspect(_ modify: @escaping (ViewStorage) -> Void) -> View {
        InspectorWrapper(modify: modify, content: self)
    }

    /// Add padding around a view.
    /// - Parameters:
    ///   - padding: The size of the padding.
    ///   - edges: The edges which are affected by the padding.
    /// - Returns: A view.
    public func padding(_ padding: Int = 10, _ edges: Set<Edge> = .all) -> View {
        inspect { widget in
            if edges.contains(.leading) { gtk_widget_set_margin_start(widget.pointer?.cast(), padding.cInt) }
            if edges.contains(.trailing) { gtk_widget_set_margin_end(widget.pointer?.cast(), padding.cInt) }
            if edges.contains(.top) { gtk_widget_set_margin_top(widget.pointer?.cast(), padding.cInt) }
            if edges.contains(.bottom) { gtk_widget_set_margin_bottom(widget.pointer?.cast(), padding.cInt) }
        }
    }

    /// Enable or disable the horizontal expansion.
    /// - Parameter enabled: Whether it is enabled or disabled.
    /// - Returns: A view.
    public func hexpand(_ enabled: Bool = true) -> View {
        inspect { gtk_widget_set_hexpand($0.pointer?.cast(), enabled.cBool) }
    }

    /// Enable or disable the vertical expansion.
    /// - Parameter enabled: Whether it is enabled or disabled.
    /// - Returns: A view.
    public func vexpand(_ enabled: Bool = true) -> View {
        inspect { gtk_widget_set_vexpand($0.pointer?.cast(), enabled.cBool) }
    }

    /// Set the horizontal alignment.
    /// - Parameter align: The alignment.
    /// - Returns: A view.
    public func halign(_ align: Alignment) -> View {
        inspect { gtk_widget_set_halign($0.pointer?.cast(), align.cAlign) }
    }

    /// Set the vertical alignment.
    /// - Parameter align: The alignment.
    /// - Returns: A view.
    public func valign(_ align: Alignment) -> View {
        inspect { gtk_widget_set_valign($0.pointer?.cast(), align.cAlign) }
    }

    /// Set the view's minimal width or height.
    /// - Parameters:
    ///   - minWidth: The minimal width.
    ///   - minHeight: The minimal height.
    /// - Returns: A view.
    public func frame(minWidth: Int? = nil, minHeight: Int? = nil) -> View {
        inspect { gtk_widget_set_size_request($0.pointer?.cast(), minWidth?.cInt ?? 1, minHeight?.cInt ?? -1) }
    }

    /// Set the view's transition.
    /// - Parameter transition: The transition.
    /// - Returns: A view.
    public func transition(_ transition: Transition) -> View {
        inspect { $0.fields[.transition] = transition }
    }

    /// Set the view's navigation title.
    /// - Parameter label: The navigation title.
    /// - Returns: A view.
    public func navigationTitle(_ label: String) -> View {
        inspect { $0.fields[.navigationLabel] = label }
    }

    /// Add a style class to the view.
    /// - Parameters:
    ///     - style: The style class.
    ///     - active: Whether the style is currently applied.
    /// - Returns: A view.
    public func style(_ style: String, active: Bool = true) -> View {
        inspect { storage in
            if active {
                gtk_widget_add_css_class(storage.pointer?.cast(), style)
            } else {
                gtk_widget_remove_css_class(storage.pointer?.cast(), style)
            }
        }
    }

    /// Make a button or similar widget use accent colors.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func suggested(_ active: Bool = true) -> View {
        style("suggested-action", active: active)
    }

    /// Make a button or similar widget use destructive colors.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func destructive(_ active: Bool = true) -> View {
        style("destructive-action", active: active)
    }

    /// Make a button or similar widget use flat appearance.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func flat(_ active: Bool = true) -> View {
        style("flat", active: active)
    }

    /// Make a button or similar widget use the regular appearance instead of the flat one.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func raised(_ active: Bool = true) -> View {
        style("raised", active: active)
    }

    /// Make a button or similar widget round.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func circular(_ active: Bool = true) -> View {
        style("circular", active: active)
    }

    /// Make a button or similar widget appear as a pill.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func pill(_ active: Bool = true) -> View {
        style("pill", active: active)
    }

    /// Make the view partially transparent.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func dimLabel(_ active: Bool = true) -> View {
        style("dim-label", active: active)
    }

    /// Use a title typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func title1(_ active: Bool = true) -> View {
        style("title-1", active: active)
    }

    /// Use a title typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func title2(_ active: Bool = true) -> View {
        style("title-2", active: active)
    }

    /// Use a title typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func title3(_ active: Bool = true) -> View {
        style("title-3", active: active)
    }

    /// Use a title typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func title4(_ active: Bool = true) -> View {
        style("title-4", active: active)
    }

    /// Use the heading typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func heading(_ active: Bool = true) -> View {
        style("heading", active: active)
    }

    /// Use the body typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func body(_ active: Bool = true) -> View {
        style("body", active: active)
    }

    /// Use the caption heading typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func captionHeading(_ active: Bool = true) -> View {
        style("caption-heading", active: active)
    }

    /// Use the caption typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func caption(_ active: Bool = true) -> View {
        style("caption", active: active)
    }

    /// Use the monospace typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func monospace(_ active: Bool = true) -> View {
        style("monospace", active: active)
    }

    /// Use the numeric typography style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func numeric(_ active: Bool = true) -> View {
        style("numeric", active: active)
    }

    /// Apply the accent color.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func accent(_ active: Bool = true) -> View {
        style("accent", active: active)
    }

    /// Apply the success color.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func success(_ active: Bool = true) -> View {
        style("success", active: active)
    }

    /// Apply the warning color.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func warning(_ active: Bool = true) -> View {
        style("warning", active: active)
    }

    /// Apply the error color.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func error(_ active: Bool = true) -> View {
        style("error", active: active)
    }

    /// Apply the card style.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func card(_ active: Bool = true) -> View {
        style("card", active: active)
    }

    /// Apply an icon dropshadow.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    ///
    /// Use for icons larger than 32x32 pixels.
    public func iconDropshadow(_ active: Bool = true) -> View {
        style("icon-dropshadow", active: active)
    }

    /// Use for icons smaller than or equal to 32x32 pixels.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func lowresIcon(_ active: Bool = true) -> View {
        style("lowres-icon", active: active)
    }

    /// Use the OSD style class.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func osd(_ active: Bool = true) -> View {
        style("osd", active: active)
    }

    /// Give a view the default window background and foreground colors.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func backgroundStyle(_ active: Bool = true) -> View {
        style("background", active: active)
    }

    /// Give a view the default view background and foreground colors.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func viewStyle(_ active: Bool = true) -> View {
        style("view", active: active)
    }

    /// Give a view the default border.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func frameStyle(_ active: Bool = true) -> View {
        style("frame", active: active)
    }

    /// Run a function when the view gets an update.
    /// - Parameter onUpdate: The function.
    /// - Returns: A view.
    public func onUpdate(_ onUpdate: @escaping () -> Void) -> View {
        inspect { _ in onUpdate() }
    }

    /// Make the view insensitive (useful e.g. in overlays).
    /// - Parameter insensitive: Whether the view is insensitive.
    /// - Returns: A view.
    public func insensitive(_ insensitive: Bool = true) -> View {
        inspect { gtk_widget_set_sensitive($0.pointer?.cast(), insensitive ? 0 : 1) }
    }

    /// Set the view's visibility.
    /// - Parameter visible: Whether the view is visible.
    /// - Returns: A view.
    public func visible(_ visible: Bool = true) -> View {
        inspect { gtk_widget_set_visible($0.pointer?.cast(), visible.cBool) }
    }

    /// Bind to the view's focus.
    /// - Parameter focus: Whether the view is focused.
    /// - Returns: A view.
    public func focused(_ focused: Binding<Bool>) -> View {
        inspectOnAppear { storage in
            let controller = gtk_event_controller_focus_new()
            storage.content[Self.focus] = [.init(controller)]
            gtk_widget_add_controller(storage.pointer?.cast(), controller)
        }
        .inspect { storage in
            guard let controller = storage.content[Self.focus]?.first else {
                return
            }
            controller.notify(name: "contains-focus", id: "focused") {
                let newValue = gtk_event_controller_focus_contains_focus(controller.pointer) != 0
                if focused.wrappedValue != newValue {
                    focused.wrappedValue = newValue
                }
            }
            if gtk_event_controller_focus_contains_focus(controller.pointer) == 0, focused.wrappedValue {
                gtk_widget_grab_focus(storage.pointer?.cast())
            }
        }
    }

    /// Bind a signal that focuses the view.
    /// - Parameter focus: Whether the view is focused.
    /// - Returns: A view.
    public func focus(_ signal: Signal) -> View {
        inspect { storage in
            if signal.update {
                gtk_widget_grab_focus(storage.pointer?.cast())
            }
        }
    }

    /// Add a tooltip to the widget.
    /// - Parameter tooltip: The tooltip text.
    /// - Returns: A view.
    public func tooltip(_ tooltip: String) -> View {
        inspect { gtk_widget_set_tooltip_markup($0.pointer?.cast(), tooltip) }
    }

}
