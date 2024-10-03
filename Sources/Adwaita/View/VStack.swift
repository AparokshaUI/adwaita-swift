//
//  VStack.swift
//  Adwaita
//
//  Created by david-swift on 23.08.23.
//

import CAdw

/// A GtkBox equivalent.
public typealias VStack = Box

extension VStack {

    /// Initialize a `VStack`.
    /// - Parameter content: The view content.
    public init(@ViewBuilder content: @escaping () -> Body) {
        self.init(horizontal: false, content: content)
    }

    /// Initialize a `VStack`.
    /// - Parameters:
    ///     - horizontal: Whether the box is horizontal.
    ///     - content: The view content.
    init(horizontal: Bool, @ViewBuilder content: @escaping () -> Body) {
        self.init(spacing: 0)
        self = self.append(content)
        if horizontal {
            appearFunctions.append { storage, _ in
                gtk_orientable_set_orientation(storage.opaquePointer, GTK_ORIENTATION_HORIZONTAL)
            }
        }
    }

    /// Link the children.
    public func linked(_ active: Bool = true) -> AnyView {
        style("linked", active: active)
    }

}

/// A wrapper around ``VStack`` which applies the ``VStack`` only if there is more than one view.
public struct VStackWrapper: AdwaitaWidget, Wrapper {

    /// The content.
    var content: Body

    /// Initialize the wrapper.
    /// - Parameter content: The view content.
    public init(@ViewBuilder content: () -> Body) {
        self.content = content()
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The view render data type.
    /// - Returns: The view storage.
    public func container<Data>(
        data: WidgetData,
        type: Data.Type
    ) -> ViewStorage where Data: ViewRenderData {
        if content.count == 1, let element = content.first {
            return element.storage(data: data, type: type)
        } else {
            return VStack { content }.storage(data: data, type: type)
        }
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The view render data type.
    public func update<Data>(
        _ storage: ViewStorage,
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        if content.count == 1, let element = content.first {
            element.updateStorage(storage, data: data, updateProperties: updateProperties, type: type)
        } else {
            VStack { content }
                .updateStorage(storage, data: data, updateProperties: updateProperties, type: type)
        }
    }

}
