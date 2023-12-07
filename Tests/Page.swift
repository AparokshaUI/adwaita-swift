//
//  Page.swift
//  Adwaita
//
//  Created by david-swift on 25.09.23.
//

// swiftlint:disable missing_docs implicitly_unwrapped_optional

import Adwaita
import Libadwaita

enum Page: String, Identifiable, CaseIterable {

    case welcome
    case counter
    case windows
    case toolbar
    case transition
    case dice
    case overlayWindow
    case toast

    var id: Self {
        self
    }

    var label: String {
        switch self {
        case .overlayWindow:
            return "Overlay Window"
        default:
            return rawValue.capitalized
        }
    }

    var icon: Libadwaita.Icon? {
        switch self {
        case .welcome:
            return .default(icon: .emojiNature)
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
        case .overlayWindow:
            return "A window on top of another window."
        case .toast:
            return "Show a notification inside of your app."
        }
    }

    @ViewBuilder
    func view(app: GTUIApp!, window: GTUIApplicationWindow, toast: Signal) -> Body {
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
        case .overlayWindow:
            OverlayWindowDemo(app: app, window: window)
        case .toast:
            ToastDemo(toast: toast)
        }
    }

}

// swiftlint:enable missing_docs implicitly_unwrapped_optional
