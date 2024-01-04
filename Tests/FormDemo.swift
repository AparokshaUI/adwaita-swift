//
//  FormDemo.swift
//  Adwaita
//
//  Created by david-swift on 03.01.24.
//

// swiftlint:disable missing_docs no_magic_numbers

import Adwaita
import Libadwaita

struct FormDemo: View {

    var app: GTUIApp

    var view: Body {
        VStack {
            Button("View Demo") {
                app.showWindow("form-demo")
            }
            .style("suggested-action")
            .frame(maxSize: 100)
        }
    }

    struct WindowContent: View {

        @State private var text = "They also have a subtitle"
        @State private var password = "Password"
        @State private var value = 0
        @State private var isOn = true
        @State private var selection = "Hello"

        let values: [ListDemo.Element] = [.init(id: "Hello"), .init(id: "World")]

        var view: Body {
            ScrollView {
                VStack {
                    Form {
                        ActionRow("Rows have a title")
                            .subtitle(text)
                        ActionRow("Rows can have suffix widgets")
                            .suffix {
                                Button("Action") { }
                                    .verticalCenter()
                            }
                    }
                    .padding()
                    FormSection("Entry Rows") {
                        Form {
                            EntryRow("Entry Row", text: $text)
                                .suffix {
                                    Button(icon: .default(icon: .editCopy)) { Clipboard.copy(text) }
                                        .style("flat")
                                        .verticalCenter()
                                }
                            EntryRow("Password", text: $password)
                                .secure()
                        }
                    }
                    .padding()
                    rowDemo("Spin Rows", row: SpinRow("Spin Row", value: $value, min: 0, max: 100))
                    rowDemo("Switch Rows", row: SwitchRow("Switch Row", isOn: $isOn))
                    rowDemo("Combo Rows", row: ComboRow("Combo Row", selection: $selection, values: values))
                }
                .padding()
                .frame(maxSize: 400)
            }
            .topToolbar {
                HeaderBar.empty()
            }
        }

        func rowDemo(_ title: String, row: View) -> View {
            FormSection(title) {
                Form {
                    row
                }
            }
            .padding()
        }

    }

}

// swiftlint:enable missing_docs no_magic_numbers
