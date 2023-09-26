//
//  WelcomeDemo.swift
//  Adwaita
//
//  Created by david-swift on 25.09.23.
//

// swiftlint:disable missing_docs

import Adwaita

struct WelcomeDemo: View {

    @State private var test = false

    var view: Body {
        StatusPage(
            "Swift Adwaita Demo",
            icon: .default(icon: .gnomeAdwaita1Demo),
            description: "This is a collection of examples for the Swift Adwaita package."
        )
        .topToolbar {
            HeaderBar.empty()
        }
    }

}

// swiftlint:enable missing_docs
