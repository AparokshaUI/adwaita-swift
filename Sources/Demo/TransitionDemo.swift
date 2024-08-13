//
//  TransitionDemo.swift
//  Adwaita
//
//  Created by david-swift on 12.10.23.
//

// swiftlint:disable missing_docs no_magic_numbers

import Adwaita

struct TransitionDemo: View {

    @State private var firstView = true

    var view: Body {
        VStack {
            if firstView {
                Text("First View")
                    .transition(.slideDown)
                    .accent()
            } else {
                Text("Second View")
                    .transition(.slideUp)
                    .success()
            }
        }
        .modifyContent(Text.self) { $0.title2().padding() }
        .card()
        .frame(maxWidth: 200)
        .padding()
        Button("Toggle View") {
            firstView.toggle()
        }
        .pill()
        .padding()
        .frame(maxWidth: 100)
    }

}

// swiftlint:enable missing_docs no_magic_numbers
