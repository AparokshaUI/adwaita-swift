//
//  LevelBar.swift
//  Adwaita
//
//  Created by auto-generation on 22.01.24.
//

import CAdw
import LevenshteinTransformations

/// `GtkLevelBar` is a widget that can be used as a level indicator.
/// 
/// Typical use cases are displaying the strength of a password, or
/// showing the charge level of a battery.
/// 
/// ![An example GtkLevelBar](levelbar.png)
/// 
/// Use [method@Gtk.LevelBar.set_value] to set the current value, and
/// [method@Gtk.LevelBar.add_offset_value] to set the value offsets at which
/// the bar will be considered in a different state. GTK will add a few
/// offsets by default on the level bar: %GTK_LEVEL_BAR_OFFSET_LOW,
/// %GTK_LEVEL_BAR_OFFSET_HIGH and %GTK_LEVEL_BAR_OFFSET_FULL, with
/// values 0.25, 0.75 and 1.0 respectively.
/// 
/// Note that it is your responsibility to update preexisting offsets
/// when changing the minimum or maximum value. GTK will simply clamp
/// them to the new range.
/// 
/// ## Adding a custom offset on the bar
/// 
/// ```c
/// static GtkWidget *
/// create_level_bar (void)
/// {
/// GtkWidget *widget;
/// GtkLevelBar *bar;
/// 
/// widget = gtk_level_bar_new ();
/// bar = GTK_LEVEL_BAR (widget);
/// 
/// // This changes the value of the default low offset
/// 
/// gtk_level_bar_add_offset_value (bar,
/// GTK_LEVEL_BAR_OFFSET_LOW,
/// 0.10);
/// 
/// // This adds a new offset to the bar; the application will
/// // be able to change its color CSS like this:
/// //
/// // levelbar block.my-offset {
/// //   background-color: magenta;
/// //   border-style: solid;
/// //   border-color: black;
/// //   border-width: 1px;
/// // }
/// 
/// gtk_level_bar_add_offset_value (bar, "my-offset", 0.60);
/// 
/// return widget;
/// }
/// ```
/// 
/// The default interval of values is between zero and one, but it’s possible
/// to modify the interval using [method@Gtk.LevelBar.set_min_value] and
/// [method@Gtk.LevelBar.set_max_value]. The value will be always drawn in
/// proportion to the admissible interval, i.e. a value of 15 with a specified
/// interval between 10 and 20 is equivalent to a value of 0.5 with an interval
/// between 0 and 1. When %GTK_LEVEL_BAR_MODE_DISCRETE is used, the bar level
/// is rendered as a finite number of separated blocks instead of a single one.
/// The number of blocks that will be rendered is equal to the number of units
/// specified by the admissible interval.
/// 
/// For instance, to build a bar rendered with five blocks, it’s sufficient to
/// set the minimum value to 0 and the maximum value to 5 after changing the
/// indicator mode to discrete.
/// 
/// # GtkLevelBar as GtkBuildable
/// 
/// The `GtkLevelBar` implementation of the `GtkBuildable` interface supports a
/// custom `<offsets>` element, which can contain any number of `<offset>` elements,
/// each of which must have "name" and "value" attributes.
/// 
/// # CSS nodes
/// 
/// ```
/// levelbar[.discrete]
/// ╰── trough
/// ├── block.filled.level-name
/// ┊
/// ├── block.empty
/// ┊
/// ```
/// 
/// `GtkLevelBar` has a main CSS node with name levelbar and one of the style
/// classes .discrete or .continuous and a subnode with name trough. Below the
/// trough node are a number of nodes with name block and style class .filled
/// or .empty. In continuous mode, there is exactly one node of each, in discrete
/// mode, the number of filled and unfilled nodes corresponds to blocks that are
/// drawn. The block.filled nodes also get a style class .level-name corresponding
/// to the level for the current value.
/// 
/// In horizontal orientation, the nodes are always arranged from left to right,
/// regardless of text direction.
/// 
/// # Accessibility
/// 
/// `GtkLevelBar` uses the %GTK_ACCESSIBLE_ROLE_METER role.
public struct LevelBar: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage) -> Void] = []

    /// Whether the `GtkLeveBar` is inverted.
    /// 
    /// Level bars normally grow from top to bottom or left to right.
    /// Inverted level bars grow in the opposite direction.
    var inverted: Bool?
    /// Determines the maximum value of the interval that can be displayed by the bar.
    var maxValue: Double?
    /// Determines the minimum value of the interval that can be displayed by the bar.
    var minValue: Double?
    /// Determines the currently filled value of the level bar.
    var value: Double?
    /// Emitted when an offset specified on the bar changes value.
    /// 
    /// This typically is the result of a [method@Gtk.LevelBar.add_offset_value]
    /// call.
    /// 
    /// The signal supports detailed connections; you can connect to the
    /// detailed signal "changed::x" in order to only receive callbacks when
    /// the value of offset "x" changes.
    var offsetChanged: (() -> Void)?
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `LevelBar`.
    public init() {
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(gtk_level_bar_new()?.opaque())
        update(storage, modifiers: modifiers)


        for function in appearFunctions {
            function(storage)
        }
        return storage
    }

    /// Update the widget's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: The view modifiers.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let offsetChanged {
            storage.connectSignal(name: "offset-changed") {
                offsetChanged()
            }
        }
        storage.modify { widget in
            if let inverted {
                gtk_level_bar_set_inverted(widget, inverted.cBool)
            }
            if let maxValue {
                gtk_level_bar_set_max_value(widget, maxValue)
            }
            if let minValue {
                gtk_level_bar_set_min_value(widget, minValue)
            }
            if let value {
                gtk_level_bar_set_value(widget, value)
            }


        }
        for function in updateFunctions {
            function(storage)
        }
    }

    /// Whether the `GtkLeveBar` is inverted.
    /// 
    /// Level bars normally grow from top to bottom or left to right.
    /// Inverted level bars grow in the opposite direction.
    public func inverted(_ inverted: Bool? = true) -> Self {
        var newSelf = self
        newSelf.inverted = inverted
        
        return newSelf
    }

    /// Determines the maximum value of the interval that can be displayed by the bar.
    public func maxValue(_ maxValue: Double?) -> Self {
        var newSelf = self
        newSelf.maxValue = maxValue
        
        return newSelf
    }

    /// Determines the minimum value of the interval that can be displayed by the bar.
    public func minValue(_ minValue: Double?) -> Self {
        var newSelf = self
        newSelf.minValue = minValue
        
        return newSelf
    }

    /// Determines the currently filled value of the level bar.
    public func value(_ value: Double?) -> Self {
        var newSelf = self
        newSelf.value = value
        
        return newSelf
    }

    /// Emitted when an offset specified on the bar changes value.
    /// 
    /// This typically is the result of a [method@Gtk.LevelBar.add_offset_value]
    /// call.
    /// 
    /// The signal supports detailed connections; you can connect to the
    /// detailed signal "changed::x" in order to only receive callbacks when
    /// the value of offset "x" changes.
    public func offsetChanged(_ offsetChanged: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.offsetChanged = offsetChanged
        return newSelf
    }

}
