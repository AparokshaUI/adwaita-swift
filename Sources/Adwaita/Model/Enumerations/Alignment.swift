//
//  Alignment.swift
//  Adwaita
//
//  Created by david-swift on 21.01.24.
//

import CAdw

/// The alignment for a widget.
public enum Alignment: Int {

    /// The widget will fill the available space.
    case fill
    /// The widget will start at the beginning of the available space.
    case start
    /// The widget will end at the end of the available space.
    case end
    /// The widget will be centered in the available space.
    case center
    /// The widget will be baseline aligned in the available space.
    case baselineFill
    /// The widget will be baseline aligned at the start of the available space.
    case baselineCenter

    /// Get the GtkAlign alignment.
    public var cAlign: GtkAlign {
        switch self {
        case .fill:
            return GTK_ALIGN_FILL
        case .start:
            return GTK_ALIGN_START
        case .end:
            return GTK_ALIGN_END
        case .center:
            return GTK_ALIGN_CENTER
        case .baselineFill:
            return GTK_ALIGN_BASELINE_FILL
        case .baselineCenter:
            return GTK_ALIGN_BASELINE_CENTER
        }
    }

}
