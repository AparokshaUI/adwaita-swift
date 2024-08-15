//
//  NavigationSplitView.swift
//  Adwaita
//
//  Created by david-swift on 24.09.23.
//

import CAdw

/// A navigation split view widget.
public struct NavigationSplitView: AdwaitaWidget {

    /// The sidebar's content.
    var sidebar: Body
    /// The split view's main content.
    var content: Body
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
        self.sidebar = sidebar()
        self.content = content()
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(
        data: WidgetData,
        type: Data.Type
    ) -> ViewStorage where Data: ViewRenderData {
        let splitView = adw_navigation_split_view_new()
        var content: [String: [ViewStorage]] = [:]

        let sidebar = sidebar.storage(data: data, type: type)
        let label = sidebar.fields[.navigationLabel] as? String ?? ""
        let sidebarPage = adw_navigation_page_new(sidebar.opaquePointer?.cast(), label)
        adw_navigation_split_view_set_sidebar(.init(splitView), sidebarPage?.cast())
        content[sidebarID] = [sidebar]

        let mainContent = self.content.storage(data: data, type: type)
        let mainLabel = mainContent.fields[.navigationLabel] as? String ?? ""
        let mainPage = adw_navigation_page_new(mainContent.opaquePointer?.cast(), mainLabel)
        adw_navigation_split_view_set_content(.init(splitView), mainPage?.cast())
        content[contentID] = [mainContent]

        let storage = ViewStorage(splitView?.opaque(), content: content)
        update(storage, data: data, updateProperties: true, type: type)

        storage.notify(name: "show-content") {
            showContent?.wrappedValue = adw_navigation_split_view_get_show_content(storage.opaquePointer) != 0
        }

        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The type of the app storage.
    public func update<Data>(
        _ storage: ViewStorage,
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        if let storage = storage.content[contentID]?[safe: 0] {
            content
                .updateStorage(storage, data: data, updateProperties: updateProperties, type: type)
        }
        if let storage = storage.content[sidebarID]?[safe: 0] {
            sidebar
                .updateStorage(storage, data: data, updateProperties: updateProperties, type: type)
        }
        guard updateProperties else {
            return
        }
        let collapsed = adw_navigation_split_view_get_collapsed(storage.opaquePointer) != 0
        if collapsed != self.collapsed {
            adw_navigation_split_view_set_collapsed(storage.opaquePointer, self.collapsed.cBool)
        }
        let showContent = adw_navigation_split_view_get_show_content(storage.opaquePointer) != 0
        if let binding = self.showContent, showContent != binding.wrappedValue {
            adw_navigation_split_view_set_show_content(storage.opaquePointer, binding.wrappedValue.cBool)
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
