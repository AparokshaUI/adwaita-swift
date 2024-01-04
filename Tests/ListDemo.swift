//
//  ListDemo.swift
//  Adwaita
//
//  Created by david-swift on 01.01.24.
//

// swiftlint:disable missing_docs

import Adwaita
import Foundation

struct ListDemo: View {

    @State private var items: [Element] = []
    @State private var selectedItem = ""

    var view: Body {
        HStack {
            Button("Add Row") {
                let element = Element(id: UUID().uuidString)
                items.append(element)
                selectedItem = element.id
            }
            Button("Delete Selected Row") {
                let index = items.firstIndex { $0.id == selectedItem }
                items = items.filter { $0.id != selectedItem }
                selectedItem = items[safe: index]?.id ?? items[safe: index ?? 0 - 1]?.id ?? items.first?.id ?? ""
            }
        }
        .padding()
        .style("linked")
        .halign(.center)
        if !items.isEmpty {
            List(items, selection: $selectedItem) { item in
                HStack {
                    Text("\(item.id)")
                        .hexpand()
                }
                .padding()
            }
            .valign(.center)
            .style("boxed-list")
            .padding()
        }
    }

    struct Element: Identifiable, CustomStringConvertible, Equatable {

        var id: String
        var description: String { id }

    }

}

// swiftlint:enable missing_docs
