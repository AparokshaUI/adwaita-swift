//
//  AnyView+.swift
//  Adwaita
//
//  Created by david-swift on 01.08.24.
//

import CAdw
import Foundation

extension AnyView {

    /// Run a function when the view gets an update.
    /// - Parameter onUpdate: The function.
    /// - Returns: A view.
    public func onUpdate(_ onUpdate: @escaping () -> Void) -> AnyView {
        inspect { _, _ in onUpdate() }
    }

    /// Make the view insensitive (useful e.g. in overlays).
    /// - Parameter insensitive: Whether the view is insensitive.
    /// - Returns: A view.
    public func insensitive(_ insensitive: Bool = true) -> AnyView {
        inspect { storage, updateProperties in
            if updateProperties {
                gtk_widget_set_sensitive(storage.opaquePointer?.cast(), insensitive ? 0 : 1)
            }
        }
    }

    /// Set the view's visibility.
    /// - Parameter visible: Whether the view is visible.
    /// - Returns: A view.
    public func visible(_ visible: Bool = true) -> AnyView {
        inspect { storage, updateProperties in
            if updateProperties {
                gtk_widget_set_visible(storage.opaquePointer?.cast(), visible.cBool)
            }
        }
    }

    /// Bind to the view's focus.
    /// - Parameter focus: Whether the view is focused.
    /// - Returns: A view.
    public func focused(_ focused: Binding<Bool>) -> AnyView {
        let focus = "focus"
        return inspectOnAppear { storage in
            let controller = gtk_event_controller_focus_new()
            storage.content[focus] = [.init(controller)]
            gtk_widget_add_controller(storage.opaquePointer?.cast(), controller)
        }
        .inspect { storage, _ in
            guard let controller = storage.content[focus]?.first else {
                return
            }
            controller.notify(name: "contains-focus", id: "focused") {
                let newValue = gtk_event_controller_focus_contains_focus(controller.opaquePointer) != 0
                if focused.wrappedValue != newValue {
                    focused.wrappedValue = newValue
                }
            }
            if gtk_event_controller_focus_contains_focus(controller.opaquePointer) == 0, focused.wrappedValue {
                gtk_widget_grab_focus(storage.opaquePointer?.cast())
            }
        }
    }

    /// Bind a signal that focuses the view.
    /// - Parameter focus: Whether the view is focused.
    /// - Returns: A view.
    public func focus(_ signal: Signal) -> AnyView {
        inspect { storage, _ in
            if signal.update {
                gtk_widget_grab_focus(storage.opaquePointer?.cast())
            }
        }
    }

    /// Add a tooltip to the widget.
    /// - Parameter tooltip: The tooltip text.
    /// - Returns: A view.
    public func tooltip(_ tooltip: String) -> AnyView {
        inspect { storage, updateProperties in
            if updateProperties {
                gtk_widget_set_tooltip_markup(storage.opaquePointer?.cast(), tooltip)
            }
        }
    }

    /// Run a function when the view appears for the first time.
    /// - Parameter closure: The function.
    /// - Returns: A view.
    public func onAppear(_ closure: @escaping () -> Void) -> AnyView {
        inspectOnAppear { _ in closure() }
    }

    /// Run a function when the widget gets clicked.
    /// - Parameter handler: The function.
    /// - Returns: A view.
    public func onClick(handler: @escaping () -> Void) -> AnyView {
        inspectOnAppear { storage in
            let controller = ViewStorage(gtk_gesture_click_new())
            gtk_widget_add_controller(storage.opaquePointer?.cast(), controller.opaquePointer)
            storage.fields["controller"] = controller
            let argCount = 3
            controller.connectSignal(name: "released", argCount: argCount, handler: handler)
        }
    }

    /// Add CSS classes to the app as soon as the view appears.
    /// - Parameter getString: Get the CSS.
    /// - Returns: A view.
    public func css(_ getString: @escaping () -> String) -> AnyView {
        inspectOnAppear { _ in
            let provider = gtk_css_provider_new()
            gtk_css_provider_load_from_string(
                provider,
                getString()
            )
            let display = gdk_display_get_default()
            gtk_style_context_add_provider_for_display(
                display,
                provider?.opaque(),
                .init(GTK_STYLE_PROVIDER_PRIORITY_APPLICATION)
            )
        }
    }

}
