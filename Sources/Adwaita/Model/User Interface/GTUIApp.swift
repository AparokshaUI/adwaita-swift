//
//  GTUIApp.swift
//  Adwaita
//
//  Created by david-swift on 05.08.23.
//

import GTUI

/// The GTUI application.
public class GTUIApp: Application {

    /// The handlers which are called when a state changes.
    static var updateHandlers: [() -> Void] = []

    /// The app's content.
    var body: () -> App
    /// The scenes that are displayed.
    var sceneStorage: [WindowStorage] = []

    /// Initialize the GTUI application.
    /// - Parameters:
    ///     - id: The application id.
    ///     - body: The application's content.
    init(_ id: String, body: @escaping () -> App) {
        self.body = body
        super.init(name: id)
    }

    /// The entry point of the application.
    override public func onActivate() {
        let body = body()
        for windowScene in body.scene {
            let window = GTUI.Window(app: self)
            let child = windowScene.storage()
            let view = child.view
            window.setChild(view)
            sceneStorage.append(.init(window: window, view: child))
            window.show()
        }
    }
}
