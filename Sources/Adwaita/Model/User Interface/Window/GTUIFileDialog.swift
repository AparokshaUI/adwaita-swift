//
//  GTUIFileDialog.swift
//  Adwaita
//
//  Created by david-swift on 09.12.23.
//

import CAdw
import Foundation

/// A GTUI file dialog window.
public class GTUIFileDialog: WindowType {

    /// The file dialog's pointer.
    public var pointer: OpaquePointer?
    /// Fields for additional data.
    public var fields: [String: Any] = [:]
    /// A link to the file dialog.
    var selfAddr: UInt64 {
        unsafeBitCast(self, to: UInt64.self)
    }
    /// The parent window.
    var parent: OpaquePointer?
    /// Whether the file dialog is an importer.
    var isImporter = false
    /// The selected folder in the file dialog.
    var folder: URL?
    /// A closure triggered on selecting a file in the dialog.
    var onResult: (URL) -> Void = { _ in }
    /// A closure triggered when the dialog is canceled.
    var onCancel: () -> Void = { }

    /// Initialize the window.
    public init() {
        pointer = gtk_file_dialog_new()
    }

    /// Set the window's parent window.
    /// - Parameter parent: The parent window.
    public func setParentWindow(_ parent: WindowType) {
        if let window = parent as? GTUIWindow {
            self.parent = .init(window.pointer)
        }
    }

    /// Set the initial name.
    /// - Parameter name: The parent window.
    public func setInitialName(_ name: String) {
        gtk_file_dialog_set_initial_name(pointer, name)
    }

    // swiftlint:disable discouraged_optional_collection
    /// Set the allowed file extensions.
    /// - Parameters:
    ///     - extensions: The file extensions.
    public func setExtensions(_ extensions: [String]?) {
        if let extensions {
            let filter = gtk_file_filter_new()
            for name in extensions {
                gtk_file_filter_add_suffix(filter, name)
            }
            gtk_file_dialog_set_default_filter(pointer, filter)
        } else {
            gtk_file_dialog_set_default_filter(pointer, nil)
        }
    }
    // swiftlint:enable discouraged_optional_collection

    /// Display the file dialog.
    public func show() {
        if let folder {
            gtk_file_dialog_set_initial_folder(pointer, g_file_new_for_path(folder.absoluteString))
        }
        if isImporter {
            gtui_filedialog_open(UInt64(Int(bitPattern: pointer)), selfAddr, UInt64(Int(bitPattern: parent)))
        } else {
            gtui_filedialog_save(UInt64(Int(bitPattern: pointer)), selfAddr, UInt64(Int(bitPattern: parent)))
        }
    }

    /// Run this when a file gets opened.
    /// - Parameter path: The file path.
    func onOpen(_ path: String) {
        let url = URL(fileURLWithPath: path)
        onResult(url)
    }

    /// Run this when a file gets saved.
    /// - Parameter path: The file path.
    func onSave(_ path: String) {
        let url = URL(fileURLWithPath: path)
        onResult(url)
    }

    /// Run this when the user cancels the action.
    func onClose() {
        onCancel()
    }

}

/// Run when a file should be opened.
/// - Parameters:
///   - ptr: The pointer.
///   - file: The path to the file.
///   - userData: The file dialog data.
@_cdecl("filedialog_on_open_cb")
func filedialog_on_open_cb(
    ptr: UnsafeMutableRawPointer,
    file: UnsafePointer<CChar>?,
    userData: UnsafeMutableRawPointer
) {
    let dialog = Unmanaged<GTUIFileDialog>.fromOpaque(userData).takeUnretainedValue()
    if let file {
        dialog.onOpen(.init(cString: file))
    } else {
        dialog.onClose()
    }
}

/// Run when a file should be saved.
/// - Parameters:
///   - ptr: The pointer.
///   - file: The path to the file.
///   - userData: The file dialog data.
@_cdecl("filedialog_on_save_cb")
func filedialog_on_save_cb(
    ptr: UnsafeMutableRawPointer,
    file: UnsafePointer<CChar>?,
    userData: UnsafeMutableRawPointer
) {
    let dialog = Unmanaged<GTUIFileDialog>.fromOpaque(userData).takeUnretainedValue()
    if let file {
        dialog.onSave(.init(cString: file))
    } else {
        dialog.onClose()
    }
}
