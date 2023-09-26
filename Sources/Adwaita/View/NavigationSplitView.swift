//
//  NavigationSplitView.swift
//  Adwaita
//
//  Created by david-swift on 24.09.23.
//

import GTUI

/// A navigation split view widget.
public struct NavigationSplitView: Widget {

    /// The sidebar's content.
    var sidebar: () -> Body
    /// The split view's main content.
    var content: () -> Body

    /// The sidebar content's id.
    let sidebarID = "sidebar"
    /// The main content's id.
    let contentID = "content"

    /// Initialize a navigation split view.
    /// - Parameters:
    ///   - sidebar: The sidebar content.
    ///   - content: The main content.
    public init(@ViewBuilder sidebar: @escaping () -> Body, @ViewBuilder content: @escaping () -> Body) {
        self.sidebar = sidebar
        self.content = content
    }

    /// Get the container of the navigation split view widget.
    /// - Returns: The view storage.
    public func container() -> ViewStorage {
        let splitView: GTUI.NavigationSplitView = .init()
        var content: [String: [ViewStorage]] = [:]

        let sidebar = sidebar().widget().container()
        let label = sidebar.view.fields[.navigationLabel] as? String ?? ""
        _ = splitView.sidebar(sidebar.view, title: label)
        content[sidebarID] = [sidebar]

        let mainContent = self.content().widget().container()
        let mainLabel = mainContent.view.fields[.navigationLabel] as? String ?? ""
        _ = splitView.content(mainContent.view, title: mainLabel)
        content[contentID] = [mainContent]

        return .init(splitView, content: content)
    }

    /// Update the view storage of the navigation split view widget.
    /// - Parameter storage: The view storage.
    public func update(_ storage: ViewStorage) {
        if let storage = storage.content[contentID]?[safe: 0] {
            content().widget().update(storage)
        }
        if let storage = storage.content[sidebarID]?[safe: 0] {
            sidebar().widget().update(storage)
        }
    }

}
