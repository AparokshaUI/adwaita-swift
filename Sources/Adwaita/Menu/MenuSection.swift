//
//  Submenu.swift
//  Adwaita
//
//  Created by david-swift on 22.10.23.
//

import CAdw

/// A section for menus.
public struct MenuSection: MenuItem {

    /// The content of the section.
    var sectionContent: MenuContent

    /// Initialize a section for menus.
    /// - Parameter content: The content of the section.
    public init(@MenuBuilder content: () -> MenuContent) {
        self.sectionContent = content()
    }

    /// Add the section to a menu.
    /// - Parameters:
    ///   - menu: The menu.
    ///   - app: The application containing the menu.
    ///   - window: The application window containing the menu.
    public func addMenuItem(menu: OpaquePointer?, app: GTUIApp, window: GTUIApplicationWindow?) {
        let section = g_menu_new()
        g_menu_append_section(menu, nil, section?.cast())
        for element in sectionContent {
            element.addMenuItems(menu: section, app: app, window: window)
        }
    }

}
