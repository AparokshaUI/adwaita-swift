//
//  WindowView.swift
//  Adwaita
//
//  Created by david-swift on 06.08.24.
//

/// A storage type is a view storage or a scene storage.
public protocol Storage: AnyObject {

    /// The pointer.
    var opaquePointer: OpaquePointer? { get }
    /// Additional fields.
    var fields: [String: Any] { get set }

}

extension Storage {

    /// Connect a handler to the observer of a property.
    /// - Parameters:
    ///     - name: The property's name.
    ///     - id: The handlers id to separate form others connecting to the signal.
    ///     - pointer: A custom pointer instead of the stored one.
    ///     - handler: The signal's handler.
    public func notify(
        name: String,
        id: String = "",
        pointer: OpaquePointer? = nil,
        handler: @escaping () -> Void
    ) {
        let name = "notify::" + name
        connectSignal(name: name, id: id, argCount: 1, pointer: pointer, handler: handler)
    }

    /// Connect a handler to a signal.
    /// - Parameters:
    ///     - name: The signal's name.
    ///     - id: The handlers id to separate form others connecting to the signal.
    ///     - connectFlags: The GConnectFlags.
    ///     - argCount: The number of additional arguments (without the first and the last one).
    ///     - pointer: A custom pointer instead of the stored one.
    ///     - handler: The signal's handler.
    public func connectSignal(
        name: String,
        id: String = "",
        argCount: Int = 0,
        pointer: OpaquePointer? = nil,
        handler: @escaping () -> Void
    ) {
        connectSignal(name: name, id: id, argCount: argCount, pointer: pointer) { _ in
            handler()
        }
    }

    /// Connect a handler to a signal.
    /// - Parameters:
    ///     - name: The signal's name.
    ///     - id: The handlers id to separate form others connecting to the signal.
    ///     - argCount: The number of additional arguments (without the first and the last one).
    ///     - pointer: A custom pointer instead of the stored one.
    ///     - handler: The signal's handler.
    public func connectSignal(
        name: String,
        id: String = "",
        argCount: Int = 0,
        pointer: OpaquePointer? = nil,
        handler: @escaping ([Any]) -> Void
    ) {
        if let data = fields[name + id] as? SignalData {
            data.closure = handler
        } else {
            let data = SignalData(closure: handler)
            fields[name + id] = data
            data.connect(pointer: (pointer ?? opaquePointer)?.cast(), signal: name, argCount: argCount)
        }
    }

}

extension ViewStorage: Storage { }
extension SceneStorage: Storage { }
