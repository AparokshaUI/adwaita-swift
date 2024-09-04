//
//  ButtonContent.swift
//  Adwaita
//
//  Created by auto-generation on 15.08.24.
//

import CAdw
import LevenshteinTransformations

/// A helper widget for creating buttons.
/// 
/// <picture><source srcset="button-content-dark.png" media="(prefers-color-scheme: dark)"><img src="button-content.png" alt="button-content"></picture>
/// 
/// `AdwButtonContent` is a box-like widget with an icon and a label.
/// 
/// It's intended to be used as a direct child of [class@Gtk.Button],
/// [class@Gtk.MenuButton] or [class@SplitButton], when they need to have both an
/// icon and a label, as follows:
/// 
/// ```xml
/// <object class="GtkButton"><property name="child"><object class="AdwButtonContent"><property name="icon-name">document-open-symbolic</property><property name="label" translatable="yes">_Open</property><property name="use-underline">True</property></object></property></object>
/// ```
/// 
/// `AdwButtonContent` handles style classes and connecting the mnemonic to the
/// button automatically.
/// 
/// ## CSS nodes
/// 
/// ```
/// buttoncontent
/// ╰── box
/// ├── image
/// ╰── label
/// ```
/// 
/// `AdwButtonContent`'s CSS node is called `buttoncontent`. It contains a `box`
/// subnode that serves as a container for the  `image` and `label` nodes.
/// 
/// When inside a `GtkButton` or `AdwSplitButton`, the button will receive the
/// `.image-text-button` style class. When inside a `GtkMenuButton`, the
/// internal `GtkButton` will receive it instead.
/// 
/// ## Accessibility
/// 
/// `AdwButtonContent` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
public struct ButtonContent: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, WidgetData, Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, WidgetData) -> Void] = []

    /// Whether the button can be smaller than the natural size of its contents.
    /// 
    /// If set to `TRUE`, the label will ellipsize.
    /// 
    /// See [property@Gtk.Button:can-shrink].
    var canShrink: Bool?
    /// The name of the displayed icon.
    /// 
    /// If empty, the icon is not shown.
    var iconName: String?
    /// The displayed label.
    var label: String?
    /// Whether an underline in the text indicates a mnemonic.
    /// 
    /// The mnemonic can be used to activate the parent button.
    /// 
    /// See [property@ButtonContent:label].
    var useUnderline: Bool?

    /// Initialize `ButtonContent`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The view render data type.
    /// - Returns: The view storage.
    public func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_button_content_new()?.opaque())
        for function in appearFunctions {
            function(storage, data)
        }
        update(storage, data: data, updateProperties: true, type: type)

        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The view render data type.
    public func update<Data>(_ storage: ViewStorage, data: WidgetData, updateProperties: Bool, type: Data.Type) where Data: ViewRenderData {
        storage.modify { widget in

            if let canShrink, updateProperties, (storage.previousState as? Self)?.canShrink != canShrink {
                adw_button_content_set_can_shrink(widget, canShrink.cBool)
            }
            if let iconName, updateProperties, (storage.previousState as? Self)?.iconName != iconName {
                adw_button_content_set_icon_name(widget, iconName)
            }
            if let label, updateProperties, (storage.previousState as? Self)?.label != label {
                adw_button_content_set_label(widget, label)
            }
            if let useUnderline, updateProperties, (storage.previousState as? Self)?.useUnderline != useUnderline {
                adw_button_content_set_use_underline(widget, useUnderline.cBool)
            }


        }
        for function in updateFunctions {
            function(storage, data, updateProperties)
        }
        if updateProperties {
            storage.previousState = self
        }
    }

    /// Whether the button can be smaller than the natural size of its contents.
    /// 
    /// If set to `TRUE`, the label will ellipsize.
    /// 
    /// See [property@Gtk.Button:can-shrink].
    public func canShrink(_ canShrink: Bool? = true) -> Self {
        var newSelf = self
        newSelf.canShrink = canShrink
        
        return newSelf
    }

    /// The name of the displayed icon.
    /// 
    /// If empty, the icon is not shown.
    public func iconName(_ iconName: String?) -> Self {
        var newSelf = self
        newSelf.iconName = iconName
        
        return newSelf
    }

    /// The displayed label.
    public func label(_ label: String?) -> Self {
        var newSelf = self
        newSelf.label = label
        
        return newSelf
    }

    /// Whether an underline in the text indicates a mnemonic.
    /// 
    /// The mnemonic can be used to activate the parent button.
    /// 
    /// See [property@ButtonContent:label].
    public func useUnderline(_ useUnderline: Bool? = true) -> Self {
        var newSelf = self
        newSelf.useUnderline = useUnderline
        
        return newSelf
    }

}
