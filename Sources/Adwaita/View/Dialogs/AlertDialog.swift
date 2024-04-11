//
//  AlertDialog.swift
//  Adwaita
//
//  Created by david-swift on 05.04.24.
//

import CAdw
import LevenshteinTransformations

/// The message dialog widget.
public struct AlertDialog: Widget {

    /// The ID for the dialog's storage.
    static let dialogID = "alert-dialog"
    /// The ID for the dialog's responses' storage.
    static let responsesID = "responses"
    /// The ID for the visibility binding.
    static let visibleID = "visible"
    /// The ID for the callbacks.
    static let callbacks = "callbacks"

    /// Whether the dialog is visible.
    @Binding var visible: Bool
    /// An identifier used if multiple dialogs are on one view.
    var id: String
    /// The dialog's title.
    var heading: String
    /// The body text.
    var body: String
    /// The available responses.
    var responses: [Response] = []
    /// The child view.
    var child: View

    /// Information about a response.
    struct Response: Identifiable {

        /// The title.
        var title: String
        /// The identifier.
        var id: String { title }
        /// The appearance.
        var appearance: ResponseAppearance
        /// The function for the keyboard shortcut, or no shortcut.
        var role: ResponseRole?
        /// The callback.
        var action: () -> Void

    }

    /// The appearance of the response.
    public enum ResponseAppearance {

        /// The regular appearance.
        case `default`
        /// The suggested appearance.
        case suggested
        /// The destructive appearance.
        case destructive

    }

    /// The role of the response, determining a keyboard shortcut.
    public enum ResponseRole {

        /// The close role.
        case close
        /// The default role.
        case `default`

    }

