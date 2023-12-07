//
//  OverlayWindowDemo.swift
//  Adwaita
//
//  Created by david-swift on 09.11.23.
//

// swiftlint:disable missing_docs implicitly_unwrapped_optional

import Adwaita

struct OverlayWindowDemo: View {

    var app: GTUIApp!
    var window: GTUIApplicationWindow

    var view: Body {
        VStack {
            Button("Show Window") {
                app.addWindow("overlay", parent: window)
            }
            .style("pill")
            .frame(maxSize: 100)
            .padding()
        }
    }

    struct WindowContent: View {

        var window: GTUIWindow

        var view: Body {
            VStack {
                Button("Close Window") {
                    window.close()
                }
                .style("pill")
                .padding()
                .frame(maxSize: 100)
            }
            .valign(.center)
            .topToolbar {
                HeaderBar.empty()
            }
        }

    }

}

// swiftlint:enable missing_docs implicitly_unwrapped_optional
