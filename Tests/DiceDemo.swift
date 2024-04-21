//
//  DiceDemo.swift
//  Adwaita
//
//  Created by david-swift on 12.10.23.
//

// swiftlint:disable missing_docs no_magic_numbers

import Adwaita

struct DiceDemo: View {

    @State private var number: Int?

    private var label: String {
        if let number {
            return "\(number)"
        } else {
            return "Roll the Dice!"
        }
    }

    var view: Body {
        VStack {
            Button(label) {
                number = .random(in: 1...6)
            }
            .style("pill")
            .style("suggested-action")
            .frame(maxWidth: 100)
        }
        .valign(.center)
        .padding()
    }

}

// swiftlint:enable missing_docs no_magic_numbers
