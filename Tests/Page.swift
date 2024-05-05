//
//  Page.swift
//  Adwaita
//
//  Created by david-swift on 25.09.23.
//

// swiftlint:disable missing_docs implicitly_unwrapped_optional

import Adwaita
import Foundation

enum Page: String, Identifiable, CaseIterable, Codable {

    case welcome
    case counter
    case windows
    case toolbar
    case transition
    case dice
    case dialog
    case alertDialog
    case toast
    case list
    case carousel
    case viewSwitcher
    case form
    case popover
    case flowBox
    case navigationView
    case picture
    case idle

    var id: Self {
        self
    }

    var label: String {
        switch self {
        case .viewSwitcher:
            return "View Switcher"
        case .flowBox:
            return "Flow Box"
        case .navigationView:
            return "Navigation View"
        case .alertDialog:
            return "Alert Dialog"
        default:
            return rawValue.capitalized
        }
    }

    var icon: Icon? {
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
            return "This is a collection of examples for the Swift Adwaita package"
        case .counter:
            return "A simple sample view"
        case .windows:
            return "Showcase window management"
        case .toolbar:
            return "Toggle the bottom toolbar"
        case .transition:
            return "A slide transition between two views"
        case .dice:
            return "Roll the dice"
        case .dialog:
            return "A window on top of another window"
        case .alertDialog:
            return "A dialog presenting a message or question"
        case .toast:
            return "Show a notification inside of your app"
        case .list:
            return "Organize content in multiple rows"
        case .carousel:
            return "Scroll horizontally on a touchpad or touchscreen, or scroll down on your mouse wheel"
        case .viewSwitcher:
            return "Switch the window's view"
        case .form:
            return "Group controls used for data entry"
        case .popover:
            return "Present content in a bubble-like context popup"
        case .flowBox:
            return "Display views in a reflowing grid"
        case .navigationView:
            return "A page-based navigation container"
        case .picture:
            return "Display an image"
        case .idle:
            return "Update UI from an asynchronous context"
        }
    }

    // swiftlint:disable cyclomatic_complexity
    @ViewBuilder
    func view(app: GTUIApp!, window: GTUIApplicationWindow, toast: Signal, pictureURL: URL?) -> Body {
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
        case .dialog:
            DialogDemo()
        case .alertDialog:
            AlertDialogDemo()
        case .toast:
            ToastDemo(toast: toast)
        case .list:
            ListDemo()
        case .carousel:
            CarouselDemo()
        case .viewSwitcher:
            ViewSwitcherDemo(app: app)
        case .form:
            FormDemo(app: app)
        case .popover:
            PopoverDemo()
        case .flowBox:
            FlowBoxDemo()
        case .navigationView:
            NavigationViewDemo(app: app)
        case .picture:
            PictureDemo(url: pictureURL, app: app, window: window)
        case .idle:
            IdleDemo()
        }
    }
    // swiftlint:enable cyclomatic_complexity

}

// swiftlint:enable missing_docs implicitly_unwrapped_optional
