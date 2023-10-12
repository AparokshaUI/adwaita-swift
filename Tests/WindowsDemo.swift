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
            .valign(.center)
            .style("linked")
            .padding()
        }
        .frame(maxSize: 100)
    }

    struct WindowContent: View {

        var window: GTUIWindow

        var view: Body {
            Text("This window exists at most once.")
                .padding()
                .topToolbar {
                    HeaderBar.empty()
                }
                .onAppear {
                    window.setDefaultSize(width: 400, height: 250)
                }
        }

    }

}

// swiftlint:enable missing_docs implicitly_unwrapped_optional no_magic_numbers
