//
//  View.swift
//  Adwaita
//
//  Created by david-swift on 05.08.23.
//

/// A structure conforming to `View` is referred to as a view.
/// It can be part of a body.
///
/// ```swift
/// struct Test: View {
///
///     var view: Body {
///         AnotherView()
///     }
///
/// }
/// ```
/// 
public protocol View {

    /// The view's content.
    @ViewBuilder var view: Body { get }

}

extension View {

    /// Wrap the view into a widget.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The widget.
    public func widget(modifiers: [(View) -> View]) -> Widget {
        let modified = getModified(modifiers: modifiers)
        if let peer = modified as? Widget {
            return peer
        } else {
            return StateWrapper(content: { view }, state: getState())
        }
    }

    /// Update a storage to a view.
    /// - Parameters:
    ///     - storage: The storage.
    ///     - modifiers: Modify views before being updated.
    public func updateStorage(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        let modified = getModified(modifiers: modifiers)
        if let widget = modified as? Widget {
            widget.update(storage, modifiers: modifiers)
        } else {
            StateWrapper(content: { view }, state: getState()).update(storage, modifiers: modifiers)
        }
    }

    func getState() -> [String: StateProtocol] {
        var state: [String: StateProtocol] = [:]
        for property in Mirror(reflecting: self).children {
            if let label = property.label, let value = property.value as? StateProtocol {
                state[label] = value
            }
        }
        return state
    }

    /// Get a storage.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The storage.
    public func storage(modifiers: [(View) -> View]) -> ViewStorage {
        widget(modifiers: modifiers).container(modifiers: modifiers)
    }

    func getModified(modifiers: [(View) -> View]) -> View {
        var modified: View = self
        for modifier in modifiers {
            modified = modifier(modified)
        }
        return modified
    }

}

/// `Body` is an array of views.
public typealias Body = [View]
