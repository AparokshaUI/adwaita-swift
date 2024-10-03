//
//  Clamp+.swift
//  Adwaita
//
//  Created by david-swift on 20.01.24.
//

import CAdw

extension Clamp {

    /// Initialize either a horizontal or vertical clamp.
    /// - Parameter vertical: Whether it is a vertical clamp.
    init(vertical: Bool) {
        self.init()
        if vertical {
            appearFunctions.append { storage, _ in
                gtk_orientable_set_orientation(storage.opaquePointer, GTK_ORIENTATION_VERTICAL)
            }
        }
    }

}

extension AnyView {

    /// Set the view's maximum width.
    /// - Parameter maxWidth: The maximum width.
    /// - Returns: A view.
    public func frame(maxWidth: Int? = nil) -> Clamp {
        .init()
            .child { self }
            .maximumSize(maxWidth ?? -1)
    }

    /// Set the view's maximum height.
    /// - Parameter maxHeight: The maximum height.
    /// - Returns: A view.
    public func frame(maxHeight: Int? = nil) -> Clamp {
        .init(vertical: true)
            .child { self }
            .maximumSize(maxHeight ?? -1)
    }

}
