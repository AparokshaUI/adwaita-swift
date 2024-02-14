//
//  GenerationConfiguration.swift
//  Adwaita
//
//  Created by david-swift on 14.01.24.
//

import Foundation

// swiftlint:disable type_body_length

/// The configuration for the generation.
struct GenerationConfiguration {

    /// The include directory.
    static let includeDir = "$(pkg-config --variable=includedir gtk4)"
    /// The directory containing the GIR files.
    static let girFilePath = "\(includeDir)/../share/gir-1.0/"

    /// Exclude properties of buttons.
    static var excludeButtons: [String] {
        ["action-target", "related-action"]
    }

    /// The Gtk GIR file.
    var gtkGirFilePath = girFilePath + "Gtk-4.0.gir"
    /// The Adw GIR file.
    var adwGirFilePath = girFilePath + "Adw-1.gir"

    /// The folder containing the generated Swift files.
    var folder = "Sources/Adwaita/View/Generated/"

    /// The Libadwaita widgets.
    var adwWidgets: [WidgetConfiguration] = [
        .init(class: "StatusPage", excludeProperties: ["paintable"]),
        .init(class: "Banner", initializer: "adw_banner_new(title)", requiredProperties: ["title"]),
        .init(
            class: "Avatar",
            initializer: "adw_avatar_new(size.cInt, text, showInitials.cBool)",
            requiredProperties: ["size", "show-initials"],
            excludeProperties: ["custom-image"]
        ),
        .init(
            class: "WindowTitle",
            initializer: "adw_window_title_new(title, subtitle)",
            requiredProperties: ["title", "subtitle"]
        ),
        .init(class: "Bin", cast: true),
        .init(class: "ButtonContent"),
        .init(
            class: "Carousel",
            dynamicWidget: .init(
                insert: "adw_carousel_insert",
                remove: "adw_carousel_remove",
                getElement: "adw_carousel_get_nth_page(widget, UInt(index).cInt)"
            ),
            excludeProperties: ["position", "scroll-params"]
        ),
        .init(class: "Clamp", excludeProperties: ["unit"]),
        .init(class: "PreferencesRow", cast: true),
        .init(
            class: "ActionRow",
            staticWidgets: [
                .init(name: "suffix", add: "adw_action_row_add_suffix"),
                .init(name: "prefix", add: "adw_action_row_add_prefix")
            ],
            cast: true
        ),
        .init(class: "SwitchRow", bindings: [.init(property: "active")]),
        .init(
            class: "ComboRow",
            bindings: [.init(property: "selected")],
            excludeProperties: ["expression", "factory", "list-factory", "model", "selected-item"],
            cast: true
        ),
        .init(
            class: "ExpanderRow",
            bindings: [.init(property: "expanded"), .init(property: "enable-expansion")],
            staticWidgets: [
                .init(name: "rows", add: "adw_expander_row_add_row"),
                .init(name: "suffix", add: "adw_expander_row_add_suffix"),
                .init(name: "prefix", add: "adw_expander_row_add_prefix")
            ],
            cast: true
        ),
        .init(
            class: "EntryRow",
            staticWidgets: [
                .init(name: "suffix", add: "adw_entry_row_add_suffix"),
                .init(name: "prefix", add: "adw_entry_row_add_prefix")
            ],
            excludeProperties: ["attributes", "input-hints", "input-purpose"],
            cast: true
        ),
        .init(
            class: "PasswordEntryRow",
            excludeProperties: ["attributes", "input-hints", "input-purpose"],
            cast: true
        ),
        .init(
            class: "SpinRow",
            initializer: "adw_spin_row_new(nil, climbRate, digits.cInt)",
            bindings: [.init(property: "value")],
            requiredProperties: ["climb-rate", "digits"],
            excludeProperties: ["adjustment", "update-policy"]
        ),
        .init(
            class: "PreferencesGroup",
            staticWidgets: [.init(name: "child", add: "adw_preferences_group_add")],
            cast: true
        ),
        .init(
            class: "PreferencesPage",
            staticWidgets: [.init(name: "child", add: "adw_preferences_group_add")],
            cast: true
        ),
        .init(
            class: "OverlaySplitView",
            bindings: [.init(property: "show-sidebar")],
            excludeProperties: ["sidebar-position", "sidebar-width-unit"]
        ),
        .init(
            class: "HeaderBar",
            staticWidgets: [
                .init(name: "start", add: "adw_header_bar_pack_start"),
                .init(name: "end", add: "adw_header_bar_pack_end")
            ],
            excludeProperties: ["centering-policy"]
        ),
        .init(
            class: "ToolbarView",
            staticWidgets: [
                .init(name: "bottom", add: "adw_toolbar_view_add_bottom_bar"),
                .init(name: "top", add: "adw_toolbar_view_add_top_bar")
            ],
            excludeProperties: ["top-bar-style", "bottom-bar-style"]
        ),
        .init(class: "ToastOverlay"),
        .init(
            class: "SplitButton",
            excludeProperties: ["direction", "popover"],
            setConditions: ["label": "storage.content[\"child\"] == nil"]
        )
    ]

