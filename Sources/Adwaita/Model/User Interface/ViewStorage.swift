//
//  ViewStorage.swift
//  Adwaita
//
//  Created by david-swift on 31.08.23.
//

import GTUI

/// Store a rendered view in a view storage.
public class ViewStorage {

    /// The GTUI widget.
    public var view: NativeWidgetPeer
    /// The view's content.
    public var content: [String: [ViewStorage]]
    /// The view's state (used in `StateWrapper`).
    public var state: [String: StateProtocol]

    /// Initialize a view storage.
    /// - Parameters:
    ///   - view: The GTUI widget.
    ///   - content: The view's content.
    ///   - state: The view's state.
    public init(
        _ view: NativeWidgetPeer,
        content: [String: [ViewStorage]] = [:],
        state: [String: StateProtocol] = [:]
    ) {
        self.view = view
        self.content = content
        self.state = state
    }

}
