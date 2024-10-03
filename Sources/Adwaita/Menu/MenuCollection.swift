//
//  MenuCollection.swift
//  Adwaita
//
//  Created by david-swift on 02.08.2024.
//

import CAdw
import Foundation

/// A collection of menus.
public struct MenuCollection: MenuWidget, Wrapper {

    /// The content of the collection.
    var content: Body

    /// Initialize a menu.
    /// - Parameter content: The content of the collection.
    public init(@ViewBuilder content: @escaping () -> Body) {
        self.content = content()
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
        let storages = content.storages(data: data, type: type)
        return .init(nil, content: [.mainContent: storages])
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
        guard let storages = storage.content[.mainContent] else {
            return
        }
        content.update(storages, data: data, updateProperties: updateProperties, type: type)
    }

    /// Render the collection as a menu.
    /// - Parameter data: The widget data.
    /// - Returns: The view storage with the GMenu as the pointer.
    public func getMenu(data: WidgetData) -> ViewStorage {
        let menu = g_menu_new()
        let storage = container(data: data.noModifiers, type: MenuContext.self)
        if let app = data.appStorage as? AdwaitaApp, let window = data.sceneStorage.pointer as? AdwaitaWindow {
            initializeMenu(menu: menu, storage: storage, app: app, window: window)
        }
        storage.pointer = menu
        return storage
    }

    /// Initialize a menu.
    /// - Parameters:
    ///     - menu: The pointer to the GMenu.
    ///     - storage: The storage for the menu's content.
    ///     - app: The app object.
    ///     - window: The window object.
    func initializeMenu(menu: OpaquePointer?, storage: ViewStorage, app: AdwaitaApp, window: AdwaitaWindow?) {
        if let item = storage.opaquePointer {
            g_menu_append_item(menu, item)
            storage.pointer = item
        } else {
            for element in storage.content[.mainContent] ?? [] {
                initializeMenu(menu: menu, storage: element, app: app, window: window)
            }
        }
    }

}
