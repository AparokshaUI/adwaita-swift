//
//  Page.swift
//  Adwaita
//
//  Created by david-swift on 25.09.23.
//

// swiftlint:disable missing_docs implicitly_unwrapped_optional

import Adwaita

enum Page: String, Identifiable, CaseIterable {

    case welcome
    case counter
    case windows

    var id: Self {
        self
    }

    var label: String {
        rawValue.capitalized
    }

    @ViewBuilder
    func view(app: GTUIApp!) -> Body {
        switch self {
        case .welcome:
            WelcomeDemo()
        case .counter:
            CounterDemo()
        case .windows:
            WindowsDemo(app: app)
        }
    }

}

// swiftlint:enable missing_docs implicitly_unwrapped_optional
