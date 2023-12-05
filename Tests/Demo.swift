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

    let id = "io.github.AparokshaUI.Demo"
    var app: GTUIApp!
    @State private var toolbar = false

    var scene: Scene {
        Window(id: "main") { window in
            DemoContent(window: window, app: app)
        }
        .overlay {
            AboutWindow(id: "about", appName: "Demo", developer: "david-swift", version: "Test")
                .icon(.default(icon: .emojiNature))
                .website(.init(string: "david-swift.gitbook.io/adwaita"))
            Window(id: "overlay", open: 0) { window in
                OverlayWindowDemo.WindowContent(window: window)
            }
            .keyboardShortcut("Escape") { $0.close() }
        }
        HelperWindows()
    }

    struct HelperWindows: WindowSceneGroup {

        var scene: Scene {
            Window(id: "content", open: 0) { window in
                WindowsDemo.WindowContent(window: window)
            }
            .closeShortcut()
            Window(id: "toolbar-demo", open: 0) { window in
                ToolbarDemo.WindowContent(window: window)
            }
            .closeShortcut()
        }

    }

    struct DemoContent: View {

        @State private var selection: Page = .welcome
        @State private var toast: Signal = .init()
        var window: GTUIApplicationWindow
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
                    HeaderBar.end {
                        Menu(icon: .default(icon: .openMenu), app: app, window: window) {
                            MenuButton("New Window", window: false) {
                                app.addWindow("main")
                            }
                            .keyboardShortcut("n".ctrl())
                            MenuButton("Close Window") {
                                window.close()
                            }
                            .keyboardShortcut("w".ctrl())
                            MenuSection {
                                MenuButton("About", window: false) { app.showWindow("about") }
                                MenuButton("Quit", window: false) { app.quit() }
                                    .keyboardShortcut("q".ctrl())
                            }
                        }
                    }
                }
                .navigationTitle("Demo")
            } content: {
                StatusPage(
                    selection.label,
                    icon: selection.icon,
                    description: selection.description
                ) {
                    selection.view(app: app, toast: toast)
                }
                .topToolbar {
                    HeaderBar.empty()
                }
                .toast("This is a toast!", signal: toast)
            }
            .onAppear {
                window.setDefaultSize(width: 650, height: 450)
            }
        }

    }

}

// swiftlint:enable missing_docs implicitly_unwrapped_optional no_magic_numbers
