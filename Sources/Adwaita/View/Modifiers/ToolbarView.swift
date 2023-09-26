//
//  ToolbarView.swift
//  Adwaita
//
//  Created by david-swift on 24.09.23.
//

import GTUI

/// A toolbar view widget.
struct ToolbarView: Widget {

    /// The sidebar's content.
    var content: View
    /// The toolbars.
    var toolbar: () -> Body
    /// Whether the toolbars are bottom toolbars.
    var bottom: Bool
    /// Whether the toolbar is visible.
    var visible: Bool

    /// The identifier of the toolbar content.
    let toolbarID = "toolbar"

    /// Get the container of the toolbar view widget.
    /// - Returns: The view storage.
    func container() -> ViewStorage {
        let content = content.storage()
        let view = GTUI.ToolbarView(content.view)
        var toolbarContent: [ViewStorage] = []
        for item in toolbar() {
            let storage = item.storage()
            toolbarContent.append(storage)
            if bottom {
                _ = view.addBottomBar(storage.view)
            } else {
                _ = view.addTopBar(storage.view)
            }
        }
        if bottom {
            view.setRevealBottomBar(visible)
        } else {
            view.setRevealTopBar(visible)
        }
        return .init(view, content: [.mainContent: [content], toolbarID: toolbarContent])
    }

    /// Update the view storage of the toolbar view widget.
    /// - Parameter storage: The view storage.
    func update(_ storage: ViewStorage) {
        if let mainContent = storage.content[.mainContent]?.first {
            content.widget().update(mainContent)
        }
        if let toolbar = storage.content[toolbarID] {
            for (index, content) in toolbar.enumerated() {
                self.toolbar()[safe: index]?.updateStorage(content)
            }
        }
        if let view = storage.view as? GTUI.ToolbarView {
            if bottom {
                view.setRevealBottomBar(visible)
            } else {
                view.setRevealTopBar(visible)
            }
        }
    }

}

extension View {

    /// Add a top toolbar to the view.
    /// - Parameters:
    ///   - toolbar: The toolbar's content.
    ///   - visible: Whether the toolbar is visible.
    /// - Returns: A view.
    public func topToolbar(visible: Bool = true, @ViewBuilder _ toolbar: @escaping () -> Body) -> View {
        ToolbarView(content: self, toolbar: toolbar, bottom: false, visible: visible)
    }

    /// Add a bottom toolbar to the view.
    /// - Parameters:
    ///   - toolbar: The toolbar's content.
    ///   - visible: Whether the toolbar is visible.
    /// - Returns: A view.
    public func bottomToolbar(visible: Bool = true, @ViewBuilder _ toolbar: @escaping () -> Body) -> View {
        ToolbarView(content: self, toolbar: toolbar, bottom: true, visible: visible)
    }

}
