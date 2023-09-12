//
//  EitherView.swift
//  Adwaita
//
//  Created by david-swift on 23.08.23.
//

import GTUI

/// A GtkBox equivalent.
public struct VStack: Widget {

    /// The content.
    var content: () -> Body
    /// The state information (from properties with the `State` wrapper).
    var state: [String: StateProtocol] = [:]

    /// Initialize a `VStack`.
    /// - Parameter content: The view content.
    public init(@ViewBuilder content: @escaping () -> Body) {
        self.content = content
    }

    /// Initialize a `VStack`.
    /// - Parameters:
    ///   - content: The view content.
    ///   - state: The state information.
    init(content: @escaping () -> Body, state: [String: StateProtocol]) {
        self.content = content
        self.state = state
    }

    /// Update a view storage.
    /// - Parameter storage: The view storage.
    public func update(_ storage: ViewStorage) {
        for property in state {
            if let value = storage.state[property.key]?.value {
                property.value.value = value
            }
        }
        content().update(storage.content[.mainContent] ?? [])
    }

    /// Get a view storage.
    /// - Returns: The view storage.
    public func container() -> ViewStorage {
        let box: Box = .init(horizontal: false)
        var content: [ViewStorage] = []
        for element in self.content() {
            let widget = element.storage()
            _ = box.append(widget.view)
            content.append(widget)
        }
        return .init(box, content: [.mainContent: content], state: state)
    }

}
