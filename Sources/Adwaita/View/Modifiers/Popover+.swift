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
        appearFunctions.append { storage in
            storage.fields["visible"] = visible
            storage.connectSignal(name: "closed", id: "visible") {
                if let binding = storage.fields["visible"] as? Binding<Bool> {
                    if binding.wrappedValue {
                        binding.wrappedValue = false
                    }
                }
            }
        }
        updateFunctions.append { storage in
            if let binding = storage.fields["visible"] as? Binding<Bool> {
                if binding.wrappedValue {
                    gtk_popover_popup(storage.pointer?.cast())
                } else {
                    gtk_popover_popdown(storage.pointer?.cast())
                }
            }
        }
    }

}

extension View {

    /// Add a popover on top of the view.
    /// - Parameters:
    ///     - visible: Whether the popover is displayed.
    ///     - content: The popover's content.
    /// - Returns: The view.
    public func popover(visible: Binding<Bool>, @ViewBuilder content: @escaping () -> Body) -> View {
        overlay {
            Popover(visible: visible)
                .child(content)
        }
    }

}
