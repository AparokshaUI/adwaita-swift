//
//  FlowBox.swift
//  Adwaita
//
//  Created by auto-generation on 19.07.24.
//

import CAdw
import LevenshteinTransformations

/// A `GtkFlowBox` puts child widgets in reflowing grid.
/// 
/// For instance, with the horizontal orientation, the widgets will be
/// arranged from left to right, starting a new row under the previous
/// row when necessary. Reducing the width in this case will require more
/// rows, so a larger height will be requested.
/// 
/// Likewise, with the vertical orientation, the widgets will be arranged
/// from top to bottom, starting a new column to the right when necessary.
/// Reducing the height will require more columns, so a larger width will
/// be requested.
/// 
/// The size request of a `GtkFlowBox` alone may not be what you expect;
/// if you need to be able to shrink it along both axes and dynamically
/// reflow its children, you may have to wrap it in a `GtkScrolledWindow`
/// to enable that.
/// 
/// The children of a `GtkFlowBox` can be dynamically sorted and filtered.
/// 
/// Although a `GtkFlowBox` must have only `GtkFlowBoxChild` children, you
/// can add any kind of widget to it via [method@Gtk.FlowBox.insert], and a
/// `GtkFlowBoxChild` widget will automatically be inserted between the box
/// and the widget.
/// 
/// Also see [class@Gtk.ListBox].
/// 
/// # CSS nodes
/// 
/// ```
/// flowbox
/// ├── flowboxchild
/// │   ╰── <child>├── flowboxchild
/// │   ╰── <child>┊
/// ╰── [rubberband]
/// ```
/// 
/// `GtkFlowBox` uses a single CSS node with name flowbox. `GtkFlowBoxChild`
/// uses a single CSS node with name flowboxchild. For rubberband selection,
/// a subnode with name rubberband is used.
/// 
/// # Accessibility
/// 
/// `GtkFlowBox` uses the %GTK_ACCESSIBLE_ROLE_GRID role, and `GtkFlowBoxChild`
/// uses the %GTK_ACCESSIBLE_ROLE_GRID_CELL role.
public struct FlowBox<Element>: Widget where Element: Identifiable {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(View) -> View], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(View) -> View]) -> Void] = []

