//
//  AboutDialog.swift
//  Adwaita
//
//  Created by david-swift on 21.03.24.
//

import CAdw
import Foundation

/// The about dialog widget.
struct AboutDialog: AdwaitaWidget {

    /// Whether the dialog is visible.
    @Binding var visible: Bool
    /// The wrapped view.
    var child: AnyView

    /// The app's name.
    var appName: String?
    /// The developer's name.
    var developer: String?
    /// The app version.
    var version: String?
    /// The app icon.
    var icon: Icon?
    /// The app's website.
    var website: URL?
    /// The link for opening issues.
    var issues: URL?

    /// The ID for the dialog's storage.
    let dialogID = "dialog"

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    func container<Data>(modifiers: [(AnyView) -> AnyView], type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = child.storage(modifiers: modifiers, type: type)
        update(storage, modifiers: modifiers, updateProperties: true, type: type)
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
        modifiers: [(AnyView) -> AnyView],
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        child.updateStorage(storage, modifiers: modifiers, updateProperties: updateProperties, type: type)
        guard updateProperties, (storage.previousState as? Self)?.visible != visible else {
            return
        }
        if visible {
            if storage.content[dialogID]?.first == nil {
                createDialog(storage: storage)
                adw_dialog_present(
                    storage.content[dialogID]?.first?.opaquePointer?.cast(),
                    storage.opaquePointer?.cast()
                )
            }
            let dialog = storage.content[dialogID]?.first?.opaquePointer
            if let appName {
                adw_about_dialog_set_application_name(dialog, appName)
            }
            if let developer {
                adw_about_dialog_set_developer_name(dialog, developer)
            }
            if let version {
                adw_about_dialog_set_version(dialog, version)
            }
            if let icon {
                adw_about_dialog_set_application_icon(dialog, icon.string)
            }
            if let website {
                adw_about_dialog_set_website(dialog, website.absoluteString)
            }
            if let issues {
                adw_about_dialog_set_issue_url(dialog, issues.absoluteString)
            }
            adw_dialog_set_content_height(dialog?.cast(), -1)
        } else {
            if storage.content[dialogID]?.first != nil {
                adw_dialog_close(storage.content[dialogID]?.first?.opaquePointer?.cast())
            }
        }
        storage.previousState = self
    }

    /// Create a new instance of the dialog.
    /// - Parameter storage: The wrapped view's storage.
    func createDialog(storage: ViewStorage) {
        let pointer = adw_about_dialog_new()
        let dialog = ViewStorage(pointer?.opaque())
        storage.content[dialogID] = [dialog]
        dialog.connectSignal(name: "closed") {
            storage.content[dialogID] = []
            if visible {
                visible = false
            }
        }
    }

}

extension AnyView {

    /// Add an about dialog to the parent window.
    /// - Parameters:
    ///     - visible: Whether the dialog is presented.
    ///     - app: The app's name.
    ///     - developer: The developer's name.
    ///     - version: The version string.
    ///     - icon: The app icon.
    ///     - website: The app's website.
    ///     - issues: Website for reporting issues.
    public func aboutDialog(
        visible: Binding<Bool>,
        app: String? = nil,
        developer: String? = nil,
        version: String? = nil,
        icon: Icon? = nil,
        website: URL? = nil,
        issues: URL? = nil
    ) -> AnyView {
        AboutDialog(
            visible: visible,
            child: self,
            appName: app,
            developer: developer,
            version: version,
            icon: icon,
            website: website,
            issues: issues
        )
    }

}
