//
//  MenuItemGroup.swift
//  Adwaita
//
//  Created by david-swift on 22.10.23.
//

import CAdw

/// A structure conforming to `MenuItemGroup` can be added to the content accepting a menu.
public protocol MenuItemGroup {

    /// The menu's content.
    @MenuBuilder var content: MenuContent { get }

}

extension MenuItemGroup {

    /// Add the menu items described by the group to a menu.
    /// - Parameter menu: The menu.
    func addMenuItems(menu: OpaquePointer?, app: GTUIApp, window: GTUIApplicationWindow?) {
        for element in content {
            if let item = element as? MenuItem {
                item.addMenuItem(menu: menu, app: app, window: window)
            } else {
                element.addMenuItems(menu: menu, app: app, window: window)
            }
        }
    }

}

/// `MenuContent` is an array of menu item groups.
public typealias MenuContent = [MenuItemGroup]
/// A builder for the `MenuContent`
public typealias MenuBuilder = ArrayBuilder<MenuItemGroup>
