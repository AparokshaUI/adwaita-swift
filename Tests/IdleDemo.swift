//
//  IdleDemo.swift
//  Adwaita
//
//  Created by david-swift on 05.05.24.
//

// swiftlint:disable missing_docs

import Adwaita

struct IdleDemo: View {

    @State private var progress = 0.0
    @State private var activeProcess = false
    let max = 500.0
    let delayFactor = 5_000.0
    let maxWidth = 300

    var view: Body {
        ProgressBar(value: progress, total: max)
            .vexpand()
            .valign(.center)
            .frame(maxWidth: maxWidth)
        Button("Play") {
            activeProcess = true
            progress = 0
            Task {
                Idle(delay: .init(delayFactor / max)) {
                    progress += 1
                    let done = progress == max
                    if done {
                        activeProcess = false
                    }
                    return !done
                }
            }
        }
        .padding()
        .pill()
        .hexpand()
        .halign(.center)
        .insensitive(activeProcess)
    }

}

// swiftlint:enable missing_docs
