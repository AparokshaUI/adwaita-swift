//
//  ViewStorage.swift
//  Adwaita
//
//  Created by david-swift on 31.08.23.
//

import CAdw

/// Store a rendered view in a view storage.
public class ViewStorage {

    /// The pointer.
    public var pointer: OpaquePointer?
    /// The view's content.
    public var content: [String: [ViewStorage]]
    /// The view's state (used in `StateWrapper`).
    public var state: [String: StateProtocol]
    /// The signal handlers.
    public var handlers: [String: SignalData] = [:]
    /// Other properties.
    public var fields: [String: Any] = [:]

    /// Initialize a view storage.
    /// - Parameters:
    ///   - pointer: The pointer to the Gtk widget.
    ///   - content: The view's content.
    ///   - state: The view's state.
    public init(
        _ pointer: OpaquePointer?,
        content: [String: [ViewStorage]] = [:],
        state: [String: StateProtocol] = [:]
    ) {
        self.pointer = pointer
        self.content = content
        self.state = state
    }

    /// Data to pass to signal handlers.
    public class SignalData {

        /// The closure.
        public var closure: ([UnsafeMutableRawPointer]) -> Void

        /// The closure as a C handler.
        var handler: @convention(c) (UnsafeMutableRawPointer, UnsafeMutableRawPointer) -> Void {
            { _, data in
                let data = unsafeBitCast(data, to: SignalData.self)
                data.closure([])
            }
        }

        /// The closure as a C handler with three parameters.
        var threeParamsHandler: @convention(c) (
                UnsafeMutableRawPointer,
                UnsafeMutableRawPointer,
                UnsafeMutableRawPointer
        ) -> Void {
            { _, arg1, data in
                let data = unsafeBitCast(data, to: SignalData.self)
                data.closure([arg1])
            }
        }

        /// The closure as a C handler with four parameters.
        var fourParamsHandler: @convention(c) (
                UnsafeMutableRawPointer,
                UnsafeMutableRawPointer,
                UnsafeMutableRawPointer,
                UnsafeMutableRawPointer
        ) -> Void {
            { _, arg1, arg2, data in
                let data = unsafeBitCast(data, to: SignalData.self)
                data.closure([arg1, arg2])
            }
        }

        /// The closure as a C handler with five parameters.
        var fiveParamsHandler: @convention(c) (
                UnsafeMutableRawPointer,
                UnsafeMutableRawPointer,
                UnsafeMutableRawPointer,
                UnsafeMutableRawPointer,
                UnsafeMutableRawPointer
        ) -> Void {
            { _, arg1, arg2, arg3, data in
                let data = unsafeBitCast(data, to: SignalData.self)
                data.closure([arg1, arg2, arg3])
                print("Hi")
            }
        }

        /// Initialize the signal data.
        /// - Parameter closure: The signal's closure.
        public convenience init(closure: @escaping () -> Void) {
            self.init { _ in closure() }
        }

        /// Initialize the signal data.
        /// - Parameter closure: The signal's closure.
        public init(closure: @escaping ([UnsafeMutableRawPointer]) -> Void) {
            self.closure = closure
        }

    }

    /// Connect a handler to the observer of a property.
    /// - Parameters:
    ///     - name: The property's name.
    ///     - id: The handlers id to separate form others connecting to the signal.
    ///     - connectFlags: The GConnectFlags.
    ///     - handler: The signal's handler.
    public func notify(
        name: String,
        id: String = "",
        connectFlags: GConnectFlags = G_CONNECT_AFTER,
        handler: @escaping () -> Void
    ) {
        let name = "notify::" + name
        connectSignal(name: name, id: id, connectFlags: connectFlags, argCount: 1, handler: handler)
    }

    /// Connect a handler to a signal.
    /// - Parameters:
    ///     - name: The signal's name.
    ///     - id: The handlers id to separate form others connecting to the signal.
    ///     - connectFlags: The GConnectFlags.
    ///     - argCount: The number of additional arguments (without the first and the last one).
    ///     - handler: The signal's handler.
    public func connectSignal(
        name: String,
        id: String = "",
        connectFlags: GConnectFlags = G_CONNECT_AFTER,
        argCount: Int = 0,
        handler: @escaping () -> Void
    ) {
        connectSignal(name: name, id: id, connectFlags: connectFlags, argCount: argCount) { _ in
            handler()
        }
    }

    /// Connect a handler to a signal.
    /// - Parameters:
    ///     - name: The signal's name.
    ///     - id: The handlers id to separate form others connecting to the signal.
    ///     - connectFlags: The GConnectFlags.
    ///     - argCount: The number of additional arguments (without the first and the last one).
    ///     - handler: The signal's handler.
    public func connectSignal(
        name: String,
        id: String = "",
        connectFlags: GConnectFlags = G_CONNECT_AFTER,
        argCount: Int = 0,
        handler: @escaping ([UnsafeMutableRawPointer]) -> Void
    ) {
        if let data = handlers[name + id] {
            data.closure = handler
        } else {
            let data = SignalData(closure: handler)
            handlers[name + id] = data
            let callback: GCallback
            let three = 3
            let two = 2
            if argCount >= three {
                callback = unsafeBitCast(data.fiveParamsHandler, to: GCallback.self)
            } else if argCount == two {
                callback = unsafeBitCast(data.fourParamsHandler, to: GCallback.self)
            } else if argCount == 1 {
                callback = unsafeBitCast(data.threeParamsHandler, to: GCallback.self)
            } else {
                callback = unsafeBitCast(data.handler, to: GCallback.self)
            }
            g_signal_connect_data(
                pointer?.cast(),
                name,
                callback,
                Unmanaged.passUnretained(data).toOpaque().cast(),
                nil,
                connectFlags
            )
        }
    }

    /// Modify the view.
    /// - Parameter modify: The modification function.
    public func modify(_ modify: (OpaquePointer?) -> Void) {
        modify(pointer)
    }

    /// Convert the pointer to a pointer of a certain type and modify the view.
    /// - Parameters:
    ///     - type: The pointer's type.
    ///     - modify: The modification function.
    public func modify<T>(_ type: T.Type, _ modify: (UnsafeMutablePointer<T>?) -> Void) {
        modify(pointer?.cast())
    }

}
