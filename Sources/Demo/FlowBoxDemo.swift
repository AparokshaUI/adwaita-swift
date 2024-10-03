//
//  ListDemo.swift
//  Adwaita
//
//  Created by david-swift on 01.01.24.
//

// swiftlint:disable missing_docs no_magic_numbers

import Adwaita
import Foundation

struct FlowBoxDemo: View {

    @State private var items: [ListDemo.Element] = []
    @State private var selectedItem = ""

    var view: Body {
        HStack {
            Button("Add Element") {
                let element = ListDemo.Element(id: UUID().uuidString)
                items.append(element)
                selectedItem = element.id
            }
            Button("Delete Selected Element") {
                let index = items.firstIndex { $0.id == selectedItem }
                items = items.filter { $0.id != selectedItem }
                selectedItem = items[safe: index]?.id ?? items[safe: index ?? 0 - 1]?.id ?? items.first?.id ?? ""
            }
        }
        .linked()
        .padding()
        .halign(.center)
        if !items.isEmpty {
            FlowBox(items, selection: $selectedItem) { item in
                HStack {
                    Text(.init("\(item.id)".prefix(5)))
                        .hexpand()
                }
                .padding()
            }
            .valign(.center)
            .padding()
        }
    }

}

// swiftlint:enable missing_docs no_magic_numbers
