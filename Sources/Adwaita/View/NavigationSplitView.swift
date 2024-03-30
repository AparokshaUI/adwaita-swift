//
//  NavigationSplitView.swift
//  Adwaita
//
//  Created by david-swift on 24.09.23.
//

import CAdw

/// A navigation split view widget.
public struct NavigationSplitView: Widget {

    /// The sidebar's content.
    var sidebar: () -> Body
    /// The split view's main content.
    var content: () -> Body
    /// Whether the split view is collapsed.
    var collapsed = false
    /// Whether the content is visible (if the split view is collapsed).
    var showContent: Binding<Bool>?

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
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let splitView = adw_navigation_split_view_new()
        var content: [String: [ViewStorage]] = [:]

        let sidebar = sidebar().widget(modifiers: modifiers).container(modifiers: modifiers)
        let label = sidebar.fields[.navigationLabel] as? String ?? ""
        let sidebarPage = adw_navigation_page_new(sidebar.pointer?.cast(), label)
        adw_navigation_split_view_set_sidebar(.init(splitView), sidebarPage?.cast())
        content[sidebarID] = [sidebar]

        let mainContent = self.content().widget(modifiers: modifiers).container(modifiers: modifiers)
        let mainLabel = mainContent.fields[.navigationLabel] as? String ?? ""
        let mainPage = adw_navigation_page_new(mainContent.pointer?.cast(), mainLabel)
        adw_navigation_split_view_set_content(.init(splitView), mainPage?.cast())
        content[contentID] = [mainContent]

        let storage = ViewStorage(.init(splitView), content: content)
        update(storage, modifiers: modifiers, updateProperties: true)

        storage.notify(name: "show-content") {
            showContent?.wrappedValue = adw_navigation_split_view_get_show_content(storage.pointer) != 0
        }

        return storage
    }

    /// Update the view storage of the navigation split view widget.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    ///     - updateProperties: Whether to update properties.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
        if let storage = storage.content[contentID]?[safe: 0] {
            content()
                .widget(modifiers: modifiers)
                .update(storage, modifiers: modifiers, updateProperties: updateProperties)
        }
        if let storage = storage.content[sidebarID]?[safe: 0] {
            sidebar()
                .widget(modifiers: modifiers)
                .update(storage, modifiers: modifiers, updateProperties: updateProperties)
        }
        guard updateProperties else {
            return
        }
        let collapsed = adw_navigation_split_view_get_collapsed(storage.pointer) != 0
        if collapsed != self.collapsed {
            adw_navigation_split_view_set_collapsed(storage.pointer, self.collapsed.cBool)
        }
        let showContent = adw_navigation_split_view_get_show_content(storage.pointer) != 0
        if let binding = self.showContent, showContent != binding.wrappedValue {
            adw_navigation_split_view_set_show_content(storage.pointer, binding.wrappedValue.cBool)
        }
    }

    /// Whether the navigation split view is collapsed, meaning in its compact form.
    /// - Parameter collapsed: Whether the view is collapsed.
    /// - Returns: The navigation split view.
    public func collapsed(_ collapsed: Bool) -> Self {
        var newSelf = self
        newSelf.collapsed = collapsed
        return newSelf
    }

    /// Whether the content view is visible if the split view is collapsed.
    /// - Parameter showContent: Whether the content view is visible.
    /// - Returns: The navigation split view.
    public func showContent(_ showContent: Binding<Bool>) -> Self {
        var newSelf = self
        newSelf.showContent = showContent
        return newSelf
    }

}
