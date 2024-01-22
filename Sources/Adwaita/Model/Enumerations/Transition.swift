//
//  Transition.swift
//  Adwaita
//
//  Created by david-swift on 21.01.24.
//

import CAdw

/// A transition for a stack.
public enum Transition: Int {

    // swiftlint:disable missing_docs discouraged_none_name
    case none
    case crossfade
    case slideRight, slideLeft, slideUp, slideDown, slideLeftRight, slideUpDown
    case coverUp, coverDown, coverLeft, coverRight
    case uncoverUp, uncoverDown, uncoverLeft, uncoverRight
    case coverUpDown, coverDownUp, coverLeftRight, coverRightLeft
    case rotateLeft, rotateRight, rotateLeftRight
    // swiftlint:enable missing_docs discouraged_none_name

    /// Get the GtkStackTransitionType transition.
    public var cTransition: GtkStackTransitionType {
        switch self {
        case .none:
            return GTK_STACK_TRANSITION_TYPE_NONE
        case .crossfade:
            return GTK_STACK_TRANSITION_TYPE_CROSSFADE
        case .slideRight:
            return GTK_STACK_TRANSITION_TYPE_SLIDE_RIGHT
        case .slideLeft:
            return GTK_STACK_TRANSITION_TYPE_SLIDE_LEFT
        case .slideUp:
            return GTK_STACK_TRANSITION_TYPE_SLIDE_UP
        case .slideDown:
            return GTK_STACK_TRANSITION_TYPE_SLIDE_DOWN
        case .slideLeftRight:
            return GTK_STACK_TRANSITION_TYPE_SLIDE_LEFT_RIGHT
        case .slideUpDown:
            return GTK_STACK_TRANSITION_TYPE_SLIDE_UP_DOWN
        case .coverUp:
            return GTK_STACK_TRANSITION_TYPE_OVER_UP
        case .coverDown:
            return GTK_STACK_TRANSITION_TYPE_OVER_DOWN
        case .coverLeft:
            return GTK_STACK_TRANSITION_TYPE_OVER_LEFT
        case .coverRight:
            return GTK_STACK_TRANSITION_TYPE_OVER_RIGHT
        case .uncoverUp:
            return GTK_STACK_TRANSITION_TYPE_UNDER_UP
        case .uncoverDown:
            return GTK_STACK_TRANSITION_TYPE_UNDER_DOWN
        case .uncoverLeft:
            return GTK_STACK_TRANSITION_TYPE_UNDER_LEFT
        case .uncoverRight:
            return GTK_STACK_TRANSITION_TYPE_UNDER_RIGHT
        case .coverUpDown:
            return GTK_STACK_TRANSITION_TYPE_OVER_UP_DOWN
        case .coverDownUp:
            return GTK_STACK_TRANSITION_TYPE_OVER_DOWN_UP
        case .coverLeftRight:
            return GTK_STACK_TRANSITION_TYPE_OVER_LEFT_RIGHT
        case .coverRightLeft:
            return GTK_STACK_TRANSITION_TYPE_OVER_RIGHT_LEFT
        case .rotateLeft:
            return GTK_STACK_TRANSITION_TYPE_ROTATE_LEFT
        case .rotateRight:
            return GTK_STACK_TRANSITION_TYPE_ROTATE_RIGHT
        case .rotateLeftRight:
            return GTK_STACK_TRANSITION_TYPE_ROTATE_LEFT_RIGHT
        }
    }

}
