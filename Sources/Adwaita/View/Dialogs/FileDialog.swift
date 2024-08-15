//
//  FileDialog.swift
//  Adwaita
//
//  Created by david-swift on 12.08.24.
//

import CAdw
import Foundation

/// A structure representing a file dialog window.
struct FileDialog: AdwaitaWidget {

    /// Whether the dialog is an importer.
    var importer = true
    /// Whether the dialog should open.
    var open: Signal
    /// The dialog's child.
    var child: AnyView
    /// The initial folder.
    var initialFolder: URL?
    /// The initial file name for the file exporter.
    var initialName: String?
    /// The accepted extensions for the file importer.
    var extensions: [String]?
    /// The closure to run when the import or export is successful.
    var result: (URL) -> Void
    /// The closure to run when the import or export is not successful.
    var cancel: () -> Void

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let child = child.storage(data: data, type: type)
        let storage = ViewStorage(child.opaquePointer, content: [.mainContent: [child]])
        update(storage, data: data, updateProperties: true, type: type)
        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The type of the app storage.
    func update<Data>(
        _ storage: ViewStorage,
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        storage.fields["result"] = result
        storage.fields["cancel"] = cancel
        guard let mainStorage = storage.content[.mainContent]?.first else {
            return
        }
        child.updateStorage(storage, data: data, updateProperties: updateProperties, type: type)
        if open.update, storage.fields["callbacks"] == nil {
            let pointer = gtk_file_dialog_new()
            if let initialName {
                gtk_file_dialog_set_initial_name(pointer, initialName)
            }
            if let extensions {
                let filter = gtk_file_filter_new()
                for name in extensions {
                    gtk_file_filter_add_suffix(filter, name)
                }
                gtk_file_dialog_set_default_filter(pointer, filter)
            } else {
                gtk_file_dialog_set_default_filter(pointer, nil)
            }
            if let initialFolder {
                gtk_file_dialog_set_initial_folder(pointer, g_file_new_for_path(initialFolder.absoluteString))
            }
            let callbacks = AdwaitaFileDialog()
            callbacks.onResult = { (storage.fields["result"] as? (URL) -> Void)?($0) }
            callbacks.onCancel = { (storage.fields["cancel"] as? () -> Void)?() }
            callbacks.reset = { storage.fields["callbacks"] = nil }
            storage.fields["callbacks"] = callbacks
            let ptr = UInt64(Int(bitPattern: pointer))
            let window = UInt64(Int(bitPattern: gtk_widget_get_root(mainStorage.opaquePointer?.cast())))
            if importer {
                gtui_filedialog_open(ptr, unsafeBitCast(callbacks, to: UInt64.self), window)
            } else {
                gtui_filedialog_save(ptr, unsafeBitCast(callbacks, to: UInt64.self), window)
            }
        }
    }

}

extension AnyView {

    /// Create an importer file dialog.
    /// - Parameters:
    ///     - open: The signal to open the dialog.
    ///     - initialFolder: The URL to the folder open when being opened.
    ///     - extensions: The accepted file extensions.
    ///     - folders: Whether folders are accepted.
    ///     - onOpen: Run this when a file for importing has been chosen.
    ///     - onClose: Run this when the user cancelled the action.
    public func fileImporter(
        open: Signal,
        initialFolder: URL? = nil,
        extensions: [String]? = nil,
        onOpen: @escaping (URL) -> Void,
        onClose: @escaping () -> Void
    ) -> AnyView {
        FileDialog(
            importer: true,
            open: open,
            child: self,
            initialFolder: initialFolder,
            initialName: nil,
            extensions: extensions,
            result: onOpen,
            cancel: onClose
        )
    }

    /// Create an exporter file dialog.
    /// - Parameters:
    ///     - exporter: The signal to open the dialog.
    ///     - initialFolder: The URL to the folder open when being opened.
    ///     - initialName: The default file name.
    ///     - onSave: Run this when a path for exporting has been chosen.
    ///     - onClose: Run this when the user cancelled the action.
    public func fileExporter(
        open: Signal,
        initialFolder: URL? = nil,
        initialName: String? = nil,
        onSave: @escaping (URL) -> Void,
        onClose: @escaping () -> Void
    ) -> AnyView {
        FileDialog(
            importer: false,
            open: open,
            child: self,
            initialFolder: initialFolder,
            initialName: initialName,
            result: onSave,
            cancel: onClose
        )
    }

}

/// An Adwaita file dialog window callback.
class AdwaitaFileDialog {

    /// A closure triggered on selecting a file in the dialog.
    var onResult: (URL) -> Void = { _ in }
    /// A closure triggered when the dialog is canceled.
    var onCancel: () -> Void = { }
    /// Reset the file dialog.
    var reset: () -> Void = { }

    /// Initialize the window callback.
    init() {
    }

    /// Run this when a file gets opened.
    /// - Parameter path: The file path.
    func onOpen(_ path: String) {
        let url = URL(fileURLWithPath: path)
        onResult(url)
        reset()
    }

    /// Run this when a file gets saved.
    /// - Parameter path: The file path.
    func onSave(_ path: String) {
        let url = URL(fileURLWithPath: path)
        onResult(url)
        reset()
    }

    /// Run this when the user cancels the action.
    func onClose() {
        onCancel()
        reset()
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
    let dialog = Unmanaged<AdwaitaFileDialog>.fromOpaque(userData).takeUnretainedValue()
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
    let dialog = Unmanaged<AdwaitaFileDialog>.fromOpaque(userData).takeUnretainedValue()
    if let file {
        dialog.onSave(.init(cString: file))
    } else {
        dialog.onClose()
    }
}
