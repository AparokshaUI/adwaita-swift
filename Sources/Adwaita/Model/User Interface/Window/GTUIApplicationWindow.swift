//
//  GTUIApplicationWindow.swift
//  Adwaita
//
//  Created by david-swift on 19.10.23.
//

import CAdw

/// A GTUI application window.
public class GTUIApplicationWindow: GTUIWindow {

    /// The window's parent app.
    public var app: GTUIApp

    /// Initialize the application window.
    /// - Parameter app: The application.
    public init(app: GTUIApp) {
        self.app = app
        super.init(fields: [:])
        pointer = adw_application_window_new(app.pointer)?.cast()
    }

    /// Add a keyboard shortcut.
    /// - Parameters:
    ///     - shortcut: The keyboard shortcut.
    ///     - id: The action's id.
    ///     - handler: The action's handler.
    public func addKeyboardShortcut(_ shortcut: String, id: String, handler: @escaping () -> Void) {
        app.addKeyboardShortcut(shortcut, id: id, window: self, handler: handler)
    }

    /// Set the window's child.
    /// - Parameter child: The child.
    override public func setChild(_ child: OpaquePointer?) {
        adw_application_window_set_content(pointer?.cast(), child?.cast())
    }

}
