//
//  HeaderBar+.swift
//  Adwaita
//
//  Created by david-swift on 21.01.23.
//

extension HeaderBar {

    /// Initialize a header bar.
    /// - Parameters:
    ///   - titleButtons: Whether the title buttons (e.g. close button) are visible.
    ///   - start: The start content.
    ///   - end: The end content.
    public init(
        titleButtons: Bool = true,
        @ViewBuilder start: @escaping () -> Body,
        @ViewBuilder end: @escaping () -> Body
    ) {
        self.init()
        self = self.showStartTitleButtons(titleButtons).showEndTitleButtons(titleButtons)
        self = self.start(start).end(end)
    }

    /// Initialize an empty header bar.
    /// - Returns: The header bar.
    public static func empty() -> Self {
        .init(start: { }, end: { })
    }

    /// Initialize a header bar with only views at the start.
    /// - Parameter start: The views.
    /// - Returns: The header bar.
    public static func start(@ViewBuilder start: @escaping () -> Body) -> Self {
        .init(start: start) { }
    }

    /// Initialize a header bar with only views at the end.
    /// - Parameter start: The views.
    /// - Returns: The header bar.
    public static func end(@ViewBuilder end: @escaping () -> Body) -> Self {
        .init(start: { }, end: end)
    }

    /// Set the title widget for the header bar.
    /// - Parameter view: The widget in the header bar.
    /// - Returns: The header bar.
    public func headerBarTitle(@ViewBuilder view: @escaping () -> Body) -> Self {
        titleWidget(view)
    }

}
