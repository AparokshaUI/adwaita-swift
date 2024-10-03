//
//  MenuButton.swift
//  Adwaita
//
//  Created by david-swift on 22.10.23.
//

import CAdw

/// A button widget for menus.
public struct MenuSection: MenuWidget {

    /// The content of the section.
    var sectionContent: Body

    /// Initialize a section for menus.
    /// - Parameter content: The content of the section.
    public init(@ViewBuilder content: () -> Body) {
        self.sectionContent = content()
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify the views before updating.
    ///     - type: The type of the views.
    /// - Returns: The view storage.
    public func container<Data>(
        data: WidgetData,
        type: Data.Type
    ) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(nil)
        let childStorage = MenuCollection { sectionContent }.getMenu(data: data)
        storage.content[.mainContent] = [childStorage]
        let pointer = g_menu_item_new_section(nil, childStorage.opaquePointer?.cast())
        storage.pointer = pointer
        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify the views before updating.
    ///     - updateProperties: Whether to update the properties.
    ///     - type: The type of the views.
    public func update<Data>(
        _ storage: ViewStorage,
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        guard let content = storage.content[.mainContent]?.first else {
            return
        }
        MenuCollection { sectionContent }
            .updateStorage(content, data: data, updateProperties: updateProperties, type: MenuContext.self)
    }

}
