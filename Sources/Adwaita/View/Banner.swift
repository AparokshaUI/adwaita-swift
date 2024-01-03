//
//  Banner.swift
//  Adwaita
//
//  Created by david-swift on 03.01.24.
//

import Libadwaita

/// A banner widget.
public struct Banner: Widget {

    /// The content.
    var title: String
    /// Whether the banner is visible.
    var visible: Bool
    /// The button's label.
    var buttonLabel: String?
    /// The button's handler.
    var handler: () -> Void = { }

    /// Initialize a text widget.
    /// - Parameters:
    ///     - title: The content.
    ///     - visible: Whether the banner is visible.
    public init(_ title: String, visible: Bool) {
        self.title = title
        self.visible = visible
    }

    /// Update the view storage of the text widget.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let banner = storage.view as? Libadwaita.Banner {
            update(banner: banner)
        }
    }

    /// Get the container of the text widget.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let banner = Libadwaita.Banner(title)
        update(banner: banner)
        return .init(banner)
    }

    /// Update the banner.
    /// - Parameter banner: The banner.
    func update(banner: Libadwaita.Banner) {
        _ = banner.title(title)
        if let buttonLabel {
            _ = banner.buttonLabel(buttonLabel)
            _ = banner.buttonHandler(handler)
        }
        if visible {
            banner.show()
        } else {
            banner.hide()
        }
    }

    /// Configure the banner's button.
    /// - Parameters:
    ///     - label: The button's title.
    ///     - handler: The button's handler.
    /// - Returns: The banner.
    public func button(_ label: String, handler: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.buttonLabel = label
        newSelf.handler = handler
        return newSelf
    }

}
