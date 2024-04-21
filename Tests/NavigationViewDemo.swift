//
//  NavigationViewDemo.swift
//  Adwaita
//
//  Created by david-swift on 17.02.24.
//

// swiftlint:disable missing_docs

import Adwaita

struct NavigationViewDemo: View {

    var app: GTUIApp

    var view: Body {
        VStack {
            Button("View Demo") {
                app.showWindow("navigation")
            }
            .style("suggested-action")
            .frame(maxWidth: 100)
            .padding()
        }
    }

    struct WindowContent: View {

        @State private var stack = NavigationStack<Int>()
        let spacing = 10

        var view: Body {
            NavigationView($stack, "Initial View") { component in
                VStack {
                    Button("Add Next View") {
                        stack.push(component + 1)
                    }
                    Button("Pop View") {
                        stack.pop()
                    }
                }
                .spacing(spacing)
                .padding()
                .topToolbar {
                    HeaderBar.empty()
                }
            } initialView: {
                VStack {
                    Button("Add First View") {
                        stack.push(1)
                    }
                    .padding()
                }
                .topToolbar {
                    HeaderBar.empty()
                }
            }
        }

    }

}

// swiftlint:enable missing_docs
