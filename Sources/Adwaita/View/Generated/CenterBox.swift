//
//  CenterBox.swift
//  Adwaita
//
//  Created by auto-generation on 21.04.24.
//

import CAdw
import LevenshteinTransformations

/// `GtkCenterBox` arranges three children in a row, keeping the middle child
/// centered as well as possible.
/// 
/// ![An example GtkCenterBox](centerbox.png)
/// 
/// To add children to `GtkCenterBox`, use [method@Gtk.CenterBox.set_start_widget],
/// [method@Gtk.CenterBox.set_center_widget] and
/// [method@Gtk.CenterBox.set_end_widget].
/// 
/// The sizing and positioning of children can be influenced with the
/// align and expand properties of the children.
/// 
/// # GtkCenterBox as GtkBuildable
/// 
/// The `GtkCenterBox` implementation of the `GtkBuildable` interface
/// supports placing children in the 3 positions by specifying “start”, “center”
/// or “end” as the “type” attribute of a `<child>` element.
/// 
/// # CSS nodes
/// 
/// `GtkCenterBox` uses a single CSS node with the name “box”,
/// 
/// The first child of the `GtkCenterBox` will be allocated depending on the
/// text direction, i.e. in left-to-right layouts it will be allocated on the
/// left and in right-to-left layouts on the right.
/// 
/// In vertical orientation, the nodes of the children are arranged from top to
/// bottom.
/// 
/// # Accessibility
/// 
/// Until GTK 4.10, `GtkCenterBox` used the `GTK_ACCESSIBLE_ROLE_GROUP` role.
/// 
/// Starting from GTK 4.12, `GtkCenterBox` uses the `GTK_ACCESSIBLE_ROLE_GENERIC` role.
public struct CenterBox: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(View) -> View], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(View) -> View]) -> Void] = []

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    var accessibleRole: String?
    /// The widget that is placed at the center position.
    var centerWidget:  (() -> Body)?
    /// The widget that is placed at the end position.
    /// 
    /// In vertical orientation, the end position is at the bottom.
    /// In horizontal orientation, the end position is at the trailing
    /// edge wrt. to the text direction.
    var endWidget:  (() -> Body)?
    /// Whether to shrink the center widget after other children.
    /// 
    /// By default, when there's no space to give all three children their
    /// natural widths, the start and end widgets start shrinking and the
    /// center child keeps natural width until they reach minimum width.
    /// 
    /// If set to `FALSE`, start and end widgets keep natural width and the
    /// center widget starts shrinking instead.
    var shrinkCenterLast: Bool?
    /// The widget that is placed at the start position.
    /// 
    /// In vertical orientation, the start position is at the top.
    /// In horizontal orientation, the start position is at the leading
    /// edge wrt. to the text direction.
    var startWidget:  (() -> Body)?
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `CenterBox`.
    public init() {
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(gtk_center_box_new()?.opaque())
        update(storage, modifiers: modifiers, updateProperties: true)
        if let centerWidgetStorage = centerWidget?().widget(modifiers: modifiers).storage(modifiers: modifiers) {
            storage.content["centerWidget"] = [centerWidgetStorage]
            gtk_center_box_set_center_widget(storage.pointer, centerWidgetStorage.pointer?.cast())
        }
        if let endWidgetStorage = endWidget?().widget(modifiers: modifiers).storage(modifiers: modifiers) {
            storage.content["endWidget"] = [endWidgetStorage]
            gtk_center_box_set_end_widget(storage.pointer, endWidgetStorage.pointer?.cast())
        }
        if let startWidgetStorage = startWidget?().widget(modifiers: modifiers).storage(modifiers: modifiers) {
            storage.content["startWidget"] = [startWidgetStorage]
            gtk_center_box_set_start_widget(storage.pointer, startWidgetStorage.pointer?.cast())
        }

        for function in appearFunctions {
            function(storage, modifiers)
        }
        return storage
    }

    /// Update the widget's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: The view modifiers.
    ///     - updateProperties: Whether to update the view's properties.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
        storage.modify { widget in

            if let widget = storage.content["centerWidget"]?.first {
                centerWidget?().widget(modifiers: modifiers).update(widget, modifiers: modifiers, updateProperties: updateProperties)
            }
            if let widget = storage.content["endWidget"]?.first {
                endWidget?().widget(modifiers: modifiers).update(widget, modifiers: modifiers, updateProperties: updateProperties)
            }
            if let shrinkCenterLast, updateProperties {
                gtk_center_box_set_shrink_center_last(widget, shrinkCenterLast.cBool)
            }
            if let widget = storage.content["startWidget"]?.first {
                startWidget?().widget(modifiers: modifiers).update(widget, modifiers: modifiers, updateProperties: updateProperties)
            }


        }
        for function in updateFunctions {
            function(storage, modifiers, updateProperties)
        }
    }

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    public func accessibleRole(_ accessibleRole: String?) -> Self {
        var newSelf = self
        newSelf.accessibleRole = accessibleRole
        
        return newSelf
    }

    /// The widget that is placed at the center position.
    public func centerWidget(@ViewBuilder _ centerWidget: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.centerWidget = centerWidget
        
        return newSelf
    }

    /// The widget that is placed at the end position.
    /// 
    /// In vertical orientation, the end position is at the bottom.
    /// In horizontal orientation, the end position is at the trailing
    /// edge wrt. to the text direction.
    public func endWidget(@ViewBuilder _ endWidget: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.endWidget = endWidget
        
        return newSelf
    }

    /// Whether to shrink the center widget after other children.
    /// 
    /// By default, when there's no space to give all three children their
    /// natural widths, the start and end widgets start shrinking and the
    /// center child keeps natural width until they reach minimum width.
    /// 
    /// If set to `FALSE`, start and end widgets keep natural width and the
    /// center widget starts shrinking instead.
    public func shrinkCenterLast(_ shrinkCenterLast: Bool? = true) -> Self {
        var newSelf = self
        newSelf.shrinkCenterLast = shrinkCenterLast
        
        return newSelf
    }

    /// The widget that is placed at the start position.
    /// 
    /// In vertical orientation, the start position is at the top.
    /// In horizontal orientation, the start position is at the leading
    /// edge wrt. to the text direction.
    public func startWidget(@ViewBuilder _ startWidget: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.startWidget = startWidget
        
        return newSelf
    }

}
