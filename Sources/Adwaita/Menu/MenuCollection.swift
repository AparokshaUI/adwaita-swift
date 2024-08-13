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
        modifiers: [(any AnyView) -> any AnyView],
        type: Data.Type
    ) -> ViewStorage where Data: ViewRenderData {
        let storages = content.storages(modifiers: modifiers, type: type)
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
        modifiers: [(AnyView) -> AnyView],
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        guard let storages = storage.content[.mainContent] else {
            return
        }
        content.update(storages, modifiers: modifiers, updateProperties: updateProperties, type: type)
    }

    /// Render the collection as a menu.
    /// - Parameters:
    ///     - app: The app object.
    ///     - window: The window object.
    /// - Returns: The view storage with the GMenu as the pointer.
    public func getMenu(app: AdwaitaApp, window: AdwaitaWindow?) -> ViewStorage {
        let menu = g_menu_new()
        let storage = container(modifiers: [], type: MenuContext.self)
        initializeMenu(menu: menu, storage: storage, app: app, window: window)
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
        if storage.pointer == nil {
            for element in storage.content[.mainContent] ?? [] {
                initializeMenu(menu: menu, storage: element, app: app, window: window)
            }
        } else if let item = (storage.pointer as? (AdwaitaApp, AdwaitaWindow?) -> OpaquePointer?) {
            let item = item(app, window)
            g_menu_append_item(menu, item)
            storage.pointer = item
        }
    }

}
