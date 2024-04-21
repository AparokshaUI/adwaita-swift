//
//  AlertDialogDemo.swift
//  Adwaita
//
//  Created by david-swift on 05.04.24.
//

// swiftlint:disable missing_docs

import Adwaita

struct AlertDialogDemo: View {

    @State private var dialog = false
    let padding = 20

    var view: Body {
        VStack {
            Button("Show Dialog") {
                dialog = true
            }
            .style("pill")
            .frame(maxWidth: 100)
            .padding()
        }
        .alertDialog(visible: $dialog, heading: "Alert Dialog", body: "This is an alert dialog")
        .response("Cancel", role: .close) {
            print("Cancel")
        }
        .response("Done", appearance: .suggested, role: .default) {
            print("Done")
        }
    }

}

// swiftlint:enable missing_docs
