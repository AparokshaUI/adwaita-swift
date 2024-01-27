//
//  ViewSwitcher.swift
//  Adwaita
//
//  Created by david-swift on 03.01.24.
//

import CAdw

/// A picker used for indicating multiple views.
///
/// It normally controls a `ViewStack` (e.g. via `switch` statements).
public struct ViewSwitcher<Element>: Widget where Element: ViewSwitcherOption {

    /// The selected element.
    @Binding var selection: Element
    /// Whether the wide style is used, that means the icons and titles are on the same line.
    var wide = false

    /// Initialize a view switcher.
    /// - Parameter selection: The selected element.
    public init(selection: Binding<Element>) {
        self._selection = selection
    }

    /// Get a view switcher's view storage.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let switcher = ViewStorage(.init(adw_view_switcher_new()))
        let stack = ViewStorage(.init(adw_view_stack_new()))
        adw_view_switcher_set_stack(switcher.pointer, stack.pointer)
        for option in Element.allCases {
            adw_view_stack_add_titled_with_icon(
                stack.pointer,
                gtk_label_new(""),
                option.title,
                option.title,
                option.icon.string
            )
        }
        stack.notify(name: "visible-child") {
            if let title = adw_view_stack_get_visible_child_name(stack.pointer),
            let option = Element(title: .init(cString: title)) {
                selection = option
            }
        }
        updateSwitcher(switcher: switcher)
        switcher.fields["stack"] = stack
        return switcher
    }

    /// Update a view switcher's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    ///     - updateProperties: Whether to update properties.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
        updateSwitcher(switcher: storage)
    }

    /// Update a view switcher's style and selection.
    /// - Parameter switcher: The view switcher.
    func updateSwitcher(switcher: ViewStorage) {
        adw_view_switcher_set_policy(
            switcher.pointer,
            wide ? ADW_VIEW_SWITCHER_POLICY_WIDE : ADW_VIEW_SWITCHER_POLICY_NARROW
        )
        let stack = adw_view_switcher_get_stack(switcher.pointer)
        adw_view_stack_set_visible_child_name(stack, selection.title)
    }

    /// Set whether to use the wide design.
    /// - Parameter wide: Whether to use the wide design.
    /// - Returns: The view switcher.
    public func wideDesign(_ wide: Bool = true) -> Self {
        var newSelf = self
        newSelf.wide = wide
        return newSelf
    }

}

/// The protocol an element type for view switcher has to conform to.
public protocol ViewSwitcherOption: CaseIterable {

    /// The title displayed in the switcher and used for identification.
    var title: String { get }
    /// A symbolic representation in the view switcher.
    var icon: Icon { get }

    /// Get the element from the title.
    init?(title: String)

}
