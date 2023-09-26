//
//  CounterDemo.swift
//  Adwaita
//
//  Created by david-swift on 25.09.23.
//

// swiftlint:disable missing_docs

import Adwaita

struct CounterDemo: View {

    @State private var count = 0

    var view: Body {
        description
            .topToolbar {
                HeaderBar.start {
                    Button(icon: .default(icon: .goPrevious)) {
                        count -= 1
                    }
                    Button(icon: .default(icon: .goNext)) {
                        count += 1
                    }
                }
            }
    }

    @ViewBuilder private var description: Body {
        Text("\(count)")
            .style("title-1")
    }

}

// swiftlint:enable missing_docs
