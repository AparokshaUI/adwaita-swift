//
//  GTUIWindow.swift
//  Adwaita
//
//  Created by david-swift on 12.10.23.
//

import CAdw

/// A GTUI window.
public class GTUIWindow: WindowType {

    /// The window's pointer.
    public var pointer: UnsafeMutablePointer<GtkWindow>?
    /// Fields for additional information.
    public var fields: [String: Any] = [:]

    /// Initialize the window.
    public init() {
        pointer = adw_window_new()?.cast()
    }

    /// Initialize the window, but not the pointer.
    /// - Parameter fields: The fields.
    init(fields: [String: Any]) {
        self.fields = fields
    }

    /// Set the default window size.
    /// - Parameters:
    ///     - width: The width.
    ///     - height: The height.
    public func setDefaultSize(width: Int?, height: Int?) {
        gtk_window_set_default_size(pointer, width?.cInt ?? -1, height?.cInt ?? -1)
    }

    /// Set the resizability.
    /// - Parameter resizable: Whether the window is resizable.
    public func setResizability(_ resizable: Bool) {
        gtk_window_set_resizable(pointer, resizable.cBool)
    }

    /// Set the deletability.
    /// - Parameter deletable: Whether the window is deletable.
    public func setDeletability(_ deletable: Bool) {
        gtk_window_set_deletable(pointer, deletable.cBool)
    }

    /// Set the window title.
    /// - Parameter title: The window's title.
    public func setTitle(_ title: String) {
        gtk_window_set_title(pointer, title)
    }

    /// Set the window's child.
    /// - Parameter child: The child.
    public func setChild(_ child: OpaquePointer?) {
        gtk_window_set_child(pointer, child?.cast())
    }

    /// Present the window.
    public func show() {
        gtk_window_present(pointer)
    }

    /// Observe when the window is being closed.
    /// - Parameter observer: The signal closure.
    public func observeHide(observer: @escaping () -> Void) {
        let hideObserver = ViewStorage.SignalData(closure: observer)
        self.fields["observe-hide"] = hideObserver
        g_signal_connect_data(
            pointer?.cast(),
            "destroy",
            unsafeBitCast(hideObserver.handler, to: GCallback.self),
            Unmanaged.passUnretained(hideObserver).toOpaque().cast(),
            nil,
            G_CONNECT_AFTER
        )
    }

    /// Close the window.
    public func close() {
        gtk_window_close(pointer)
    }

    /// Set the window's parent window.
    /// - Parameter parent: The parent window.
    public func setParentWindow(_ parent: WindowType) {
        // swiftlint:disable prefer_self_in_static_references
        if let window = parent as? GTUIWindow {
            gtk_window_set_modal(pointer, 1)
            gtk_window_set_transient_for(pointer, window.pointer)
        }
        // swiftlint:enable prefer_self_in_static_references
    }

}
