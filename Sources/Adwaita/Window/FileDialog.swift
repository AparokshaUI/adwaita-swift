//
//  FileDialog.swift
//  Adwaita
//
//  Created by david-swift on 08.12.23.
//

// swiftlint:disable discouraged_optional_collection

import Foundation

/// A structure representing a file dialog window.
public struct FileDialog: WindowScene {

    /// The window's identifier.
    public var id: String
    /// Whether the window is an importer.
    public var importer = true
    /// Whether an instance of the window type should be opened when the app is starting up.
    public var open: Int { 0 }
    /// The identifier of the window's parent.
    public var parentID: String?
    /// The keyboard shortcuts on the app level.
    public var appShortcuts: [String: (GTUIApp) -> Void] = [:]
    /// The initial folder.
    var initialFolder: URL?
    /// The initial file name for the file exporter.
    var initialName: String?
    /// The accepted extensions for the file importer.
    var extensions: [String]?
    /// The closure to run when the import or export is successful.
    var result: ((URL) -> Void)?
    /// The closure to run when the import or export is not successful.
    var cancel: (() -> Void)?

    /// Create an importer file dialog window.
    /// - Parameters:
    ///     - importer: The window's identifier.
    ///     - initialFolder: The URL to the folder open when being opened.
    ///     - extensions: The accepted file extensions.
    ///     - folders: Whether folders are accepted.
    ///     - onOpen: Run this when a file for importing has been chosen.
    ///     - onClose: Run this when the user cancelled the action.
    public init(
        importer: String,
        initialFolder: URL? = nil,
        extensions: [String]? = nil,
        onOpen: @escaping (URL) -> Void,
        onClose: @escaping () -> Void
    ) {
        self.id = importer
        self.initialFolder = initialFolder
        self.extensions = extensions
        self.result = onOpen
        self.cancel = onClose
    }

    /// Create an exporter file dialog window.
    /// - Parameters:
    ///     - exporter: The window's identifier.
    ///     - initialFolder: The URL to the folder open when being opened.
    ///     - initialName: The default file name.
    ///     - onSave: Run this when a path for exporting has been chosen.
    ///     - onClose: Run this when the user cancelled the action.
    public init(
        exporter: String,
        initialFolder: URL? = nil,
        initialName: String? = nil,
        onSave: @escaping (URL) -> Void,
        onClose: @escaping () -> Void
    ) {
        self.id = exporter
        self.importer = false
        self.initialFolder = initialFolder
        self.initialName = initialName
        self.result = onSave
        self.cancel = onClose
    }

    /// Get the storage for the window.
    /// - Parameter app: The application.
    /// - Returns: The storage.
    public func createWindow(app: GTUIApp) -> WindowStorage {
        let window = GTUIFileDialog()
        let windowStorage = WindowStorage(id: id, window: window, view: nil)
        windowStorage.parentID = parentID
        update(window: window)
        return windowStorage
    }

    /// Update a window.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - app: The application.
    public func update(_ storage: WindowStorage, app: GTUIApp) {
        updateAppShortcuts(app: app)
        if let window = storage.window as? GTUIFileDialog {
            update(window: window)
        }
        storage.destroy = true
    }

    /// Update the window.
    /// - Parameter window: The window.
    func update(window: GTUIFileDialog) {
        window.isImporter = importer
        window.folder = initialFolder
        if let initialName {
            window.setInitialName(initialName)
        }
        window.setExtensions(extensions)
        if let result {
            window.onResult = result
        }
        if let cancel {
            window.onCancel = cancel
        }
    }

}

// swiftlint:enable discouraged_optional_collection