/// accept-unpaired-release
    var acceptUnpairedRelease: Bool?
    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    var accessibleRole: String?
    /// Determines whether children can be activated with a single
    /// click, or require a double-click.
    var activateOnSingleClick: Bool?
    /// The amount of horizontal space between two children.
    var columnSpacing: UInt?
    /// Determines whether all children should be allocated the
    /// same size.
    var homogeneous: Bool?
    /// The maximum amount of children to request space for consecutively
    /// in the given orientation.
    var maxChildrenPerLine: UInt?
    /// The minimum number of children to allocate consecutively
    /// in the given orientation.
    /// 
    /// Setting the minimum children per line ensures
    /// that a reasonably small height will be requested
    /// for the overall minimum width of the box.
    var minChildrenPerLine: UInt?
    /// The amount of vertical space between two children.
    var rowSpacing: UInt?
    /// Emitted when the user activates the @box.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    var activateCursorChild: (() -> Void)?
    /// Emitted when a child has been activated by the user.
    var childActivated: (() -> Void)?
    /// Emitted when the user initiates a cursor movement.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    /// Applications should not connect to it, but may emit it with
    /// g_signal_emit_by_name() if they need to control the cursor
    /// programmatically.
    /// 
    /// The default bindings for this signal come in two variants,
    /// the variant with the Shift modifier extends the selection,
    /// the variant without the Shift modifier does not.
    /// There are too many key combinations to list them all here.
    /// 
    /// - <kbd>←</kbd>, <kbd>→</kbd>, <kbd>↑</kbd>, <kbd>↓</kbd>
    /// move by individual children
    /// - <kbd>Home</kbd>, <kbd>End</kbd> move to the ends of the box
    /// - <kbd>PgUp</kbd>, <kbd>PgDn</kbd> move vertically by pages
    var moveCursor: (() -> Void)?
    /// Emitted to select all children of the box,
    /// if the selection mode permits it.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    /// 
    /// The default bindings for this signal is <kbd>Ctrl</kbd>-<kbd>a</kbd>.
    var selectAll: (() -> Void)?
    /// Emitted when the set of selected children changes.
    /// 
    /// Use [method@Gtk.FlowBox.selected_foreach] or
    /// [method@Gtk.FlowBox.get_selected_children] to obtain the
    /// selected children.
    var selectedChildrenChanged: (() -> Void)?
    /// Emitted to toggle the selection of the child that has the focus.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    /// 
    /// The default binding for this signal is <kbd>Ctrl</kbd>-<kbd>Space</kbd>.
    var toggleCursorChild: (() -> Void)?
    /// Emitted to unselect all children of the box,
    /// if the selection mode permits it.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    /// 
    /// The default bindings for this signal is <kbd>Ctrl</kbd>-<kbd>Shift</kbd>-<kbd>a</kbd>.
    var unselectAll: (() -> Void)?
    /// The dynamic widget elements.
    var elements: [Element]
    /// The dynamic widget content.
    var content: (Element) -> Body
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `FlowBox`.
    public init(_ elements: [Element], @ViewBuilder content: @escaping (Element) -> Body) {
        self.elements = elements
        self.content = content
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(gtk_flow_box_new()?.opaque())
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
        if let activateCursorChild {
            storage.connectSignal(name: "activate-cursor-child", argCount: 0) {
                activateCursorChild()
            }
        }
        if let childActivated {
            storage.connectSignal(name: "child-activated", argCount: 1) {
                childActivated()
            }
        }
        if let moveCursor {
            storage.connectSignal(name: "move-cursor", argCount: 4) {
                moveCursor()
            }
        }
        if let selectAll {
            storage.connectSignal(name: "select-all", argCount: 0) {
                selectAll()
            }
        }
        if let selectedChildrenChanged {
            storage.connectSignal(name: "selected-children-changed", argCount: 0) {
                selectedChildrenChanged()
            }
        }
        if let toggleCursorChild {
            storage.connectSignal(name: "toggle-cursor-child", argCount: 0) {
                toggleCursorChild()
            }
        }
        if let unselectAll {
            storage.connectSignal(name: "unselect-all", argCount: 0) {
                unselectAll()
            }
        }
        storage.modify { widget in

            if let activateOnSingleClick, updateProperties {
                gtk_flow_box_set_activate_on_single_click(widget, activateOnSingleClick.cBool)
            }
            if let columnSpacing, updateProperties {
                gtk_flow_box_set_column_spacing(widget, columnSpacing.cInt)
            }
            if let homogeneous, updateProperties {
                gtk_flow_box_set_homogeneous(widget, homogeneous.cBool)
            }
            if let maxChildrenPerLine, updateProperties {
                gtk_flow_box_set_max_children_per_line(widget, maxChildrenPerLine.cInt)
            }
            if let minChildrenPerLine, updateProperties {
                gtk_flow_box_set_min_children_per_line(widget, minChildrenPerLine.cInt)
            }
            if let rowSpacing, updateProperties {
                gtk_flow_box_set_row_spacing(widget, rowSpacing.cInt)
            }

            var contentStorage: [ViewStorage] = storage.content[.mainContent] ?? []
            let old = storage.fields["element"] as? [Element] ?? []
            old.identifiableTransform(
                to: elements,
                functions: .init { index, element in
                    let child = content(element).widget(modifiers: modifiers).container(modifiers: modifiers)
                    gtk_flow_box_remove(widget, gtk_flow_box_get_child_at_index(widget, index.cInt)?.cast())
                    gtk_flow_box_insert(widget, child.pointer?.cast(), index.cInt)
                    contentStorage.remove(at: index)
                    contentStorage.insert(child, at: index)
                } delete: { index in
                    gtk_flow_box_remove(widget, gtk_flow_box_get_child_at_index(widget, index.cInt)?.cast())
                    contentStorage.remove(at: index)
                } insert: { index, element in
                    let child = content(element).widget(modifiers: modifiers).container(modifiers: modifiers)
                    gtk_flow_box_insert(widget, child.pointer?.cast(), index.cInt)
                    contentStorage.insert(child, at: index)
                }
            )
            storage.fields["element"] = elements
            storage.content[.mainContent] = contentStorage
            for (index, element) in elements.enumerated() {
                content(element).widget(modifiers: modifiers).update(contentStorage[index], modifiers: modifiers, updateProperties: updateProperties)
            }
        }
        for function in updateFunctions {
            function(storage, modifiers, updateProperties)
        }
    }

