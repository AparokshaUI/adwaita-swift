//
//  InspectorWrapper.swift
//  Adwaita
//
//  Created by david-swift on 10.09.23.
//

import GTUI

/// A widget which executes a custom code on the GTUI widget when being created and updated.
struct InspectorWrapper: Widget {

    /// The custom code to edit the widget.
    var modify: (NativeWidgetPeer?) -> Void
    /// The wrapped view.
    var content: View

    /// Get the content's container.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The content's container.
    func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = content.storage(modifiers: modifiers)
        modify(storage.view)
        return storage
    }

    /// Update the content.
    /// - Parameters:
    ///     - storage: The content's storage.
    ///     - modifiers: Modify views before being updated.
    func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        content.updateStorage(storage, modifiers: modifiers)
        modify(storage.view)
    }

}

extension View {

    /// Modify a GTUI widget before being displayed and when being updated.
    /// - Parameter modify: Modify the widget.
    /// - Returns: A view.
    public func inspect(_ modify: @escaping (NativeWidgetPeer?) -> Void) -> View {
        InspectorWrapper(modify: modify, content: self)
    }

    /// Add padding around a view.
    /// - Parameters:
    ///   - padding: The size of the padding.
    ///   - edges: The edges which are affected by the padding.
    /// - Returns: A view.
    public func padding(_ padding: Int = 10, _ edges: Set<Edge> = .all) -> View {
        inspect { _ = $0?.padding(padding, edges) }
    }

    /// Enable or disable the horizontal expansion.
    /// - Parameter enabled: Whether it is enabled or disabled.
    /// - Returns: A view.
    public func hexpand(_ enabled: Bool = true) -> View {
        inspect { _ = $0?.hexpand() }
    }

    /// Enable or disable the vertical expansion.
    /// - Parameter enabled: Whether it is enabled or disabled.
    /// - Returns: A view.
    public func vexpand(_ enabled: Bool = true) -> View {
        inspect { _ = $0?.vexpand() }
    }

    /// Set the horizontal alignment.
    /// - Parameter align: The alignment.
    /// - Returns: A view.
    public func halign(_ align: Alignment) -> View {
        inspect { _ = $0?.halign(align) }
    }

    /// Set the vertical alignment.
    /// - Parameter align: The alignment.
    /// - Returns: A view.
    public func valign(_ align: Alignment) -> View {
        inspect { _ = $0?.valign(align) }
    }

    /// Set the view's minimal width or height.
    /// - Parameters:
    ///   - minWidth: The minimal width.
    ///   - minHeight: The minimal height.
    /// - Returns: A view.
    public func frame(minWidth: Int? = nil, minHeight: Int? = nil) -> View {
        inspect { _ = $0?.frame(minWidth: minWidth, minHeight: minHeight) }
    }

    /// Set the view's transition.
    /// - Parameter transition: The transition.
    /// - Returns: A view.
    public func transition(_ transition: Transition) -> View {
        inspect { $0?.fields[.transition] = transition }
    }

    /// Set the view's navigation title.
    /// - Parameter label: The navigation title.
    /// - Returns: A view.
    public func navigationTitle(_ label: String) -> View {
        inspect { $0?.fields[.navigationLabel] = label }
    }

    /// Add a style class to the view.
    /// - Parameter style: The style class.
    /// - Returns: A view.
    public func style(_ style: String) -> View {
        inspect { _ = $0?.addStyle(style) }
    }

    /// Run a function when the view appears for the first time.
    /// - Parameter closure: The function.
    /// - Returns: A view.
    public func onAppear(_ closure: @escaping () -> Void) -> View {
        inspect { _ in closure() }
    }

}
