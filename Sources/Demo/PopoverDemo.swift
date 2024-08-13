//
//  PopoverDemo.swift
//  Adwaita
//
//  Created by david-swift on 10.02.24.
//

// swiftlint:disable missing_docs

import Adwaita

struct PopoverDemo: View {

    @State private var visible = false

    var view: Body {
        VStack {
            Button("Present Popover") {
                visible = true
            }
            .suggested()
            .pill()
            .frame(maxWidth: 100)
            .popover(visible: $visible) {
                CounterDemo()
            }
        }
    }

}

// swiftlint:enable missing_docs
