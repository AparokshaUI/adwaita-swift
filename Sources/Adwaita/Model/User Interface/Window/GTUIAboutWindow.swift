//
//  GTUIAboutWindow.swift
//  Adwaita
//
//  Created by david-swift on 21.01.24.
//

import CAdw

/// A GTUI about window.
public class GTUIAboutWindow: GTUIWindow {

    /// Initialize an about window using the AppStream metadata.
    /// - Parameter filePath: The path.
    public init(filePath: String? = nil) {
        super.init(fields: [:])
        if let filePath {
            #if os(Windows)
            pointer = adw_about_window_new()?.cast()
            #else
            pointer = adw_about_window_new_from_appdata(filePath, nil)?.cast()
            #endif
        } else {
            pointer = adw_about_window_new()?.cast()
        }
    }

    /// Set the general data.
    /// - Parameters:
    ///     - title: The app name.
    ///     - icon: The app icon.
    ///     - developer: The app's developer.
    ///     - version: The app's version.
    public func generalData(title: String, icon: Icon, developer: String, version: String) {
        adw_about_window_set_application_name(.init(pointer), title)
        adw_about_window_set_application_icon(.init(pointer), icon.string)
        adw_about_window_set_developer_name(.init(pointer), developer)
        adw_about_window_set_version(.init(pointer), version)
    }

    /// Set the website.
    /// - Parameter url: The website.
    public func website(url: String) {
        adw_about_window_set_website(.init(pointer), url)
    }

    /// Set the URL for issues.
    /// - Parameter issues: The issues website.
    public func issues(url: String) {
        adw_about_window_set_issue_url(.init(pointer), url)
    }

}
