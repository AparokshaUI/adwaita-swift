//
//  StatusPage+.swift
//  Adwaita
//
//  Created by david-swift on 17.01.23.
//

extension StatusPage {

    /// Initialize a status page widget.
    /// - Parameters:
    ///   - title: The title.
    ///   - icon: The icon.
    ///   - description: Additional details.
    ///   - content: Additional content.
    public init(
        _ title: String,
        icon: Icon? = nil,
        description: String = "",
        @ViewBuilder content: @escaping () -> Body = { [] }
    ) {
        self.init()
        self = self.title(title)
        self = self.description(description)
        self = self.iconName(icon?.string ?? "")
        self = self.child(content)
    }

    /// Make the status page more compact.
    /// - Parameter active: Whether the style is applied.
    /// - Returns: A view.
    public func compact(_ active: Bool = true) -> View {
        style("compact", active: active)
    }

}
