//
//  Signal.swift
//  Adwaita
//
//  Created by david-swift on 30.11.23.
//

/// A type that signalizes an action.
public struct Signal {

    /// An action is signalized by toggling a boolean to `true` and back to `false`.
    @State var boolean = false

    /// Whether the action has caused an update.
    public var update: Bool { boolean }

    /// Initialize a signal.
    public init() { }

    /// Activate a signal.
    public func signal() {
        boolean = true
        boolean = false
    }

}
