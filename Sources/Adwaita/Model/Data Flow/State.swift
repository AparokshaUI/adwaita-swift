//
//  State.swift
//  Adwaita
//
//  Created by david-swift on 06.08.23.
//

import Foundation
import Libadwaita

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
            writeValue?()
        }
    }
    // swiftlint:enable force_cast

    /// The stored value.
    public let content: State<Any>.Content

    /// The function for updating the value in the settings file.
    private var writeValue: (() -> Void)?

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
        /// The storage key.
        public var key: String?

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

    /// Get the settings directory path.
    /// - Returns: The path.
    private func dirPath() -> URL {
        NativePeer.getUserDataDirectory().appendingPathComponent(GTUIApp.appID, isDirectory: true)
    }

    /// Get the settings file path.
    /// - Returns: The path.
    private func filePath() -> URL {
        dirPath().appendingPathComponent("\(content.storage.key ?? "temporary").json")
    }

}

extension State where Value: Codable {

    /// Initialize a property representing a state in the view.
    /// - Parameters:
    ///     - key: The unique storage key of the property.
    ///     - wrappedValue: The wrapped value.
    public init(wrappedValue: Value, _ key: String) {
        content = .init(storage: .init(value: wrappedValue))
        content.storage.key = key
        checkFile()
        readValue()
        self.writeValue = writeCodableValue
    }

    /// Check whether the settings file exists, and, if not, create it.
    private func checkFile() {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: dirPath().path) {
            try? fileManager.createDirectory(
                at: .init(fileURLWithPath: dirPath().path),
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
        if !fileManager.fileExists(atPath: filePath().path) {
            fileManager.createFile(atPath: filePath().path, contents: .init(), attributes: nil)
        }
    }

    /// Update the local value with the value from the file.
    private func readValue() {
        let data = try? Data(contentsOf: filePath())
        if let data, let value = try? JSONDecoder().decode(Value.self, from: data) {
            rawValue = value
        }
    }

    /// Update the value on the file with the local value.
    private func writeCodableValue() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(rawValue)
        try? data?.write(to: filePath())
    }

}
