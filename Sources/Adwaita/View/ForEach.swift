//
//  ForEach.swift
//  Adwaita
//
//  Created by david-swift on 30.01.24.
//

import CAdw
import LevenshteinTransformations

/// A dynamic list but without a list design in the user interface.
public struct ForEach<Element>: Widget where Element: Identifiable {

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

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(
            gtk_box_new(horizontal ? GTK_ORIENTATION_HORIZONTAL : GTK_ORIENTATION_VERTICAL, 0)?.opaque()
        )
        update(storage, modifiers: modifiers, updateProperties: true)
        return storage
    }

    /// Update the widget's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: The view modifiers.
    ///     - updateProperties: Whether to update the view's properties.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
        var contentStorage: [ViewStorage] = storage.content[.mainContent] ?? []
        let old = storage.fields["element"] as? [Element] ?? []
        let widget: UnsafeMutablePointer<GtkBox>? = storage.pointer?.cast()
        old.identifiableTransform(
            to: elements,
            functions: .init { index, element in
                let child = content(element).widget(modifiers: modifiers).container(modifiers: modifiers)
                gtk_box_remove(widget, contentStorage[safe: index]?.pointer?.cast())
                gtk_box_insert_child_after(widget, child.pointer?.cast(), contentStorage[safe: index]?.pointer?.cast())
                contentStorage.remove(at: index)
                contentStorage.insert(child, at: index)
            } delete: { index in
                gtk_box_remove(widget, contentStorage[safe: index]?.pointer?.cast())
                contentStorage.remove(at: index)
            } insert: { index, element in
                let child = content(element).widget(modifiers: modifiers).container(modifiers: modifiers)
                gtk_box_insert_child_after(widget, child.pointer?.cast(), contentStorage[safe: index]?.pointer?.cast())
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
                .widget(modifiers: modifiers)
                .update(contentStorage[index], modifiers: modifiers, updateProperties: updateProperties)
        }
    }

}