    /// Get the container of the child.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = child.storage(modifiers: modifiers)
        storage.fields[Self.visibleID + id] = _visible
        update(storage, modifiers: modifiers, updateProperties: true)
        return storage
    }

    /// Update the view storage of the child, dialog, and dialog content.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    ///     - updateProperties: Whether to update properties.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
        child.widget(modifiers: modifiers).update(storage, modifiers: modifiers, updateProperties: updateProperties)
        guard updateProperties else {
            return
        }
        if visible {
            var present = false
            if storage.content[Self.dialogID + id]?.first == nil {
                createDialog(storage: storage, modifiers: modifiers)
                present = true
            }
            let pointer = storage.content[Self.dialogID + id]?.first?.pointer
            adw_alert_dialog_set_heading(pointer?.cast(), heading)
            adw_alert_dialog_set_body(pointer?.cast(), body)
            let old = storage.fields[Self.responsesID + id] as? [Response] ?? []
            old.identifiableTransform(
                to: responses,
                functions: .init { index, element in
                    adw_alert_dialog_remove_response(pointer?.cast(), responseID(old[safe: index]?.id))
                    adw_alert_dialog_add_response(pointer?.cast(), responseID(element.id), element.title)
                } delete: { index in
                    adw_alert_dialog_remove_response(pointer?.cast(), responseID(old[safe: index]?.id))
                } insert: { _, element in
                    adw_alert_dialog_add_response(pointer?.cast(), responseID(element.id), element.title)
                }
            )
            storage.fields[Self.responsesID + id] = responses
            var handlers: [String: () -> Void] = [:]
            for response in responses {
                handlers[responseID(response.id) ?? ""] = response.action
            }
            storage.fields[Self.callbacks + id] = handlers
            responsesCosmetics(pointer: pointer)
            if present {
                gtui_alertdialog_choose(
                    .init(Int(bitPattern: pointer)),
                    unsafeBitCast(storage, to: UInt64.self),
                    .init(Int(bitPattern: storage.pointer))
                )
            }
        } else {
            if storage.content[Self.dialogID + id]?.first != nil {
                adw_dialog_close(storage.content[Self.dialogID + id]?.first?.pointer?.cast())
            }
        }
    }

    /// Style the responses and add shortcuts if required.
    /// - Parameter pointer: The pointer.
    func responsesCosmetics(pointer: OpaquePointer?) {
        for element in responses {
            switch element.appearance {
            case .default:
                adw_alert_dialog_set_response_appearance(
                    pointer?.cast(),
                    responseID(element.id),
                    ADW_RESPONSE_DEFAULT
                )
            case .suggested:
                adw_alert_dialog_set_response_appearance(
                    pointer?.cast(),
                    responseID(element.id),
                    ADW_RESPONSE_SUGGESTED
                )
            case .destructive:
                adw_alert_dialog_set_response_appearance(
                    pointer?.cast(),
                    responseID(element.id),
                    ADW_RESPONSE_DESTRUCTIVE
                )
            }
        }
        if let closeResponse = responses.first(where: { $0.role == .close }) ?? responses.first {
            adw_alert_dialog_set_close_response(pointer?.cast(), responseID(closeResponse.id))
        }
        if let defaultResponse = responses.first(where: { $0.role == .default }) {
            adw_alert_dialog_set_default_response(pointer?.cast(), responseID(defaultResponse.id))
        }
    }

    /// Create a new instance of the dialog.
    /// - Parameters:
    ///     - storage: The wrapped view's storage.
    ///     - modifiers: The view modifiers.
    func createDialog(storage: ViewStorage, modifiers: [(View) -> View]) {
        let pointer = adw_alert_dialog_new(nil, nil)
        let dialog = ViewStorage(pointer?.opaque())
        storage.content[Self.dialogID + id] = [dialog]
    }

    /// Get the identifier of a response which is combined with the dialog's id.
    /// - Parameter id: The response identifier.
    /// - Returns: The new identifier.
    func responseID(_ id: String?) -> String? {
        if let id {
            return self.id + "...." + id
        }
        return nil
    }

    /// Add a response to the alert dialog.
    /// - Parameters:
    ///     - title: The response.
    ///     - appearance: The response's appearance.
    ///     - role: The response's shortcut, if any.
    ///     - action: The
    public func response(
        _ title: String,
        appearance: ResponseAppearance = .default,
        role: ResponseRole? = nil,
        action: @escaping () -> Void
    ) -> Self {
        var newSelf = self
        newSelf.responses.append(.init(title: title, appearance: appearance, role: role, action: action))
        return newSelf
    }

}

extension View {

    /// Add an alert dialog to the parent window.
    /// - Parameters:
    ///     - visible: Whether the dialog is presented.
    ///     - heading: The heading.
    ///     - body: The body text.
    public func alertDialog(
        visible: Binding<Bool>,
        heading: String,
        body: String = "",
        id: String? = nil
    ) -> AlertDialog {
        .init(
            visible: visible,
            id: id ?? "no-id",
            heading: heading,
            body: body,
            child: self
        )
    }

}

/// Run when an alert dialog closes.
/// - Parameters:
///   - ptr: The pointer.
///   - answer: The identifier of the answer.
///   - userData: The alert dialog data.
@_cdecl("alertdialog_on_close_cb")
func alertdialog_on_close_cb(
    ptr: UnsafeMutableRawPointer,
    answer: UnsafePointer<CChar>?,
    userData: UnsafeMutableRawPointer
) {
    let storage = Unmanaged<ViewStorage>.fromOpaque(userData).takeUnretainedValue()
    var id = ""
    if let answer {
        let answer = String(cString: answer)
        id = .init(answer.split(separator: "....").first ?? "")
        (storage.fields[AlertDialog.callbacks + id] as? [String: () -> Void])?[answer]?()
    }
    storage.content[AlertDialog.dialogID + id] = []
    storage.fields[AlertDialog.responsesID + id] = []
    if let visible = storage.fields[AlertDialog.visibleID + id] as? Binding<Bool>, visible.wrappedValue {
        visible.wrappedValue = false
    }
}
