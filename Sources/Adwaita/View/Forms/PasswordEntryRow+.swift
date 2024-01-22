//
//  PasswordEntryRow+.swift
//  Adwaita
//
//  Created by david-swift on 20.01.24.
//

import CAdw

extension PasswordEntryRow {

    static var textField: String { "text" }

    /// Initialize an entry row.
    /// - Parameters:
    ///     - title: The row's title.
    ///     - text: The text.
    public init(_ title: String, text: Binding<String>) {
        self.init()
        self = self.title(title)
        appearFunctions.append { storage in
            storage.fields[Self.textField] = text
            storage.notify(name: "text") {
                if let binding = storage.fields[Self.textField] as? Binding<String> {
                    binding.wrappedValue = .init(cString: gtk_editable_get_text(storage.pointer))
                }
            }
        }
        updateFunctions.append { storage in
            if text.wrappedValue != .init(cString: gtk_editable_get_text(storage.pointer)) {
                gtk_editable_set_text(storage.pointer, text.wrappedValue)
            }
        }
    }

    /// Set the entry row's subtitle.
    /// - Parameter subtitle: The subtitle.
    /// - Returns: The entry row.
    public func onSubmit(_ onSubmit: @escaping () -> Void) -> Self {
        apply(onSubmit)
    }

}
