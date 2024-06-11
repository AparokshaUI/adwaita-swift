//
//  GTUIApp.swift
//  Adwaita
//
//  Created by david-swift on 05.08.23.
//

import CAdw

/// The GTUI application.
public class GTUIApp {

    /// The handlers which are called when a state changes.
    static var updateHandlers: [(Bool) -> Void] = []
    /// The app's id for the file name for storing the data.
    static var appID: String?
    /// The pointer to the application.
    public var pointer: UnsafeMutablePointer<GtkApplication>?
    /// Fields for additional information.
    public var fields: [String: Any] = [:]

    /// The app's content.
    var body: () -> App
    /// The scenes that are displayed.
    var sceneStorage: [WindowStorage] = []
    /// A string signaling that the parent should not be overwritten.
    let overwriteParentID = "overwrite-parent"

    /// Initialize the GTUI application.
    /// - Parameters:
    ///     - id: The application id.
    ///     - body: The application's content.
    init(_ id: String, body: @escaping () -> App) {
        self.body = body
        self.pointer = adw_application_new(id, G_APPLICATION_DEFAULT_FLAGS)?.cast()
    }

    /// The entry point of the application.
    public func onActivate() {
        let body = body()
        for windowScene in body.scene.windows() {
            for _ in 0..<windowScene.open {
                addWindow(windowScene.id)
            }
            setParentWindows()
        }
    }

    /// Run the application.
    /// - Parameters:
    ///     - automaticSetup: Whether the initial windows should be added.
    ///     - manualSetup: A closure that is executed in the main loop.
    public func run(automaticSetup: Bool = true, manualSetup: @escaping () -> Void = { }) {
        let data = ViewStorage.SignalData {
            if automaticSetup {
                self.onActivate()
            }
            manualSetup()
        }
        fields["run"] = data
        g_signal_connect_data(
            pointer?.cast(),
            "activate",
            unsafeBitCast(data.handler, to: GCallback.self),
            Unmanaged.passUnretained(data).toOpaque().cast(),
            nil,
            G_CONNECT_AFTER
        )
        g_application_run(pointer?.cast(), 0, nil)
    }

    /// Add a keyboard shortcut to the application.
    /// - Parameters:
    ///     - shortcut: The keyboard shortcut.
    ///     - id: The action's id.
    ///     - window: Optionally an application window.
    ///     - handler: The action's handler.
    public func addKeyboardShortcut(
        _ shortcut: String,
        id: String,
        window: GTUIApplicationWindow? = nil,
        handler: @escaping () -> Void
    ) {
        let action = g_simple_action_new(id, nil)
        let data = ViewStorage.SignalData(closure: handler)
        g_signal_connect_data(
            action?.cast(),
            "activate",
            unsafeBitCast(data.threeParamsHandler, to: GCallback.self),
            Unmanaged.passUnretained(data).toOpaque().cast(),
            nil,
            G_CONNECT_AFTER
        )
        if let window {
            g_action_map_add_action(.init(window.pointer), action)
            window.fields[id] = data
        } else {
            g_action_map_add_action(.init(pointer), action)
            fields[id] = data
        }
        gtk_application_set_accels_for_action(pointer, (window == nil ? "app." : "win.") + id, [shortcut].cArray)
    }

    /// Remove a keyboard shortcut from the application.
    /// - Parameters:
    ///     - id: The keyboard shortcut's id.
    ///     - window: Optionally an application window.
    public func removeKeyboardShortcut(
        id: String,
        window: GTUIApplicationWindow? = nil
    ) {
        if let window {
            g_action_map_remove_action(.init(window.pointer), id)
            window.fields.removeValue(forKey: id)
        } else {
            g_action_map_remove_action(.init(pointer), id)
            fields.removeValue(forKey: id)
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
    ///     - parent: The parent window.
    public func addWindow(_ id: String, parent: GTUIWindow? = nil) {
        State<Any>.updateViews()
        if let window = body().scene.windows().last(where: { $0.id == id }) {
            let window = window.createWindow(app: self)
            sceneStorage.append(window)
            if let parent {
                window.window.setParentWindow(parent)
                window.window.fields[overwriteParentID] = true
            }
            setParentWindows()
            showWindow(id)
        }
    }

    /// Set the parents of every window having a parent window.
    func setParentWindows() {
      for window in sceneStorage where !(window.window.fields[overwriteParentID] as? Bool ?? false) {
        if let parent = sceneStorage.first(where: { $0.id == window.parentID }) {
            window.window.setParentWindow(parent.window)
        }
      }
    }

    /// Terminate the application.
    public func quit() {
        g_application_quit(pointer?.cast())
    }

}
