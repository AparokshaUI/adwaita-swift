//
//  Idle.swift
//  Adwaita
//
//  Created by david-swift on 02.05.24.
//

import CAdw

/// Add a task to GLib's idle.
public struct Idle {

    /// The idle handler.
    static let handler = IdleHandler()

    /// Run a function whenever there are no higher priority events pending to the default main loop.
    /// - Parameters:
    ///     - priority: The task's priority, default priority by default.
    ///     - closure: The closure to run.
    @discardableResult
    public init(
        priority: Priority = .defaultIdle,
        closure: @escaping () -> Void
    ) {
        Self.handler.add({ closure(); return false }, priority: .init(priority.rawValue))
    }

    /// Repeat a function with a certain delay.
    /// - Parameters:
    ///     - delay: The delay between the repetitions.
    ///     - priority: The task's priority, default priority by default.
    ///     - closure: The closure to run. Return if you want to exit the loop.
    @discardableResult
    public init(
        delay: Duration,
        priority: Priority = .defaultIdle,
        closure: @escaping () -> Bool
    ) {
        Self.handler.add(closure, priority: .init(priority.rawValue), delay: delay)
    }

    /// The priority of an idle task.
    public enum Priority: Int {

        /// A very low priority background task.
        case low = 300
        /// A high priority event source.
        case high = -100
        /// A default priority event source.
        case `default` = 0
        /// A high priority idle function.
        case highIdle = 100
        /// A default priority idle function.
        case defaultIdle = 200

    }

    /// An idle handler.
    class IdleHandler {

        /// Add a function to be called whenever there are no higher priority events pending to the default main loop.
        /// - Parameter closure: The function.
        func add(_ closure: @escaping () -> Bool, priority: Int32, delay: Duration? = nil) {
            let context = UnsafeMutableRawPointer(Unmanaged.passRetained(ClosureContainer(closure: closure)).toOpaque())
            let secondsToMilliseconds: Int64 = 1_000
            let attosecondsToMilliseconds: Int64 = 1_000_000_000_000_000
            if let delay {
                let milliseconds = delay.components.seconds * secondsToMilliseconds
                + (delay.components.attoseconds / attosecondsToMilliseconds)
                // swiftlint:disable prefer_self_in_static_references
                g_timeout_add_full(priority, .init(milliseconds), { IdleHandler.run(pointer: $0) }, context, nil)
                // swiftlint:enable prefer_self_in_static_references
            } else {
                // swiftlint:disable prefer_self_in_static_references
                g_idle_add_full(priority, { IdleHandler.run(pointer: $0) }, context, nil)
                // swiftlint:enable prefer_self_in_static_references
            }
        }

        /// Execute the function.
        /// - Parameter pointer: The closure wrapper's pointer.
        static func run(pointer: gpointer?) -> Int32 {
            if let pointer {
                let container = Unmanaged<ClosureContainer>.fromOpaque(pointer).takeUnretainedValue()
                let result = container.closure()
                if !result {
                    Unmanaged<ClosureContainer>.fromOpaque(pointer).release()
                }
                return result.cBool
            }
            return G_SOURCE_REMOVE
        }

    }

    /// A reference type holding a closure.
    class ClosureContainer {

        /// The closure.
        var closure: () -> Bool

        /// Initialize an object.
        /// - Parameter closure: The closure.
        init(closure: @escaping () -> Bool) {
            self.closure = closure
        }

    }

}
