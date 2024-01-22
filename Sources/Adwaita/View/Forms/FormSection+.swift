//
//  FormSection+.swift
//  Adwaita
//
//  Created by david-swift on 20.01.24.
//

/// A section usually groups forms.
public typealias FormSection = PreferencesGroup

extension FormSection {

    /// Initialize a form section.
    /// - Parameters:
    ///     - title: The title.
    ///     - content: The content, usually one or more forms.
    public init(_ title: String, @ViewBuilder content: @escaping () -> Body) {
        self.init()
        self = self.title(title)
        self = self.child(content)
    }

    /// Set the form section's suffix view.
    /// - Parameter suffix: The suffix.
    /// - Returns: The form section.
    public func suffix(@ViewBuilder _ suffix: @escaping () -> Body) -> Self {
        headerSuffix(suffix)
    }

}
