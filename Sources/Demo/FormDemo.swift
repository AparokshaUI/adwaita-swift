//
//  FormDemo.swift
//  Adwaita
//
//  Created by david-swift on 03.01.24.
//

// swiftlint:disable missing_docs no_magic_numbers

import Adwaita

struct FormDemo: View {

    var app: AdwaitaApp

    var view: Body {
        VStack {
            Button("View Demo") {
                app.showWindow("form-demo")
            }
            .suggested()
            .pill()
            .frame(maxWidth: 100)
        }
    }

    struct WindowContent: View {

        @State private var text = "They also have a subtitle"
        @State private var password = "Password"
        @State private var value = 0
        @State private var isOn = true
        @State private var selection = "World"

        let values: [ListDemo.Element] = [.init(id: "Hello"), .init(id: "World")]

        var view: Body {
            ScrollView {
                VStack {
                    actionRows
                    FormSection("Entry Rows") {
                        Form {
                            EntryRow("Entry Row", text: $text)
                                .suffix {
                                    Button(icon: .default(icon: .editCopy)) { AdwaitaApp.copy(text) }
                                        .flat()
                                        .valign(.center)
                                }
                            EntryRow(password, text: $password)
                                .secure(text: $password)
                        }
                    }
                    .padding()
                    rowDemo("Spin Rows", row: SpinRow("Spin Row", value: $value, min: 0, max: 100).subtitle("\(value)"))
                    rowDemo("Switch Rows", row: SwitchRow("Switch Row", isOn: $isOn).subtitle(isOn ? "On" : "Off"))
                    rowDemo(
                        "Combo Rows",
                        row: ComboRow("Combo Row", selection: $selection, values: values).subtitle(selection)
                    )
                    rowDemo("Expander Rows", row: ExpanderRow().title("Expander Row").rows {
                        ActionRow("Hello")
                        ActionRow("World")
                    })
                }
                .padding()
                .frame(maxWidth: 400)
            }
            .topToolbar {
                HeaderBar.empty()
            }
        }

        var actionRows: AnyView {
            Form {
                ActionRow("Rows have a title")
                    .subtitle(text)
                ActionRow("Rows can have suffix widgets")
                    .suffix {
                        Button("Action") { }
                            .valign(.center)
                    }
            }
            .padding()
        }

        func rowDemo(_ title: String, row: AnyView) -> AnyView {
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
