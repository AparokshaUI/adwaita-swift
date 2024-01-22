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

}
