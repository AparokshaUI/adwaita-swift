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

    /// The start content's id.
    let startID = "start"
    /// The end content's id.
    let endID = "end"

    /// Initialize a header bar.
    /// - Parameters:
    ///   - start: The start content.
    ///   - end: The end content.
    public init(@ViewBuilder start: () -> Body, @ViewBuilder end: () -> Body) {
        self.start = start()
        self.end = end()
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
    /// - Parameter storage: The view storage.
    public func update(_ storage: ViewStorage) {
        start.update(storage.content[startID] ?? [])
        end.update(storage.content[endID] ?? [])
    }

    /// Get the container for a header bar.
    /// - Returns: The view storage.
    public func container() -> ViewStorage {
        let bar: GTUI.HeaderBar = .init()
        var startContent: [ViewStorage] = []
        var endContent: [ViewStorage] = []
        for element in start {
            let element = element.storage()
            _ = bar.packStart(element.view)
            startContent.append(element)
        }
        for element in end {
            let element = element.storage()
            _ = bar.packEnd(element.view)
            endContent.append(element)
        }
        return .init(bar, content: [startID: startContent, endID: endContent])
    }

}
