//
//  ViewSwitcher.swift
//  Adwaita
//
//  Created by david-swift on 03.01.24.
//

import Libadwaita

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
        let switcher = Libadwaita.ViewSwitcher()
        for option in Element.allCases {
            _ = switcher.addOption(title: option.title, icon: option.icon)
        }
        _ = switcher.onSelect {
            let selection = switcher.getSelection()
            if let element = Element(title: selection) {
                self.selection = element
            }
        }
        updateSwitcher(switcher: switcher)
        return .init(switcher)
    }

    /// Update a view switcher's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let switcher = storage.view as? Libadwaita.ViewSwitcher {
            updateSwitcher(switcher: switcher)
        }
    }

    /// Update a view switcher's style and selection.
    /// - Parameter switcher: The view switcher.
    func updateSwitcher(switcher: Libadwaita.ViewSwitcher) {
        _ = switcher.wideDesign(wide)
        switcher.select(title: selection.title)
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
