//
//  ToastDemo.swift
//  Adwaita
//
//  Created by david-swift on 30.11.23.
//

// swiftlint:disable missing_docs

import Adwaita

struct ToastDemo: View {

    var toast: Signal

    var view: Body {
        VStack {
            Button("Add Toast") {
                toast.signal()
            }
            .suggested()
            .pill()
            .frame(maxWidth: 100)
        }
    }

}

// swiftlint:enable missing_docs
