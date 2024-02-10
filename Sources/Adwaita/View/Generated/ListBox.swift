//
//  ListBox.swift
//  Adwaita
//
//  Created by auto-generation on 10.02.24.
//

import CAdw
import LevenshteinTransformations

/// `GtkListBox` is a vertical list.
/// 
/// A `GtkListBox` only contains `GtkListBoxRow` children. These rows can
/// by dynamically sorted and filtered, and headers can be added dynamically
/// depending on the row content. It also allows keyboard and mouse navigation
/// and selection like a typical list.
/// 
/// Using `GtkListBox` is often an alternative to `GtkTreeView`, especially
/// when the list contents has a more complicated layout than what is allowed
/// by a `GtkCellRenderer`, or when the contents is interactive (i.e. has a
/// button in it).
/// 
/// Although a `GtkListBox` must have only `GtkListBoxRow` children, you can
/// add any kind of widget to it via [method@Gtk.ListBox.prepend],
/// [method@Gtk.ListBox.append] and [method@Gtk.ListBox.insert] and a
/// `GtkListBoxRow` widget will automatically be inserted between the list
/// and the widget.
/// 
/// `GtkListBoxRows` can be marked as activatable or selectable. If a row is
/// activatable, [signal@Gtk.ListBox::row-activated] will be emitted for it when
/// the user tries to activate it. If it is selectable, the row will be marked
/// as selected when the user tries to select it.
/// 
/// # GtkListBox as GtkBuildable
/// 
/// The `GtkListBox` implementation of the `GtkBuildable` interface supports
/// setting a child as the placeholder by specifying “placeholder” as the “type”
/// attribute of a `<child>` element. See [method@Gtk.ListBox.set_placeholder]
/// for info.
/// 
/// # CSS nodes
/// 
/// |[<!-- language="plain" -->
/// list[.separators][.rich-list][.navigation-sidebar][.boxed-list]
/// ╰── row[.activatable]
/// ]|
/// 
/// `GtkListBox` uses a single CSS node named list. It may carry the .separators
/// style class, when the [property@Gtk.ListBox:show-separators] property is set.
/// Each `GtkListBoxRow` uses a single CSS node named row. The row nodes get the
/// .activatable style class added when appropriate.
/// 
/// It may also carry the .boxed-list style class. In this case, the list will be
/// automatically surrounded by a frame and have separators.
/// 
/// The main list node may also carry style classes to select
/// the style of [list presentation](section-list-widget.html#list-styles):
/// .rich-list, .navigation-sidebar or .data-table.
/// 
/// # Accessibility
/// 
/// `GtkListBox` uses the %GTK_ACCESSIBLE_ROLE_LIST role and `GtkListBoxRow` uses
/// the %GTK_ACCESSIBLE_ROLE_LIST_ITEM role.
public struct ListBox<Element>: Widget where Element: Identifiable {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage) -> Void] = []

    /// Whether to accept unpaired release events.
    var acceptUnpairedRelease: Bool?
    /// Determines whether children can be activated with a single
    /// click, or require a double-click.
    var activateOnSingleClick: Bool?
    /// Whether to show separators between rows.
    var showSeparators: Bool?
    /// activateCursorRow
    var activateCursorRow: (() -> Void)?
    /// moveCursor
    var moveCursor: (() -> Void)?
    /// Emitted when a row has been activated by the user.
    var rowActivated: (() -> Void)?
    /// Emitted when a new row is selected, or (with a %NULL @row)
    /// when the selection is cleared.
    /// 
    /// When the @box is using %GTK_SELECTION_MULTIPLE, this signal will not
    /// give you the full picture of selection changes, and you should use
    /// the [signal@Gtk.ListBox::selected-rows-changed] signal instead.
    var rowSelected: (() -> Void)?
    /// Emitted to select all children of the box, if the selection
    /// mode permits it.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    /// 
    /// The default binding for this signal is <kbd>Ctrl</kbd>-<kbd>a</kbd>.
    var selectAll: (() -> Void)?
    /// Emitted when the set of selected rows changes.
    var selectedRowsChanged: (() -> Void)?
    /// toggleCursorRow
    var toggleCursorRow: (() -> Void)?
    /// Emitted to unselect all children of the box, if the selection
    /// mode permits it.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    /// 
    /// The default binding for this signal is
    /// <kbd>Ctrl</kbd>-<kbd>Shift</kbd>-<kbd>a</kbd>.
    var unselectAll: (() -> Void)?
    /// The dynamic widget elements.
    var elements: [Element]
    /// The dynamic widget content.
    var content: (Element) -> Body
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `ListBox`.
    public init(_ elements: [Element], @ViewBuilder content: @escaping (Element) -> Body) {
        self.elements = elements
        self.content = content
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(gtk_list_box_new()?.opaque())
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
        if let activateCursorRow {
            storage.connectSignal(name: "activate-cursor-row", argCount: 0) {
                activateCursorRow()
            }
        }
        if let moveCursor {
            storage.connectSignal(name: "move-cursor", argCount: 4) {
                moveCursor()
            }
        }
        if let rowActivated {
            storage.connectSignal(name: "row-activated", argCount: 1) {
                rowActivated()
            }
        }
        if let rowSelected {
            storage.connectSignal(name: "row-selected", argCount: 1) {
                rowSelected()
            }
        }
        if let selectAll {
            storage.connectSignal(name: "select-all", argCount: 0) {
                selectAll()
            }
        }
        if let selectedRowsChanged {
            storage.connectSignal(name: "selected-rows-changed", argCount: 0) {
                selectedRowsChanged()
            }
        }
        if let toggleCursorRow {
            storage.connectSignal(name: "toggle-cursor-row", argCount: 0) {
                toggleCursorRow()
            }
        }
        if let unselectAll {
            storage.connectSignal(name: "unselect-all", argCount: 0) {
                unselectAll()
            }
        }
        storage.modify { widget in
            if let activateOnSingleClick, updateProperties {
                gtk_list_box_set_activate_on_single_click(widget, activateOnSingleClick.cBool)
            }
            if let showSeparators, updateProperties {
                gtk_list_box_set_show_separators(widget, showSeparators.cBool)
            }

            var contentStorage: [ViewStorage] = storage.content[.mainContent] ?? []
            let old = storage.fields["element"] as? [Element] ?? []
            old.identifiableTransform(
                to: elements,
                functions: .init { index, element in
                    let child = content(element).widget(modifiers: modifiers).container(modifiers: modifiers)
                    gtk_list_box_remove(widget, gtk_list_box_get_row_at_index(widget, index.cInt)?.cast())
                    gtk_list_box_insert(widget, child.pointer?.cast(), index.cInt)
                    contentStorage.remove(at: index)
                    contentStorage.insert(child, at: index)
                } delete: { index in
                    gtk_list_box_remove(widget, gtk_list_box_get_row_at_index(widget, index.cInt)?.cast())
                    contentStorage.remove(at: index)
                } insert: { index, element in
                    let child = content(element).widget(modifiers: modifiers).container(modifiers: modifiers)
                    gtk_list_box_insert(widget, child.pointer?.cast(), index.cInt)
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
            function(storage)
        }
    }

    /// Whether to accept unpaired release events.
    public func acceptUnpairedRelease(_ acceptUnpairedRelease: Bool? = true) -> Self {
        var newSelf = self
        newSelf.acceptUnpairedRelease = acceptUnpairedRelease
        
        return newSelf
    }

    /// Determines whether children can be activated with a single
    /// click, or require a double-click.
    public func activateOnSingleClick(_ activateOnSingleClick: Bool? = true) -> Self {
        var newSelf = self
        newSelf.activateOnSingleClick = activateOnSingleClick
        
        return newSelf
    }

    /// Whether to show separators between rows.
    public func showSeparators(_ showSeparators: Bool? = true) -> Self {
        var newSelf = self
        newSelf.showSeparators = showSeparators
        
        return newSelf
    }

    /// activateCursorRow
    public func activateCursorRow(_ activateCursorRow: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.activateCursorRow = activateCursorRow
        return newSelf
    }

    /// moveCursor
    public func moveCursor(_ moveCursor: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.moveCursor = moveCursor
        return newSelf
    }

    /// Emitted when a row has been activated by the user.
    public func rowActivated(_ rowActivated: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.rowActivated = rowActivated
        return newSelf
    }

    /// Emitted when a new row is selected, or (with a %NULL @row)
    /// when the selection is cleared.
    /// 
    /// When the @box is using %GTK_SELECTION_MULTIPLE, this signal will not
    /// give you the full picture of selection changes, and you should use
    /// the [signal@Gtk.ListBox::selected-rows-changed] signal instead.
    public func rowSelected(_ rowSelected: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.rowSelected = rowSelected
        return newSelf
    }

    /// Emitted to select all children of the box, if the selection
    /// mode permits it.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    /// 
    /// The default binding for this signal is <kbd>Ctrl</kbd>-<kbd>a</kbd>.
    public func selectAll(_ selectAll: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.selectAll = selectAll
        return newSelf
    }

    /// Emitted when the set of selected rows changes.
    public func selectedRowsChanged(_ selectedRowsChanged: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.selectedRowsChanged = selectedRowsChanged
        return newSelf
    }

    /// toggleCursorRow
    public func toggleCursorRow(_ toggleCursorRow: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.toggleCursorRow = toggleCursorRow
        return newSelf
    }

    /// Emitted to unselect all children of the box, if the selection
    /// mode permits it.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    /// 
    /// The default binding for this signal is
    /// <kbd>Ctrl</kbd>-<kbd>Shift</kbd>-<kbd>a</kbd>.
    public func unselectAll(_ unselectAll: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.unselectAll = unselectAll
        return newSelf
    }

}
