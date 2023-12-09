//
//  Signal.swift
//  Adwaita
//
//  Created by david-swift on 30.11.23.
//

import Foundation

/// A type that signalizes an action.
public struct Signal {

    /// An action is signalized by toggling a boolean to `true` and back to `false`.
    @State var boolean = false
    /// A signal has a unique identifier.
    public let id: UUID = .init()

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
