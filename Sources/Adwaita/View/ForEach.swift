//
//  ForEach.swift
//  Adwaita
//
//  Created by david-swift on 30.01.24.
//

import CAdw
import LevenshteinTransformations

/// A dynamic list but without a list design in the user interface.
public struct ForEach<Element>: AdwaitaWidget where Element: Identifiable {

    /// The dynamic widget elements.
    var elements: [Element]
    /// The dynamic widget content.
    var content: (Element) -> Body
    /// Whether the list is horizontal.
    var horizontal: Bool

    /// Initialize `ForEach`.
    public init(_ elements: [Element], horizontal: Bool = false, @ViewBuilder content: @escaping (Element) -> Body) {
        self.elements = elements
        self.content = content
        self.horizontal = horizontal
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(
        data: WidgetData,
        type: Data.Type
    ) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(
            gtk_box_new(horizontal ? GTK_ORIENTATION_HORIZONTAL : GTK_ORIENTATION_VERTICAL, 0)?.opaque()
        )
        update(storage, data: data, updateProperties: true, type: type)
        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The type of the app storage.
    public func update<Data>(
        _ storage: ViewStorage,
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        var contentStorage: [ViewStorage] = storage.content[.mainContent] ?? []
        let old = storage.fields["element"] as? [Element] ?? []
        let widget: UnsafeMutablePointer<GtkBox>? = storage.opaquePointer?.cast()
        old.identifiableTransform(
            to: elements,
            functions: .init { index, element in
                let child = content(element).storage(data: data, type: type)
                gtk_box_remove(widget, contentStorage[safe: index]?.opaquePointer?.cast())
                gtk_box_insert_child_after(
                    widget,
                    child.opaquePointer?.cast(),
                    contentStorage[safe: index - 1]?.opaquePointer?.cast()
                )
                contentStorage.remove(at: index)
                contentStorage.insert(child, at: index)
            } delete: { index in
                gtk_box_remove(widget, contentStorage[safe: index]?.opaquePointer?.cast())
                contentStorage.remove(at: index)
            } insert: { index, element in
                let child = content(element).storage(data: data, type: type)
                gtk_box_insert_child_after(
                    widget,
                    child.opaquePointer?.cast(),
                    contentStorage[safe: index - 1]?.opaquePointer?.cast()
                )
                contentStorage.insert(child, at: index)
            }
        )
        if updateProperties {
            gtk_orientable_set_orientation(
                widget?.opaque(),
                horizontal ? GTK_ORIENTATION_HORIZONTAL : GTK_ORIENTATION_VERTICAL
            )
        }
        storage.fields["element"] = elements
        storage.content[.mainContent] = contentStorage
        for (index, element) in elements.enumerated() {
            content(element)
                .updateStorage(
                    contentStorage[index],
                    data: data,
                    updateProperties: updateProperties,
                    type: type
                )
        }
    }

}
