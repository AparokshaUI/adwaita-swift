//
//  StateWrapper.swift
//  Adwaita
//
//  Created by david-swift on 26.09.23.
//

/// A storage for `@State` properties.
public struct StateWrapper: Widget {

    /// The content.
    var content: () -> Body
    /// The state information (from properties with the `State` wrapper).
    var state: [String: StateProtocol] = [:]

    /// Initialize a `StateWrapper`.
    /// - Parameter content: The view content.
    public init(@ViewBuilder content: @escaping () -> Body) {
        self.content = content
    }

    /// Initialize a `StateWrapper`.
    /// - Parameters:
    ///   - content: The view content.
    ///   - state: The state information.
    init(content: @escaping () -> Body, state: [String: StateProtocol]) {
        self.content = content
        self.state = state
    }

    /// Update a view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    ///     - updateProperties: Whether to update properties.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
        var updateProperties = updateProperties
        for property in state {
            if let storage = storage.state[property.key]?.content.storage {
                property.value.content.storage = storage
            }
            if property.value.content.storage.update {
                updateProperties = true
                property.value.content.storage.update = false
            }
        }
        if let storage = storage.content[.mainContent]?.first {
            content()
                .widget(modifiers: modifiers)
                .update(storage, modifiers: modifiers, updateProperties: updateProperties)
        }
    }

    /// Get a view storage.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let content = content().widget(modifiers: modifiers).container(modifiers: modifiers)
        return .init(content.pointer, content: [.mainContent: [content]], state: state)
    }

}
