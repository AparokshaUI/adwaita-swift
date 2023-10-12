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
                content("First View")
                    .transition(.slideDown)
                    .style("accent")
            } else {
                content("Second View")
                    .transition(.slideUp)
                    .style("success")
            }
        }
        .style("card")
        .frame(maxSize: 200)
        .padding()
        Button("Toggle View") {
            firstView.toggle()
        }
        .style("pill")
        .padding()
        .frame(maxSize: 100)
    }

    private func content(_ text: String) -> View {
        Text(text)
            .style("title-2")
            .padding()
    }

}

// swiftlint:enable missing_docs no_magic_numbers
