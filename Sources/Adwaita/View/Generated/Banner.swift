//
//  Banner.swift
//  Adwaita
//
//  Created by auto-generation on 04.02.24.
//

import CAdw
import LevenshteinTransformations

/// A bar with contextual information.
/// 
/// <picture><source srcset="banner-dark.png" media="(prefers-color-scheme: dark)"><img src="banner.png" alt="banner"></picture>
/// 
/// Banners are hidden by default, use [property@Banner:revealed] to show them.
/// 
/// Banners have a title, set with [property@Banner:title]. Titles can be marked
/// up with Pango markup, use [property@Banner:use-markup] to enable it.
/// 
/// The title will be shown centered or left-aligned depending on available
/// space.
/// 
/// Banners can optionally have a button with text on it, set through
/// [property@Banner:button-label]. The button can be used with a `GAction`,
/// or with the [signal@Banner::button-clicked] signal.
/// 
/// ## CSS nodes
/// 
/// `AdwBanner` has a main CSS node with the name `banner`.
public struct Banner: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage) -> Void] = []

    /// The label to show on the button.
    /// 
    /// If set to `""` or `NULL`, the button won't be shown.
    /// 
    /// The button can be used with a `GAction`, or with the
    /// [signal@Banner::button-clicked] signal.
    var buttonLabel: String?
    /// Whether the banner is currently revealed.
    var revealed: Bool?
    /// The title for this banner.
    /// 
    /// See also: [property@Banner:use-markup].
    var title: String
    /// Whether to use Pango markup for the banner title.
    /// 
    /// See also [func@Pango.parse_markup].
    var useMarkup: Bool?
    /// This signal is emitted after the action button has been clicked.
    /// 
    /// It can be used as an alternative to setting an action.
    var buttonClicked: (() -> Void)?
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `Banner`.
    public init(title: String) {
        self.title = title
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(adw_banner_new(title)?.opaque())
        update(storage, modifiers: modifiers, updateProperties: true)


        for function in appearFunctions {
            function(storage)
        }
        return storage
    }

    /// Update the widget's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: The view modifiers.
    ///     - updateProperties: Whether to update the view's properties.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
        if let buttonClicked {
            storage.connectSignal(name: "button-clicked", argCount: 0) {
                buttonClicked()
            }
        }
        storage.modify { widget in
            if let buttonLabel, updateProperties {
                adw_banner_set_button_label(widget, buttonLabel)
            }
            if let revealed, updateProperties {
                adw_banner_set_revealed(widget, revealed.cBool)
            }
            if updateProperties {
                adw_banner_set_title(widget, title)
            }
            if let useMarkup, updateProperties {
                adw_banner_set_use_markup(widget, useMarkup.cBool)
            }


        }
        for function in updateFunctions {
            function(storage)
        }
    }

    /// The label to show on the button.
    /// 
    /// If set to `""` or `NULL`, the button won't be shown.
    /// 
    /// The button can be used with a `GAction`, or with the
    /// [signal@Banner::button-clicked] signal.
    public func buttonLabel(_ buttonLabel: String?) -> Self {
        var newSelf = self
        newSelf.buttonLabel = buttonLabel
        
        return newSelf
    }

    /// Whether the banner is currently revealed.
    public func revealed(_ revealed: Bool? = true) -> Self {
        var newSelf = self
        newSelf.revealed = revealed
        
        return newSelf
    }

    /// The title for this banner.
    /// 
    /// See also: [property@Banner:use-markup].
    public func title(_ title: String) -> Self {
        var newSelf = self
        newSelf.title = title
        
        return newSelf
    }

    /// Whether to use Pango markup for the banner title.
    /// 
    /// See also [func@Pango.parse_markup].
    public func useMarkup(_ useMarkup: Bool? = true) -> Self {
        var newSelf = self
        newSelf.useMarkup = useMarkup
        
        return newSelf
    }

    /// This signal is emitted after the action button has been clicked.
    /// 
    /// It can be used as an alternative to setting an action.
    public func buttonClicked(_ buttonClicked: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.buttonClicked = buttonClicked
        return newSelf
    }

}
