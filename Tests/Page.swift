//
//  Page.swift
//  Adwaita
//
//  Created by david-swift on 25.09.23.
//

// swiftlint:disable missing_docs implicitly_unwrapped_optional

import Adwaita
import GTUI

enum Page: String, Identifiable, CaseIterable {

    case welcome
    case counter
    case windows
    case toolbar
    case transition
    case dice

    var id: Self {
        self
    }

    var label: String {
        rawValue.capitalized
    }

    var icon: GTUI.Icon? {
        switch self {
        case .welcome:
            return .default(icon: .gnomeAdwaita1Demo)
        default:
            return nil
        }
    }

    var description: String {
        switch self {
        case .welcome:
            return "This is a collection of examples for the Swift Adwaita package."
        case .counter:
            return "A simple sample view."
        case .windows:
            return "Showcase window management."
        case .toolbar:
            return "Toggle the bottom toolbar."
        case .transition:
            return "A slide transition between two views."
        case .dice:
            return "Roll the dice."
        }
    }

    @ViewBuilder
    func view(app: GTUIApp!) -> Body {
        switch self {
        case .welcome:
            []
        case .counter:
            CounterDemo()
        case .windows:
            WindowsDemo(app: app)
        case .toolbar:
            ToolbarDemo(app: app)
        case .transition:
            TransitionDemo()
        case .dice:
            DiceDemo()
        }
    }

}

// swiftlint:enable missing_docs implicitly_unwrapped_optional
