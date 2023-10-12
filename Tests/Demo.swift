//
//  Demo.swift
//  Adwaita
//
//  Created by david-swift on 25.09.23.
//

// swiftlint:disable missing_docs implicitly_unwrapped_optional no_magic_numbers

import Adwaita

@main
struct Demo: App {

    let id = "io.github.david-swift.Demo"
    var app: GTUIApp!
    @State private var toolbar = false

    var scene: Scene {
        Window(id: "main") { window in
            DemoContent(window: window, app: app)
        }
        HelperWindows()
    }

    struct HelperWindows: WindowSceneGroup {

        var scene: Scene {
            Window(id: "content", open: 0) { window in
                WindowsDemo.WindowContent(window: window)
            }
            Window(id: "toolbar-demo", open: 0) { window in
                ToolbarDemo.WindowContent(window: window)
            }
        }

    }

    struct DemoContent: View {

        @State private var selection: Page = .welcome
        var window: GTUIWindow
        var app: GTUIApp!

        var view: Body {
            NavigationSplitView {
                ScrollView {
                    List(Page.allCases, selection: $selection) { element in
                        Text(element.label)
                            .halign(.start)
                            .padding()
                    }
                    .sidebarStyle()
                }
                .topToolbar {
                    HeaderBar.empty()
                }
                .navigationTitle("Demo")
            } content: {
                StatusPage(
                    selection.label,
                    icon: selection.icon,
                    description: selection.description
                ) {
                    selection.view(app: app)
                }
                .topToolbar {
                    HeaderBar.empty()
                }
            }
            .onAppear {
                window.setDefaultSize(width: 650, height: 450)
            }
        }

    }

}

// swiftlint:enable missing_docs implicitly_unwrapped_optional no_magic_numbers
