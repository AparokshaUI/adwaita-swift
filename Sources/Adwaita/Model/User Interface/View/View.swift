//
//  View.swift
//  Adwaita
//
//  Created by david-swift on 05.08.23.
//

import GTUI

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
    /// - Returns: The widget.
    public func widget() -> Widget {
        if let peer = self as? Widget {
            return peer
        } else {
            var state: [String: StateProtocol] = [:]
            for property in Mirror(reflecting: self).children {
                if let label = property.label, let value = property.value as? StateProtocol {
                    state[label] = value
                }
            }
            return StateWrapper(content: { view }, state: state)
        }
    }

    /// Update a storage to a view.
    /// - Parameter storage: The storage.
    func updateStorage(_ storage: ViewStorage) {
        if let widget = self as? Widget {
            widget.update(storage)
        } else {
            StateWrapper { self }.update(storage)
        }
    }

    /// Get a storage.
    /// - Returns: The storage.
    func storage() -> ViewStorage {
        widget().container()
    }

}

/// `Body` is an array of views.
public typealias Body = [View]
