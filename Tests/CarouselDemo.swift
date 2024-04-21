//
//  CarouselDemo.swift
//  Adwaita
//
//  Created by david-swift on 01.01.24.
//

// swiftlint:disable missing_docs no_magic_numbers

import Adwaita
import Foundation

struct CarouselDemo: View {

    @State private var items: [ListDemo.Element] = [.init(id: "Hello"), .init(id: "World")]

    var view: Body {
        Button("Add Card") {
            let element = ListDemo.Element(id: UUID().uuidString)
            items.append(element)
        }
        .padding()
        .halign(.center)
        Carousel(items) { element in
            VStack {
                Text(element.id)
                    .vexpand()
                Button("Delete") {
                    items = items.filter { $0.id != element.id }
                }
                .padding()
            }
            .vexpand()
            .hexpand()
            .style("card")
            .onClick { print(element.id) }
            .padding(20)
            .frame(minWidth: 300, minHeight: 200)
            .frame(maxWidth: 500)
        }
        .longSwipes()
    }

}

// swiftlint:enable missing_docs no_magic_numbers
