//
//  AboutWindow.swift
//  Adwaita
//
//  Created by david-swift on 05.12.23.
//

import CAdw
import Foundation

/// A structure representing an about window.
public struct AboutWindow: WindowScene {

    /// The window's identifier.
    public var id: String
    /// Whether an instance of the window type should be opened when the app is starting up.
    public let `open` = 0
    /// The identifier of the window's parent.
    public var parentID: String?
    /// The keyboard shortcuts on the app level.
    public var appShortcuts: [String: (GTUIApp) -> Void] = [:]
    /// The app's name.
    var appName: String?
    /// The developer's name.
    var developer: String?
    /// The app version.
    var version: String?
    /// The app icon.
    var icon: Icon?
    /// The app's website.
    var website: URL?
    /// The link for opening issues.
    var issues: URL?
    /// The path to the app data file.
    var path: URL?

    /// Create a window type with a certain identifier and content.
    /// - Parameters:
    ///   - id: The identifier.
    ///   - appName: The app's name.
    ///   - developer: The developer's name.
    ///   - version: The app version.
    public init(id: String, appName: String, developer: String, version: String) {
        self.id = id
        self.appName = appName
        self.developer = developer
        self.version = version
    }

    /// Create a window type with a certain identifier and content.
    /// - Parameters:
    ///   - id: The identifier.
    ///   - path: The path to the app data file.
    public init(id: String, path: URL) {
        self.id = id
        self.path = path
    }

    /// Set the app icon.
    /// - Parameter icon: The app icon.
    /// - Returns: The window.
    public func icon(_ icon: Icon) -> Self {
        var newSelf = self
        newSelf.icon = icon
        return newSelf
    }

    /// Set the app's website.
    /// - Parameter url: The app's website.
    /// - Returns: The window.
    public func website(_ url: URL?) -> Self {
        var newSelf = self
        newSelf.website = url
        return newSelf
    }

    /// Set the app's website.
    /// - Parameter url: The URL to the issue tracker.
    /// - Returns: The window.
    public func issues(_ url: URL?) -> Self {
        var newSelf = self
        newSelf.issues = url
        return newSelf
    }

    /// Get the storage for the window.
    /// - Parameter app: The application.
    /// - Returns: The storage.
    public func createWindow(app: GTUIApp) -> WindowStorage {
        let window = createGTUIWindow(app: app)
        let windowStorage = WindowStorage(id: id, window: window, view: nil)
        windowStorage.parentID = parentID
        return windowStorage
    }

    /// Get the window.
    /// - Parameter app: The application.
    /// - Returns: The window.
    func createGTUIWindow(app: GTUIApp) -> GTUIAboutWindow {
        let window: GTUIAboutWindow
        if let path {
            window = .init(filePath: path.path)
        } else {
            window = .init()
        }
        updateAppShortcuts(app: app)
        updateData(window: window)
        window.show()
        return window
    }

    /// Update a window.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - app: The application.
    ///     - force: Whether to force update all the views.
    public func update(_ storage: WindowStorage, app: GTUIApp, force: Bool) {
        updateAppShortcuts(app: app)
        storage.destroy = true
    }

    /// Update the data for a window.
    /// - Parameter window: The window.
    func updateData(window: GTUIAboutWindow) {
        if let appName, let icon, let developer, let version {
            window.generalData(title: appName, icon: icon, developer: developer, version: version)
        }
        if let website { window.website(url: website.absoluteString) }
        if let issues { window.issues(url: issues.absoluteString) }
    }

}
