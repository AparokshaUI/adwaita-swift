//
//  FixedDemo.swift
//  Adwaita
//
//  Created by david-swift on 21.07.24.
//

// swiftlint:disable missing_docs

import Adwaita
import Foundation

struct FixedDemo: View {

    @State private var button = (x: 0.0, y: 0.0)

    var view: Body {
        Fixed()
            .element(x: button.x, y: button.y, id: "button") {
                Button("Move") {
                    button = (x: Double.random(in: 0...100), y: Double.random(in: 0...100))
                }
            }
    }

}

// swiftlint:enable missing_docs
