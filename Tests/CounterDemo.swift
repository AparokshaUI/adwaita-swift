//
//  CounterDemo.swift
//  Adwaita
//
//  Created by david-swift on 25.09.23.
//

// swiftlint:disable missing_docs

import Adwaita

struct CounterDemo: View {

    @State("count", folder: "io.github.AparokshaUI.Demo/count")
    private var count = 0

    var view: Body {
        VStack {
            HStack {
                CountButton(count: $count, icon: .goPrevious) { $0 -= 1 }
                Text("\(count)")
                    .title1()
                    .frame(minWidth: 100)
                CountButton(count: $count, icon: .goNext) { $0 += 1 }
            }
            .halign(.center)
        }
        .valign(.center)
        .padding()
    }

    private struct CountButton: View {

        @Binding var count: Int
        var icon: Icon.DefaultIcon
        var action: (inout Int) -> Void

        var view: Body {
            Button(icon: .default(icon: icon)) {
                action(&count)
            }
            .circular()
        }
    }

}

// swiftlint:enable missing_docs
