//
//  ToolbarDemo.swift
//  Adwaita
//
//  Created by david-swift on 03.01.24.
//

// swiftlint:disable missing_docs

import Adwaita

struct ViewSwitcherDemo: View {

    var app: AdwaitaApp

    var view: Body {
        VStack {
            Button("View Demo") {
                app.showWindow("switcher-demo")
            }
            .suggested()
            .pill()
            .frame(maxWidth: 100)
        }
    }

    struct WindowContent: View {

        @State private var selection: ViewSwitcherView = .albums
        @State private var bottom = false

        var view: Body {
            VStack {
                Text(selection.title)
                    .padding()
                HStack {
                    Button(bottom ? "Show Top Bar" : "Show Bottom Bar") {
                        bottom.toggle()
                    }
                }
                .halign(.center)
            }
            .valign(.center)
            .topToolbar {
                if bottom {
                    HeaderBar
                        .empty()
                } else {
                    toolbar
                }
            }
            .bottomToolbar(visible: bottom) {
                toolbar
            }
        }

        var toolbar: AnyView {
            HeaderBar(titleButtons: !bottom) { } end: { }
                .headerBarTitle {
                    ViewSwitcher(selection: $selection)
                        .wideDesign(!bottom)
                }
        }

    }

    enum ViewSwitcherView: String, ViewSwitcherOption {

        case albums
        case artists
        case songs
        case playlists

        var title: String {
            rawValue.capitalized
        }

        var icon: Icon {
            .default(icon: {
                switch self {
                case .albums:
                    return .mediaOpticalCdAudio
                case .artists:
                    return .avatarDefault
                case .songs:
                    return .emblemMusic
                case .playlists:
                    return .viewList
                }
            }())
        }

        init?(title: String) {
            self.init(rawValue: title.lowercased())
        }

    }

}

// swiftlint:enable missing_docs
