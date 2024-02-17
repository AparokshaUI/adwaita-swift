//
//  UpdateManager.swift
//  Adwaita
//
//  Created by david-swift on 17.02.23.
//

/// This type manages view updates.
enum UpdateManager {

    /// The class storing the value.
    static var blockUpdates = false

    /// Update all of the views.
    /// - Parameter force: Whether to force all views to update.
    static func updateViews(force: Bool = false) {
        if !blockUpdates {
            for handler in GTUIApp.updateHandlers {
                handler(force)
            }
        }
    }

}
