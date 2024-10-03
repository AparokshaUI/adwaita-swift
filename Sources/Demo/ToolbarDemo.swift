//
//  ToolbarDemo.swift
//  Adwaita
//
//  Created by david-swift on 12.10.23.
//

// swiftlint:disable missing_docs no_magic_numbers

import Adwaita

struct ToolbarDemo: View {

    var app: AdwaitaApp

    var view: Body {
        VStack {
            Button("View Demo") {
                app.showWindow("toolbar-demo")
            }
            .suggested()
            .pill()
            .frame(maxWidth: 100)
        }
    }

    struct WindowContent: View {

        @State private var visible = false
        @State private var moreContent = false

        var view: Body {
            VStack {
                Button("Toggle Toolbar") {
                    visible.toggle()
                }
                .suggested()
                .pill()
                .frame(maxWidth: 100)
                .padding(15)
            }
            .valign(.center)
            .bottomToolbar(visible: visible) {
                HeaderBar(titleButtons: false) {
                    Button(icon: .default(icon: .audioInputMicrophone)) { }
                } end: {
                    Button(icon: .default(icon: .userTrash)) { }
                }
                .headerBarTitle { }
            }
            .topToolbar {
                HeaderBar.empty()
            }
        }

    }

}

// swiftlint:enable missing_docs no_magic_numbers
