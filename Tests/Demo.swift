//
//  Demo.swift
//  Adwaita
//
//  Created by david-swift on 25.09.23.
//

// swiftlint:disable missing_docs implicitly_unwrapped_optional no_magic_numbers

import Adwaita
import Foundation

@main
struct Demo: App {

    let id = "io.github.AparokshaUI.Demo"
    var app: GTUIApp!

    @State private var pictureURL: URL?

    var scene: Scene {
        Window(id: "main") { window in
            DemoContent(window: window, app: app, pictureURL: pictureURL)
        }
        .devel()
        HelperWindows()
        FileDialog(importer: "picture", extensions: ["jpg", "jpeg", "png", "svg"]) { pictureURL = $0 } onClose: { }
    }

    struct HelperWindows: WindowSceneGroup {

        var scene: Scene {
            Window(id: "content", open: 0) { _ in
                WindowsDemo.WindowContent()
            }
            .resizable(false)
            .closeShortcut()
            .defaultSize(width: 400, height: 250)
            Window(id: "toolbar-demo", open: 0) { _ in
                ToolbarDemo.WindowContent().stopModifiers()
            }
            .closeShortcut()
            .defaultSize(width: 400, height: 250)
            .title("Toolbar Demo")
            Window(id: "switcher-demo", open: 0) { _ in
                ViewSwitcherDemo.WindowContent()
            }
            .closeShortcut()
            .defaultSize(width: 600, height: 400)
            .resizable(false)
            .title("View Switcher Demo")
            Window(id: "form-demo", open: 0) { _ in
                FormDemo.WindowContent()
            }
            .closeShortcut()
            .defaultSize(width: 400, height: 250)
            .title("Form Demo")
            Window(id: "binding-reactor-demo", open: 0) { _ in
                BindingReactorDemo.WindowContent()
            }
            .closeShortcut()
            .defaultSize(width: 400, height: 250)
            .title("Binding Reactor Demo")

            Window(id: "navigation", open: 0) { _ in
                NavigationViewDemo.WindowContent()
            }
            .closeShortcut()
            .title("Navigation View Demo")
        }

    }

    struct DemoContent: WindowView {

        @State("selection")
        private var selection: Page = .welcome
        @State private var toast: Signal = .init()
        @State("sidebar-visible")
        private var sidebarVisible = true
        @State("width")
        private var width = 650
        @State("height")
        private var height = 450
        @State("maximized")
        private var maximized = false
        @State private var about = false
        var window: GTUIApplicationWindow
        var app: GTUIApp!
        var pictureURL: URL?

        var view: Body {
            OverlaySplitView(visible: $sidebarVisible) {
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
                        menu
                    }
                    .headerBarTitle {
                        WindowTitle(subtitle: "", title: "Demo")
                    }
                }
            } content: {
                ViewStack(element: selection) { selection in
                    StatusPage(
                        selection.label,
                        icon: selection.icon,
                        description: selection.description
                    ) { selection.view(app: app, window: window, toast: toast, pictureURL: pictureURL) }
                    .topToolbar {
                        HeaderBar {
                            Toggle(icon: .default(icon: .sidebarShow), isOn: $sidebarVisible)
                                .tooltip("Toggle Sidebar")
                        } end: {
                            if sidebarVisible {
                                Text("").transition(.crossfade)
                            } else {
                                menu.transition(.crossfade)
                            }
                        }
                        .headerBarTitle {
                            if sidebarVisible {
                                Text("")
                                    .transition(.crossfade)
                            } else {
                                WindowTitle(subtitle: "Demo", title: selection.label)
                                    .transition(.crossfade)
                            }
                        }
                    }
                    .toast("This is a toast!", signal: toast)
                }
            }
            .aboutDialog(
                visible: $about,
                app: "Demo",
                developer: "david-swift",
                version: "Test",
                icon: .default(icon: .applicationXExecutable),
                website: .init(string: "https://aparokshaui.github.io/adwaita-swift/"),
                issues: .init(string: "https://github.com/AparokshaUI/adwaita-swift/issues")
            )
        }

        var menu: View {
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
                    MenuButton("About") { about = true }
                    MenuButton("Quit", window: false) { app.quit() }
                        .keyboardShortcut("q".ctrl())
                }
            }
            .primary()
            .tooltip("Main Menu")
        }

        func window(_ window: Window) -> Window {
            window
                .size(width: $width, height: $height)
                .maximized($maximized)
        }

    }

}

// swiftlint:enable missing_docs implicitly_unwrapped_optional no_magic_numbers
