//
//  main.swift
//  Adwaita
//
//  Created by david-swift on 05.08.23.
//

// swiftlint:disable missing_docs implicitly_unwrapped_optional no_magic_numbers

import Adwaita

@main
struct Counter: App {

    let id = "io.github.david-swift.Counter"
    var app: GTUIApp!

    var scene: Scene {
        Window(id: "toggle") { _ in
            Button("Add Window") {
                app.addWindow("content-view")
            }
            .padding()
            Button("Show Window") {
                app.showWindow("content-view")
            }
            .padding(10, .horizontal.add(.bottom))
        }
        Window(id: "content-view", open: 0) { _ in
            ContentView()
        }
    }

}

struct ContentView: View {

    @State private var count = 0

    var view: Body {
        HeaderBar.start {
            Button(icon: .default(icon: .goPrevious)) {
                count -= 1
            }
            Button(icon: .default(icon: .goNext)) {
                count += 1
            }
        }
        description
    }

    @ViewBuilder private var description: Body {
        VStack {
            switch count {
            case 1:
                Text("One")
                  .transition(.slideUp)
            case 0:
                Text("Zero")
            default:
                Text("Hello, world, \(count)!")
            }
        }
        .padding(50)
        .onUpdate {
            print(count)
        }
    }

}

// swiftlint:enable missing_docs implicitly_unwrapped_optional no_magic_numbers
