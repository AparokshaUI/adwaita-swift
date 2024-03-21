//
//  DialogDemo.swift
//  Adwaita
//
//  Created by david-swift on 20.13.24.
//

// swiftlint:disable missing_docs

import Adwaita

struct DialogDemo: View {

    @State private var dialog = false
    let padding = 20

    var view: Body {
        VStack {
            Button("Show Dialog") {
                dialog = true
            }
            .style("pill")
            .frame(maxSize: 100)
            .padding()
        }
        .dialog(visible: $dialog, title: "Counter") {
            CounterDemo()
                .padding(padding)
                .topToolbar {
                    HeaderBar.empty()
                }
        }
    }

}

// swiftlint:enable missing_docs
