//
//  VStack.swift
//  Adwaita
//
//  Created by david-swift on 23.08.23.
//

import CAdw

/// A GtkBox equivalent.
public typealias VStack = Box

extension VStack {

    /// Initialize a `VStack`.
    /// - Parameter content: The view content.
    public init(@ViewBuilder content: @escaping () -> Body) {
        self.init(horizontal: false, content: content)
    }

    init(horizontal: Bool, @ViewBuilder content: @escaping () -> Body) {
        self.init(spacing: 0)
        self = self.append(content)
        if horizontal {
            appearFunctions.append { storage, _ in
                gtk_orientable_set_orientation(storage.pointer, GTK_ORIENTATION_HORIZONTAL)
            }
        }
    }

    /// Link the children.
    public func linked(_ active: Bool = true) -> View {
        style("linked", active: active)
    }

}
