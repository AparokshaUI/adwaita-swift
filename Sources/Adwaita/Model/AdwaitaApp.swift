//
//  AdwaitaApp.swift
//  Adwaita
//
//  Created by david-swift on 31.07.2024.
//

import CAdw
import Foundation
@_exported import Meta
@_exported import MetaSQLite

/// The Meta app storage for the Adwaita backend.
public class AdwaitaApp: AppStorage {

    /// The scene element type of the Adwaita backend.
    public typealias SceneElementType = AdwaitaSceneElement
    /// The widget type of the Adwaita backend.
    public typealias WidgetType = AdwaitaWidget
    /// The wrapper type of the Adwaita backend.
    public typealias WrapperType = VStack

    /// The app storage.
    public var storage: StandardAppStorage = .init()
    /// The signal data for running.
    var runSignal: SignalData?
    /// The application's pointer.
    var pointer: UnsafeMutablePointer<GtkApplication>?
    /// Fields for storing closure data.
    var signals: [String: SignalData] = [:]

    /// Initialize the app storage.
    /// - Parameter id: The identifier.
    public required init(id: String) {
        pointer = adw_application_new(id, G_APPLICATION_DEFAULT_FLAGS)?.cast()
        DatabaseInformation.setPath(Self.userDataDir().appendingPathComponent("data.sqlite").path)
    }

    /// Copy a string to the clipboard.
    public static func copy(_ text: String) {
        let clipboard = gdk_display_get_clipboard(gdk_display_get_default())
        gdk_clipboard_set_text(clipboard, text)
    }

    /// The directory used for storing user data.
    /// - Returns: The URL.
    public static func userDataDir() -> URL {
        .init(fileURLWithPath: .init(cString: g_get_user_data_dir()))
    }

    /// Execute the app.
    /// - Parameter setup: Set the scene elements up.
    public func run(setup: @escaping () -> Void) {
        let data = SignalData {
            setup()
        }
        runSignal = data
        data.connect(pointer: pointer, signal: "activate")
        g_application_run(pointer?.cast(), 0, nil)
    }

    /// Quit the app.
    public func quit() {
        g_application_quit(pointer?.cast())
    }

    /// Add a keyboard shortcut to the application.
    /// - Parameters:
    ///     - shortcut: The keyboard shortcut.
    ///     - id: The action's id.
    ///     - window: Optionally an application window.
    ///     - handler: The action's handler.
    func addKeyboardShortcut(
        _ shortcut: String,
        id: String,
        window: AdwaitaWindow? = nil,
        handler: @escaping () -> Void
    ) {
        if window == nil, let data = signals[id] {
            data.closure = { _ in handler() }
            return
        } else if let data = window?.signals[id] {
            data.closure = { _ in handler() }
            return
        }
        let action = g_simple_action_new(id, nil)
        let data = SignalData(closure: handler)
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
            window.signals[id] = data
        } else {
            g_action_map_add_action(.init(pointer), action)
            signals[id] = data
        }
        gtk_application_set_accels_for_action(pointer, (window == nil ? "app." : "win.") + id, [shortcut].cArray)
    }

    /// Remove a keyboard shortcut from the application.
    /// - Parameters:
    ///     - id: The keyboard shortcut's id.
    ///     - window: Optionally an application window.
    func removeKeyboardShortcut(
        id: String,
        window: AdwaitaWindow? = nil
    ) {
        if let window {
            g_action_map_remove_action(.init(window.pointer), id)
            window.signals.removeValue(forKey: id)
        } else {
            g_action_map_remove_action(.init(pointer), id)
            signals.removeValue(forKey: id)
        }
    }

}
