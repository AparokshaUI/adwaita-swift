//
//  State.swift
//  Adwaita
//
//  Created by david-swift on 06.08.23.
//

/// A property wrapper for properties in a view that should be stored throughout view updates.
@propertyWrapper
public struct State<Value>: StateProtocol {

    /// Access the stored value. This updates the views when being changed.
    public var wrappedValue: Value {
        get {
            storage.value
        }
        nonmutating set {
            storage.value = newValue
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

    /// The stored value.
    private let storage: Storage<Value>
    /// The value with an erased type.
    public var value: Any {
        get {
            wrappedValue
        }
        nonmutating set {
            if let newValue = newValue as? Value {
                storage.value = newValue
            }
        }
    }

    /// Initialize a property representing a state in the view.
    /// - Parameters:
    ///     - wrappedValue: The wrapped value.
    public init(wrappedValue: Value) {
        storage = .init(value: wrappedValue)
    }

    /// A class storing the value.
    class Storage<StoredValue> {

        /// The stored value.
        var value: StoredValue

        /// Initialize the storage.
        /// - Parameters:
        ///     - value: The value.
        init(value: StoredValue) {
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
