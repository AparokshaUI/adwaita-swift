//
//  Dialog.swift
//  Adwaita
//
//  Created by david-swift on 20.03.24.
//

import CAdw

/// The dialog widget.
struct Dialog: Widget {

    /// Whether the dialog is visible.
    @Binding var visible: Bool
    /// An identifier used if multiple dialogs are on one view.
    var id: String
    /// The dialog's title.
    var title: String?
    /// The wrapped view.
    var child: View
    /// The content of the dialog.
    var content: Body
    /// The dialog's width.
    var width: Int?
    /// The dialog's height.
    var height: Int?

    /// The ID for the dialog's storage.
    let dialogID = "dialog"
    /// The ID for the content's storage.
    let contentID = "content"

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
        if let storage = storage.content[contentID + id]?.first as? ViewStorage {
            content
                .widget(modifiers: modifiers)
                .update(storage, modifiers: modifiers, updateProperties: updateProperties)
        }
        guard updateProperties else {
            return
        }
        if visible {
            if storage.content[dialogID + id]?.first == nil {
                createDialog(storage: storage, modifiers: modifiers)
                adw_dialog_present(storage.content[dialogID + id]?.first?.pointer?.cast(), storage.pointer?.cast())
            }
            let pointer = storage.content[dialogID + id]?.first?.pointer
            adw_dialog_set_title(pointer?.cast(), title ?? "")
            adw_dialog_set_content_width(pointer?.cast(), width?.cInt ?? -1)
            adw_dialog_set_content_height(pointer?.cast(), height?.cInt ?? -1)
        } else {
            if storage.content[dialogID + id]?.first != nil {
                adw_dialog_close(storage.content[dialogID + id]?.first?.pointer?.cast())
            }
        }
    }

    /// Create a new instance of the dialog.
    /// - Parameters:
    ///     - storage: The wrapped view's storage.
    ///     - modifiers: The view modifiers.
    func createDialog(storage: ViewStorage, modifiers: [(View) -> View]) {
        let pointer = adw_dialog_new()
        let dialog = ViewStorage(pointer?.opaque())
        storage.content[dialogID + id] = [dialog]
        let contentStorage = content.widget(modifiers: modifiers).storage(modifiers: modifiers)
        adw_dialog_set_child(pointer, contentStorage.pointer?.cast())
        storage.content[contentID + id] = [contentStorage]
        dialog.connectSignal(name: "closed") {
            storage.content[dialogID + id] = []
            storage.content[contentID + id] = []
            if visible {
                visible = false
            }
        }
    }

}

extension View {

    /// Add a dialog to the parent window.
    /// - Parameters:
    ///     - visible: Whether the dialog is presented.
    ///     - title: The dialog's title.
    ///     - width: The dialog's width.
    ///     - height: The dialog's height.
    ///     - content: The dialog's content.
    public func dialog(
        visible: Binding<Bool>,
        title: String? = nil,
        id: String? = nil,
        width: Int? = nil,
        height: Int? = nil,
        @ViewBuilder content: () -> Body
    ) -> View {
        Dialog(
            visible: visible,
            id: id ?? "",
            title: title,
            child: self,
            content: content(),
            width: width,
            height: height
        )
    }

}
