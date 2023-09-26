//
//  WindowsDemo.swift
//  Adwaita
//
//  Created by david-swift on 25.09.23.
//

// swiftlint:disable missing_docs implicitly_unwrapped_optional no_magic_numbers

import Adwaita

struct WindowsDemo: View {

    var app: GTUIApp!

    var view: Body {
        VStack {
            Button("Show Window") {
                app.showWindow("content")
            }
            .padding()
            Button("Add Window") {
                app.addWindow("main")
            }
            .padding(10, .horizontal.add(.bottom))
        }
        .topToolbar {
            HeaderBar.empty()
        }
    }

}

// swiftlint:enable missing_docs implicitly_unwrapped_optional no_magic_numbers
