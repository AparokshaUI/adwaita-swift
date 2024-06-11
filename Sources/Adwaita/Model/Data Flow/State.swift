//
//  State.swift
//  Adwaita
//
//  Created by david-swift on 06.08.23.
//

import CAdw
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
            content.storage.update = true
            Self.updateViews(force: forceUpdates)
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
            if let readValue, !content.fetched {
                let newValue = readValue()
                content.storage.value = newValue
                content.fetched = true
                return newValue
            }
            return content.storage.value as! Value
        }
        nonmutating set {
            content.storage.value = newValue
            writeValue?()
        }
    }
    // swiftlint:enable force_cast

    /// The stored value.
    public let content: State<Any>.Content

    /// Whether to force update the views when the value changes.
    public var forceUpdates: Bool

    /// The function for updating the value in the settings file.
    private var writeValue: (() -> Void)?
    /// The function for reading the value in the settings file.
    var readValue: (() -> Value)?

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
    ///     - forceUpdates: Whether to force update all available views when the property gets modified.
    public init(wrappedValue: Value, forceUpdates: Bool = false) {
        content = .init(initialValue: wrappedValue)
        self.forceUpdates = forceUpdates
    }

    /// A class storing the state's content.
    public class Content {

        /// The storage.
        public var storage: Storage {
            get {
                if let internalStorage {
                    return internalStorage
                }
                let storage = Storage(value: initialValue)
                internalStorage = storage
                return storage
            }
            set {
                internalStorage = newValue
            }
        }
        /// The internal storage.
        var internalStorage: Storage?
        /// The initial value.
        private var initialValue: Value
        /// Whether the value has already been fetched from the file stored on the system.
        var fetched = false

        /// Initialize the content.
        /// - Parameter storage: The storage.
        @available(*, deprecated, message: "Use a safer initializer instead")
        public init(storage: Storage) {
            // swiftlint:disable force_cast
            let initialValue = storage.value as! Value
            // swiftlint:enable force_cast
            self.initialValue = initialValue
            self.storage = storage
        }

        /// Initialize the content.
        /// - Parameter initialValue: The initial value.
        public init(initialValue: Value) {
            self.initialValue = initialValue
        }

    }

    /// A class storing the value.
    public class Storage {

        /// The stored value.
        public var value: Any
        /// The storage key.
        public var key: String?
        /// The folder path.
        public var folder: String?
        /// Whether to update the affected views.
        public var update = false

        /// Initialize the storage.
        /// - Parameters:
        ///     - value: The value.
        public init(value: Any) {
            self.value = value
        }

    }

    /// Update all of the views.
    /// - Parameter force: Whether to force all views to update.
    public static func updateViews(force: Bool = false) {
        UpdateManager.updateViews(force: force)
    }

    /// The directory used for storing user data.
    /// - Returns: The URL.
    public static func userDataDir() -> URL {
        .init(fileURLWithPath: .init(cString: g_get_user_data_dir()))
    }

    /// Copy a text to the clipboard.
    /// - Parameter text: The text.
    public static func copy(_ text: String) {
        let clipboard = gdk_display_get_clipboard(gdk_display_get_default())
        gdk_clipboard_set_text(clipboard, text)
    }

    /// Get the settings directory path.
    /// - Returns: The path.
    private func dirPath() -> URL? {
        guard let folder = content.storage.folder ?? GTUIApp.appID else {
            return nil
        }
        return Self.userDataDir()
            .appendingPathComponent(folder, isDirectory: true)
    }

    /// Get the settings file path.
    /// - Returns: The path.
    private func filePath() -> URL? {
        dirPath()?.appendingPathComponent("\(content.storage.key ?? "temporary").json")
    }

}

extension State where Value: Codable {

    /// Initialize a property representing a state in the view.
    /// - Parameters:
    ///     - wrappedValue: The wrapped value.
    ///     - key: The unique storage key of the property.
    ///     - folder: The path to the folder containing the JSON file.
    ///     - forceUpdates: Whether to force update all available views when the property gets modified.
    ///
    /// The folder path will be appended to the XDG data home directory.
    public init(wrappedValue: Value, _ key: String, folder: String? = nil, forceUpdates: Bool = false) {
        content = .init(initialValue: wrappedValue)
        self.forceUpdates = forceUpdates
        content.storage.key = key
        content.storage.folder = folder
        let value = self
        self.readValue = {
            value.checkFile()
            return value.readActualValue() ?? wrappedValue
        }
        self.writeValue = writeCodableValue
    }

    /// Check whether the settings file exists, and, if not, create it.
    private func checkFile() {
        let fileManager = FileManager.default
        guard let dirPath = dirPath(), let filePath = filePath() else {
            print("Stored state value accessed before initializing app id.")
            return
        }
        if !fileManager.fileExists(atPath: dirPath.path) {
            try? fileManager.createDirectory(
                at: .init(fileURLWithPath: dirPath.path),
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
        if !fileManager.fileExists(atPath: filePath.path) {
            fileManager.createFile(atPath: filePath.path, contents: .init(), attributes: nil)
        }
    }

    /// Update the local value with the value from the file.
    private func readActualValue() -> Value? {
        if let filePath = filePath(),
           let data = try? Data(contentsOf: filePath),
           let value = try? JSONDecoder().decode(Value.self, from: data) {
            return value
        }
        return nil
    }

    /// Update the value on the file with the local value.
    private func writeCodableValue() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(rawValue)
        guard let filePath = filePath() else {
            return
        }
        try? data?.write(to: filePath)
    }

}
