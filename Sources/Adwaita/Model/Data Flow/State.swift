//
//  State.swift
//  Adwaita
//
//  Created by david-swift on 06.08.23.
//

import Foundation

/// A property wrapper for properties in a view that should be stored throughout view updates.
@propertyWrapper
public struct State<Value>: StateProtocol {

    /// Access the stored value. This updates the views when being changed.
    public var wrappedValue: Value {
        get {
            rawValue
        }
        nonmutating set {
            rawValue = newValue
            Self.updateViews()
        }
    }

    /// Get the value as a binding using the `$` prefix.
    public var projectedValue: Binding<Value> {
        .init {
            wrappedValue
        } set: { newValue in
            self.wrappedValue = newValue
        }
    }

    // swiftlint:disable force_cast
    /// Get and set the value without updating the views.
    public var rawValue: Value {
        get {
            content.storage.value as! Value
        }
        nonmutating set {
            content.storage.value = newValue
        }
    }
    // swiftlint:enable force_cast

    /// The stored value.
    public let content: State<Any>.Content

    /// The value with an erased type.
    public var value: Any {
        get {
            wrappedValue
        }
        nonmutating set {
            if let newValue = newValue as? Value {
                content.storage.value = newValue
            }
        }
    }

    /// Initialize a property representing a state in the view.
    /// - Parameters:
    ///     - wrappedValue: The wrapped value.
    public init(wrappedValue: Value) {
        content = .init(storage: .init(value: wrappedValue))
    }

    /// A class storing the state's content.
    public class Content {

        /// The storage.
        public var storage: Storage

        /// Initialize the content.
        /// - Parameter storage: The storage.
        public init(storage: Storage) {
            self.storage = storage
        }

    }

    /// A class storing the value.
    public class Storage {

        /// The stored value.
        public var value: Any

        /// Initialize the storage.
        /// - Parameters:
        ///     - value: The value.
        public init(value: Any) {
            self.value = value
        }

    }

    /// Update all of the views.
    public static func updateViews() {
        for handler in GTUIApp.updateHandlers {
            handler()
        }
    }

}
