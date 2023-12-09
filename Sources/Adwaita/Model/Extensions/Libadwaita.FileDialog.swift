//
//  Libadwaita.FileDialog.swift
//  Adwaita
//
//  Created by david-swift on 09.12.23.
//

import Foundation
import Libadwaita

extension Libadwaita.FileDialog: WindowType {

    /// An ID for the importer field.
    static var importer: String { "importer" }
    /// An ID for the folder field.
    static var folder: String { "folder" }
    /// An ID for the result field.
    static var result: String { "result" }
    /// An ID for the cancel field.
    static var cancel: String { "cancel" }

    /// Whether the file dialog is an importer.
    var isImporter: Bool {
        get {
            fields[Self.importer] as? Bool ?? true
        }
        set {
            fields[Self.importer] = newValue
        }
    }
    /// The selected folder in the file dialog.
    var folder: URL? {
        get {
            fields[Self.folder] as? URL
        }
        set {
            fields[Self.folder] = newValue
        }
    }
    /// A closure triggered on selecting a file in the dialog.
    var onResult: ((URL) -> Void) {
        get {
            fields[Self.result] as? (URL) -> Void ?? { _ in }
        }
        set {
            fields[Self.result] = newValue
        }
    }
    /// A closure triggered when the dialog is canceled.
    var onCancel: (() -> Void) {
        get {
            fields[Self.cancel] as? () -> Void ?? { }
        }
        set {
            fields[Self.cancel] = newValue
        }
    }

    /// Set the window's parent window.
    /// - Parameter parent: The parent window.
    ///
    /// Currently not implemented.
    public func setParentWindow(_ parent: WindowType) { }

    /// Display the file dialog.
    public func show() {
        if isImporter {
            self.open(folder: folder, onResult, onClose: onCancel)
        } else {
            self.save(folder: folder, onResult, onClose: onCancel)
        }
    }

}
