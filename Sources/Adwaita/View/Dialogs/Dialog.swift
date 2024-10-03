//
//  Dialog.swift
//  Adwaita
//
//  Created by david-swift on 20.03.24.
//

import CAdw

/// The dialog widget.
struct Dialog: AdwaitaWidget {

    /// Whether the dialog is visible.
    @Binding var visible: Bool
    /// An identifier used if multiple dialogs are on one view.
    var id: String
    /// The dialog's title.
    var title: String?
    /// The wrapped view.
    var child: AnyView
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

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The view render data type.
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
    ///     - type: The view render data type.
    func update<Data>(
        _ storage: ViewStorage,
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        if let storage = storage.content[.mainContent]?.first {
            child.updateStorage(storage, data: data, updateProperties: updateProperties, type: type)
        }
        if let storage = storage.content[contentID + id]?.first {
            content
                .updateStorage(storage, data: data, updateProperties: updateProperties, type: type)
        }
        guard updateProperties else {
            return
        }
        if visible {
            if storage.content[dialogID + id]?.first == nil {
                createDialog(storage: storage, data: data, type: type)
                adw_dialog_present(
                    storage.content[dialogID + id]?.first?.opaquePointer?.cast(),
                    storage.opaquePointer?.cast()
                )
            }
            let pointer = storage.content[dialogID + id]?.first?.opaquePointer
            if let title {
                adw_dialog_set_title(pointer?.cast(), title)
            }
            if let width {
                adw_dialog_set_content_width(pointer?.cast(), width.cInt)
            }
            if let height {
                adw_dialog_set_content_height(pointer?.cast(), height.cInt)
            }
        } else {
            if storage.content[dialogID + id]?.first != nil {
                adw_dialog_close(storage.content[dialogID + id]?.first?.opaquePointer?.cast())
            }
        }
    }

    /// Create a new instance of the dialog.
    /// - Parameters:
    ///     - storage: The wrapped view's storage.
    ///     - modifiers: The view modifiers.
    ///     - type: The view render data type.
    func createDialog<Data>(
        storage: ViewStorage,
        data: WidgetData,
        type: Data.Type
    ) where Data: ViewRenderData {
        let pointer = adw_dialog_new()
        let dialog = ViewStorage(pointer?.opaque())
        storage.content[dialogID + id] = [dialog]
        let contentStorage = content.storage(data: data, type: type)
        adw_dialog_set_child(pointer, contentStorage.opaquePointer?.cast())
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

extension AnyView {

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
    ) -> AnyView {
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
