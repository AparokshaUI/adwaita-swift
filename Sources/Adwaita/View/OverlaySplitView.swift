//
//  OverlaySplitView.swift
//  Adwaita
//
//  Created by david-swift on 19.12.23.
//

import Libadwaita

/// An overlay split view widget.
public struct OverlaySplitView: Widget {

    /// The sidebar's content.
    var sidebar: () -> Body
    /// The split view's main content.
    var content: () -> Body
    /// Whether the sidebar is at the trailing position.
    var trailing = false
    /// Whether the sidebar is visible.
    var visible: Bool

    /// The sidebar content's id.
    let sidebarID = "sidebar"
    /// The main content's id.
    let contentID = "content"

    /// Initialize an overlay split view.
    /// - Parameters:
    ///   - visible: Whether the sidebar is visible.
    ///   - sidebar: The sidebar content.
    ///   - content: The main content.
    public init(
        visible: Bool = true,
        @ViewBuilder sidebar: @escaping () -> Body,
        @ViewBuilder content: @escaping () -> Body
    ) {
        self.sidebar = sidebar
        self.content = content
        self.visible = visible
    }

    /// The position of the sidebar.
    /// - Parameter trailing: Whether the sidebar is at the trailing position.
    /// - Returns: The navigation split view.
    public func trailingSidebar(_ trailing: Bool = true) -> Self {
        var newSelf = self
        newSelf.trailing = trailing
        return newSelf
    }

    /// Get the container of the overlay split view widget.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let splitView: Libadwaita.OverlaySplitView = .init()
        var content: [String: [ViewStorage]] = [:]

        let sidebar = sidebar().widget(modifiers: modifiers).container(modifiers: modifiers)
        _ = splitView.sidebar(sidebar.view)
        content[sidebarID] = [sidebar]

        let mainContent = self.content().widget(modifiers: modifiers).container(modifiers: modifiers)
        _ = splitView.content(mainContent.view)
        content[contentID] = [mainContent]

        updatePosition(splitView)

        return .init(splitView, content: content)
    }

    /// Update the view storage of the overlay split view widget.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let storage = storage.content[contentID]?[safe: 0] {
            content().widget(modifiers: modifiers).update(storage, modifiers: modifiers)
        }
        if let storage = storage.content[sidebarID]?[safe: 0] {
            sidebar().widget(modifiers: modifiers).update(storage, modifiers: modifiers)
        }
        if let splitView = storage.view as? Libadwaita.OverlaySplitView {
            updatePosition(splitView)
        }
    }

    /// Update the sidebar's position in the split view.
    /// - Parameter splitView: The overlay split view.
    func updatePosition(_ splitView: Libadwaita.OverlaySplitView) {
        _ = splitView.position(trailing: trailing)
        if visible {
            splitView.showSidebar()
        } else {
            splitView.hideSidebar()
        }
    }

}