    /// The Gtk widgets.
    var gtkWidgets: [WidgetConfiguration] = [
        .init(
            class: "Label",
            initializer: "gtk_label_new(label)",
            requiredProperties: ["label"],
            excludeProperties: [
                "attributes",
                "ellipsize",
                "extra-menu",
                "justify",
                "natural-wrap-mode",
                "tabs",
                "wrap-mode"
            ],
            excludeSignals: ["activate-current-link", "activate-link", "move-cursor"]
        ),
        .init(
            class: "Box",
            initializer: "gtk_box_new(GTK_ORIENTATION_VERTICAL, spacing.cInt)",
            staticWidgets: [
                .init(name: "append", add: "gtk_box_append"),
                .init(name: "prepend", add: "gtk_box_prepend")
            ],
            requiredProperties: ["spacing"],
            excludeProperties: ["baseline-position", "orientation"],
            cast: true
        ),
        .init(class: "Spinner"),
        .init(class: "LevelBar", excludeProperties: ["mode", "orientation"]),
        .init(
            class: "ListBox",
            dynamicWidget: .init(
                insert: "gtk_list_box_insert",
                remove: "gtk_list_box_remove",
                getElement: "gtk_list_box_get_row_at_index(widget, index.cInt)?.cast()"
            ),
            excludeProperties: ["selection-mode"]
        ),
        .init(class: "ProgressBar", excludeProperties: ["ellipsize", "orientation"]),
        .init(
            class: "Button",
            excludeProperties: excludeButtons,
            cast: true,
            setConditions: ["label": "storage.content[\"child\"] == nil"]
        ),
        .init(
            class: "ToggleButton",
            bindings: [.init(property: "active")],
            excludeProperties: ["group"] + excludeButtons,
            cast: true,
            setConditions: ["label": "storage.content[\"child\"] == nil"]
        ),
        .init(
            class: "LinkButton",
            initializer: "gtk_link_button_new(uri)",
            requiredProperties: ["uri"],
            excludeProperties: excludeButtons,
            excludeSignals: ["activate-link"],
            setConditions: ["label": "storage.content[\"child\"] == nil"]
        ),
        .init(
            class: "CheckButton",
            bindings: [.init(property: "active")],
            excludeProperties: ["group"] + excludeButtons,
            cast: true,
            setConditions: ["label": "storage.content[\"child\"] == nil"]
        ),
        .init(
            class: "MenuButton",
            name: "Menu",
            bindings: [.init(property: "active")],
            excludeProperties: ["direction", "popover"] + excludeButtons,
            setConditions: ["label": "storage.content[\"child\"] == nil"]
        ),
        .init(
            class: "CenterBox",
            excludeProperties: ["baseline-position", "orientation"]
        ),
        .init(
            class: "ScrolledWindow",
            excludeProperties: [
                "hadjustment",
                "hscrollbar-policy",
                "vadjustment",
                "vscrollbar-policy",
                "window-placement"
            ]
        ),
        .init(class: "Overlay", staticWidgets: [.init(name: "overlay", add: "gtk_overlay_add_overlay")]),
        .init(class: "Popover", excludeProperties: ["pointing-to", "position"], cast: true),
        .init(
            class: "FlowBox",
            dynamicWidget: .init(
                insert: "gtk_flow_box_insert",
                remove: "gtk_flow_box_remove",
                getElement: "gtk_flow_box_get_child_at_index(widget, index.cInt)?.cast()"
            ),
            excludeProperties: ["selection-mode", "orientation"]
        ),
        .init(class: "SearchEntry", bindings: [.init(property: "text")]),
        .init(class: "SearchBar")
    ]

    /// The unshortening map.
    var unshorteningMap = [
        "char": "character",
        "str": "string"
    ]

    /// Replacements for C types.
    var cTypeReplacements = [
        "const char*": "String",
        "char*": "String",
        "gchar*": "String",
        "gboolean": "Bool",
        "gdouble": "Double",
        "guint": "UInt",
        "gint": "Int",
        "gfloat": "Float",
        "double": "Double",
        "GIcon*": "OpaquePointer",
        "GdkPixbuf*": "OpaquePointer",
        "GdkPaintable*": "OpaquePointer",
        "NavigationPage": "NavigationPage"
    ]

    /// Modifications for converting a Swift into a C type.
    var cTypeProperties = [
        "Bool": "cBool",
        "Int": "cInt",
        "UInt": "cInt"
    ]

    /// Default values for modifiers with a certain type.
    var defaultModifierValues = [
        "Bool?": "true"
    ]

    /// Modifications for converting a C into a Swift type.
    var getterTypeConversions: [String: (String) -> String] = [
        "gboolean": { "\($0) != 0" },
        "guint": { "UInt(\($0))" },
        "utf8": { "String(cString: \($0))" }
    ]

}

// swiftlint:enable type_body_length
