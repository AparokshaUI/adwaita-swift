//
//  SignalData.swift
//  Adwaita
//
//  Created by david-swift on 31.07.24.
//

import CAdw

/// Data to pass to signal handlers.
public class SignalData {

    /// The closure.
    public var closure: ([Any?]) -> Void

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
        UnsafeRawPointer?,
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
        UnsafeRawPointer?,
        UnsafeRawPointer?,
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
        UnsafeRawPointer?,
        Double,
        Double,
        UnsafeMutableRawPointer
    ) -> Void {
        { _, arg1, arg2, arg3, data in
            let data = unsafeBitCast(data, to: SignalData.self)
            data.closure([arg1, arg2, arg3])
        }
    }

    /// Initialize the signal data.
    /// - Parameter closure: The signal's closure.
    public convenience init(closure: @escaping () -> Void) {
        self.init { _ in closure() }
    }

    /// Initialize the signal data.
    /// - Parameter closure: The signal's closure.
    public init(closure: @escaping ([Any]) -> Void) {
        self.closure = closure
    }

    /// Connect the signal data to a signal.
    /// - Parameters:
    ///     - pointer: The pointer to the object which holds the signal.
    ///     - signal: The signal's name.
    ///     - argCount: The number of arguments.
    public func connect(pointer: UnsafeMutableRawPointer?, signal: String, argCount: Int = 0) {
        let callback: GCallback
        if argCount >= 3 {
            callback = unsafeBitCast(fiveParamsHandler, to: GCallback.self)
        } else if argCount == 2 {
            callback = unsafeBitCast(fourParamsHandler, to: GCallback.self)
        } else if argCount == 1 {
            callback = unsafeBitCast(threeParamsHandler, to: GCallback.self)
        } else {
            callback = unsafeBitCast(handler, to: GCallback.self)
        }
        g_signal_connect_data(
            pointer,
            signal,
            callback,
            Unmanaged.passUnretained(self).toOpaque().cast(),
            nil,
            G_CONNECT_AFTER
        )
    }

}
