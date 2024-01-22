//
//  OverlaySplitView+.swift
//  Adwaita
//
//  Created by david-swift on 21.01.23.
//

import CAdw

extension OverlaySplitView {

    /// Initialize an overlay split view.
    /// - Parameters:
    ///   - visible: Whether the sidebar is visible.
    ///   - sidebar: The sidebar content.
    ///   - content: The main content.
    public init(
        visible: Binding<Bool> = .constant(true),
        @ViewBuilder sidebar: @escaping () -> Body,
        @ViewBuilder content: @escaping () -> Body
    ) {
        self.init()
        self = self.sidebar(sidebar)
        self = self.content(content)
        self = self.showSidebar(visible)
    }

    /// The position of the sidebar.
    /// - Parameter trailing: Whether the sidebar is at the trailing position.
    /// - Returns: The navigation split view.
    public func trailingSidebar(_ trailing: Bool = true) -> Self {
        var newSelf = self
        newSelf.updateFunctions.append { storage in
            adw_overlay_split_view_set_sidebar_position(storage.pointer, trailing ? GTK_PACK_END : GTK_PACK_START)
        }
        return newSelf
    }

}