/// accept-unpaired-release
    public func acceptUnpairedRelease(_ acceptUnpairedRelease: Bool? = true) -> Self {
        var newSelf = self
        newSelf.acceptUnpairedRelease = acceptUnpairedRelease
        
        return newSelf
    }

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    public func accessibleRole(_ accessibleRole: String?) -> Self {
        var newSelf = self
        newSelf.accessibleRole = accessibleRole
        
        return newSelf
    }

    /// Determines whether children can be activated with a single
    /// click, or require a double-click.
    public func activateOnSingleClick(_ activateOnSingleClick: Bool? = true) -> Self {
        var newSelf = self
        newSelf.activateOnSingleClick = activateOnSingleClick
        
        return newSelf
    }

    /// The amount of horizontal space between two children.
    public func columnSpacing(_ columnSpacing: UInt?) -> Self {
        var newSelf = self
        newSelf.columnSpacing = columnSpacing
        
        return newSelf
    }

    /// Determines whether all children should be allocated the
    /// same size.
    public func homogeneous(_ homogeneous: Bool? = true) -> Self {
        var newSelf = self
        newSelf.homogeneous = homogeneous
        
        return newSelf
    }

    /// The maximum amount of children to request space for consecutively
    /// in the given orientation.
    public func maxChildrenPerLine(_ maxChildrenPerLine: UInt?) -> Self {
        var newSelf = self
        newSelf.maxChildrenPerLine = maxChildrenPerLine
        
        return newSelf
    }

    /// The minimum number of children to allocate consecutively
    /// in the given orientation.
    /// 
    /// Setting the minimum children per line ensures
    /// that a reasonably small height will be requested
    /// for the overall minimum width of the box.
    public func minChildrenPerLine(_ minChildrenPerLine: UInt?) -> Self {
        var newSelf = self
        newSelf.minChildrenPerLine = minChildrenPerLine
        
        return newSelf
    }

    /// The amount of vertical space between two children.
    public func rowSpacing(_ rowSpacing: UInt?) -> Self {
        var newSelf = self
        newSelf.rowSpacing = rowSpacing
        
        return newSelf
    }

    /// Emitted when the user activates the @box.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    public func activateCursorChild(_ activateCursorChild: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.activateCursorChild = activateCursorChild
        return newSelf
    }

    /// Emitted when a child has been activated by the user.
    public func childActivated(_ childActivated: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.childActivated = childActivated
        return newSelf
    }

    /// Emitted when the user initiates a cursor movement.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    /// Applications should not connect to it, but may emit it with
    /// g_signal_emit_by_name() if they need to control the cursor
    /// programmatically.
    /// 
    /// The default bindings for this signal come in two variants,
    /// the variant with the Shift modifier extends the selection,
    /// the variant without the Shift modifier does not.
    /// There are too many key combinations to list them all here.
    /// 
    /// - <kbd>←</kbd>, <kbd>→</kbd>, <kbd>↑</kbd>, <kbd>↓</kbd>
    /// move by individual children
    /// - <kbd>Home</kbd>, <kbd>End</kbd> move to the ends of the box
    /// - <kbd>PgUp</kbd>, <kbd>PgDn</kbd> move vertically by pages
    public func moveCursor(_ moveCursor: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.moveCursor = moveCursor
        return newSelf
    }

    /// Emitted to select all children of the box,
    /// if the selection mode permits it.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    /// 
    /// The default bindings for this signal is <kbd>Ctrl</kbd>-<kbd>a</kbd>.
    public func selectAll(_ selectAll: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.selectAll = selectAll
        return newSelf
    }

    /// Emitted when the set of selected children changes.
    /// 
    /// Use [method@Gtk.FlowBox.selected_foreach] or
    /// [method@Gtk.FlowBox.get_selected_children] to obtain the
    /// selected children.
    public func selectedChildrenChanged(_ selectedChildrenChanged: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.selectedChildrenChanged = selectedChildrenChanged
        return newSelf
    }

    /// Emitted to toggle the selection of the child that has the focus.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    /// 
    /// The default binding for this signal is <kbd>Ctrl</kbd>-<kbd>Space</kbd>.
    public func toggleCursorChild(_ toggleCursorChild: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.toggleCursorChild = toggleCursorChild
        return newSelf
    }

    /// Emitted to unselect all children of the box,
    /// if the selection mode permits it.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    /// 
    /// The default bindings for this signal is <kbd>Ctrl</kbd>-<kbd>Shift</kbd>-<kbd>a</kbd>.
    public func unselectAll(_ unselectAll: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.unselectAll = unselectAll
        return newSelf
    }

}
