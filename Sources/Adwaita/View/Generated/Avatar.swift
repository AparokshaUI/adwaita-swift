//
//  Avatar.swift
//  Adwaita
//
//  Created by auto-generation on 09.05.24.
//

import CAdw
import LevenshteinTransformations

/// A widget displaying an image, with a generated fallback.
/// 
/// <picture><source srcset="avatar-dark.png" media="(prefers-color-scheme: dark)"><img src="avatar.png" alt="avatar"></picture>
/// 
/// `AdwAvatar` is a widget that shows a round avatar.
/// 
/// `AdwAvatar` generates an avatar with the initials of  the
/// [property@Avatar:text] on top of a colored background.
/// 
/// The color is picked based on the hash of the [property@Avatar:text].
/// 
/// If [property@Avatar:show-initials] is set to `FALSE`,
/// [property@Avatar:icon-name] or `avatar-default-symbolic` is shown instead of
/// the initials.
/// 
/// Use [property@Avatar:custom-image] to set a custom image.
/// 
/// ## CSS nodes
/// 
/// `AdwAvatar` has a single CSS node with name `avatar`.
public struct Avatar: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(View) -> View], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(View) -> View]) -> Void] = []

    /// The name of an icon to use as a fallback.
    /// 
    /// If no name is set, `avatar-default-symbolic` will be used.
    var iconName: String?
    /// Whether initials are used instead of an icon on the fallback avatar.
    /// 
    /// See [property@Avatar:icon-name] for how to change the fallback icon.
    var showInitials: Bool
    /// The size of the avatar.
    var size: Int
    /// Sets the text used to generate the fallback initials and color.
    /// 
    /// It's only used to generate the color if [property@Avatar:show-initials] is
    /// `FALSE`.
    var text: String?
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `Avatar`.
    public init(showInitials: Bool, size: Int) {
        self.showInitials = showInitials
        self.size = size
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(adw_avatar_new(size.cInt, text, showInitials.cBool)?.opaque())
        for function in appearFunctions {
            function(storage, modifiers)
        }
        update(storage, modifiers: modifiers, updateProperties: true)

        return storage
    }

    /// Update the widget's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: The view modifiers.
    ///     - updateProperties: Whether to update the view's properties.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
        storage.modify { widget in

            if let iconName, updateProperties {
                adw_avatar_set_icon_name(widget, iconName)
            }
            if updateProperties {
                adw_avatar_set_show_initials(widget, showInitials.cBool)
            }
            if updateProperties {
                adw_avatar_set_size(widget, size.cInt)
            }
            if let text, updateProperties {
                adw_avatar_set_text(widget, text)
            }


        }
        for function in updateFunctions {
            function(storage, modifiers, updateProperties)
        }
    }

    /// The name of an icon to use as a fallback.
    /// 
    /// If no name is set, `avatar-default-symbolic` will be used.
    public func iconName(_ iconName: String?) -> Self {
        var newSelf = self
        newSelf.iconName = iconName
        
        return newSelf
    }

    /// Whether initials are used instead of an icon on the fallback avatar.
    /// 
    /// See [property@Avatar:icon-name] for how to change the fallback icon.
    public func showInitials(_ showInitials: Bool) -> Self {
        var newSelf = self
        newSelf.showInitials = showInitials
        
        return newSelf
    }

    /// The size of the avatar.
    public func size(_ size: Int) -> Self {
        var newSelf = self
        newSelf.size = size
        
        return newSelf
    }

    /// Sets the text used to generate the fallback initials and color.
    /// 
    /// It's only used to generate the color if [property@Avatar:show-initials] is
    /// `FALSE`.
    public func text(_ text: String?) -> Self {
        var newSelf = self
        newSelf.text = text
        
        return newSelf
    }

}
