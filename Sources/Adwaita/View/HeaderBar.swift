//
//  HeaderBar.swift
//  Adwaita
//
//  Created by david-swift on 23.08.23.
//

import GTUI

/// A header bar widget.
public struct HeaderBar: Widget {

    /// The start content of the header bar.
    var start: Body
    /// The end content of the header bar.
    var end: Body
    /// Whether the title buttons are visible.
    var titleButtons: Bool
    /// The view acting as the title of the header bar.
    var headerBarTitle: Body?

    /// The start content's id.
    let startID = "start"
    /// The end content's id.
    let endID = "end"
    /// The title's id.
    let titleID = "title"

    /// Initialize a header bar.
    /// - Parameters:
    ///   - titleButtons: Whether the title buttons (e.g. close button) are visible.
    ///   - start: The start content.
    ///   - end: The end content.
    public init(titleButtons: Bool = true, @ViewBuilder start: () -> Body, @ViewBuilder end: () -> Body) {
        self.titleButtons = titleButtons
        self.start = start()
        self.end = end()
    }

    /// Initialize an empty header bar.
    /// - Returns: The header bar.
    public static func empty() -> Self {
        .init(start: { }, end: { })
    }

    /// Initialize a header bar with only views at the start.
    /// - Parameter start: The views.
    /// - Returns: The header bar.
    public static func start(@ViewBuilder start: () -> Body) -> Self {
        .init(start: start) { }
    }

    /// Initialize a header bar with only views at the end.
    /// - Parameter start: The views.
    /// - Returns: The header bar.
    public static func end(@ViewBuilder end: () -> Body) -> Self {
        .init(start: { }, end: end)
    }

    /// Update a header bar's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let bar = storage.view as? GTUI.HeaderBar {
            _ = bar.showTitleButtons(titleButtons)
        }
        start.update(storage.content[startID] ?? [], modifiers: modifiers)
        end.update(storage.content[endID] ?? [], modifiers: modifiers)
        if let first = storage.content[titleID]?.first {
            headerBarTitle?.widget(modifiers: modifiers).update(first, modifiers: modifiers)
        }
    }

    /// Get the container for a header bar.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let bar: GTUI.HeaderBar = .init()
        var startContent: [ViewStorage] = []
        var endContent: [ViewStorage] = []
        for element in start {
            let element = element.storage(modifiers: modifiers)
            _ = bar.packStart(element.view)
            startContent.append(element)
        }
        for element in end {
            let element = element.storage(modifiers: modifiers)
            _ = bar.packEnd(element.view)
            endContent.append(element)
        }
        let title = headerBarTitle?.widget(modifiers: modifiers).container(modifiers: modifiers)
        let titleStorage: [ViewStorage]
        if let title {
            _ = bar.titleWidget(title.view)
            titleStorage = [title]
        } else {
            titleStorage = []
        }
        _ = bar.showTitleButtons(titleButtons)
        return .init(bar, content: [startID: startContent, endID: endContent, titleID: titleStorage])
    }

    /// Set the title widget for the header bar.
    /// - Parameter view: The widget in the header bar.
    /// - Returns: The header bar.
    public func headerBarTitle(@ViewBuilder view: () -> Body) -> Self {
        var newSelf = self
        newSelf.headerBarTitle = view()
        return newSelf
    }

}
