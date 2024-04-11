//
//  AboutDialog.swift
//  Adwaita
//
//  Created by david-swift on 21.03.24.
//

import CAdw
import Foundation

/// The about dialog widget.
struct AboutDialog: Widget {

    /// Whether the dialog is visible.
    @Binding var visible: Bool
    /// The wrapped view.
    var child: View

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

    /// Get the container of the child.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The view storage.
    func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = child.storage(modifiers: modifiers)
        update(storage, modifiers: modifiers, updateProperties: true)
        return storage
    }

    /// Update the view storage of the child, dialog, and dialog content.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    ///     - updateProperties: Whether to update properties.
    func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
        child.widget(modifiers: modifiers).update(storage, modifiers: modifiers, updateProperties: updateProperties)
        guard updateProperties else {
            return
        }
        if visible {
            if storage.content[dialogID]?.first == nil {
                createDialog(storage: storage, modifiers: modifiers)
                adw_dialog_present(storage.content[dialogID]?.first?.pointer?.cast(), storage.pointer?.cast())
            }
            let dialog = storage.content[dialogID]?.first?.pointer
            adw_about_dialog_set_application_name(dialog, appName)
            adw_about_dialog_set_developer_name(dialog, developer)
            adw_about_dialog_set_version(dialog, version)
            adw_about_dialog_set_application_icon(dialog, icon?.string)
            adw_about_dialog_set_website(dialog, website?.absoluteString)
            adw_about_dialog_set_support_url(dialog, issues?.absoluteString)
            adw_dialog_set_content_height(dialog?.cast(), -1)
        } else {
            if storage.content[dialogID]?.first != nil {
                adw_dialog_close(storage.content[dialogID]?.first?.pointer?.cast())
            }
        }
    }

    /// Create a new instance of the dialog.
    /// - Parameters:
    ///     - storage: The wrapped view's storage.
    ///     - modifiers: The view modifiers.
    func createDialog(storage: ViewStorage, modifiers: [(View) -> View]) {
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

extension View {

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
    ) -> View {
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
