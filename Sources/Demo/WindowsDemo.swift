//
//  WindowsDemo.swift
//  Adwaita
//
//  Created by david-swift on 25.09.23.
//

// swiftlint:disable missing_docs implicitly_unwrapped_optional

import Adwaita

struct WindowsDemo: View {

    var app: AdwaitaApp!

    var view: Body {
        HStack {
            VStack {
                Button("Show Window") {
                    app.showWindow("content")
                }
                .hexpand()
                Button("Add Window") {
                    app.addWindow("main")
                }
                .hexpand()
            }
            .linked()
            .valign(.center)
            .padding()
        }
        .frame(maxWidth: 100)
    }

    struct WindowContent: View {

        var view: Body {
            Text("This window exists at most once.")
                .padding()
                .topToolbar {
                    HeaderBar.empty()
                }
        }

    }

}

// swiftlint:enable missing_docs implicitly_unwrapped_optional
