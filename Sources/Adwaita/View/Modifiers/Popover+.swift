//
//  Popover+.swift
//  Adwaita
//
//  Created by david-swift on 10.02.24.
//

import CAdw

extension Popover {

    /// Initialize either a horizontal or vertical clamp.
    /// - Parameter vertical: Whether it is a vertical clamp.
    init(visible: Binding<Bool>) {
        self.init()
        updateFunctions.append { storage, _, _ in
            storage.connectSignal(name: "closed", id: "visible") {
                if visible.wrappedValue {
                    visible.wrappedValue = false
                }
            }
            if visible.wrappedValue {
                gtk_popover_popup(storage.opaquePointer?.cast())
            } else {
                gtk_popover_popdown(storage.opaquePointer?.cast())
            }
        }
    }

}

extension AnyView {

    /// Add a popover on top of the view.
    /// - Parameters:
    ///     - visible: Whether the popover is displayed.
    ///     - content: The popover's content.
    /// - Returns: The view.
    public func popover(visible: Binding<Bool>, @ViewBuilder content: @escaping () -> Body) -> Overlay {
        overlay {
            Popover(visible: visible)
                .child(content)
        }
    }

}
