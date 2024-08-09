//
//  MenuItem.swift
//  Adwaita
//
//  Created by david-swift on 22.10.23.
//

import CAdw

/// A structure representing the content for a certain menu item type.
public protocol MenuItem: MenuItemGroup {

    /// Add the menu item to a certain menu.
    /// - Parameters:
    ///   - menu: The menu.
    ///   - app: The application containing the menu.
    ///   - window: The application window containing the menu.
    func addMenuItem(menu: OpaquePointer?, app: GTUIApp, window: GTUIApplicationWindow?)

}

/// An extension
extension MenuItem {

    /// The menu item's content is itself.
    @MenuBuilder public var content: MenuContent { self }

}
