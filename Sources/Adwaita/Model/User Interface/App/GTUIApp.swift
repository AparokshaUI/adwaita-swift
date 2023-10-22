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
        for windowScene in body.scene.windows() {
            for _ in 0..<windowScene.open {
                sceneStorage.append(windowScene.createWindow(app: self))
            }
        }
    }

    /// Focus the window with a certain id. Create the window if it doesn't already exist.
    /// - Parameters:
    ///     - id: The window's id.
    public func showWindow(_ id: String) {
        sceneStorage.last { $0.id == id && !$0.destroy }?.window.show() ?? addWindow(id)
    }

    /// Add a new window with the content of the window with a certain id.
    /// - Parameters:
    ///     - id: The window's id.
    public func addWindow(_ id: String) {
        if let window = body().scene.windows().first(where: { $0.id == id }) {
            sceneStorage.append(window.createWindow(app: self))
            showWindow(id)
        }
    }
}
