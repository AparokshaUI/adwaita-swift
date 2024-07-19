//
//  GIRType.swift
//  Adwaita
//
//  Created by david-swift on 14.01.24.
//

/// A GIR type.
struct GIRType: Decodable {

    /// The type's name.
    var name: String?
    /// The C type.
    var cType: String?

    /// Whether the type is `GtkWidget`.
    var isWidget: Bool { name == "Widget" || name == "Gtk.Widget" }
    /// Whether the type is `GioMenuModel`.
    var isMenu: Bool { name == "MenuModel" || name == "Gio.MenuModel" }

    /// Generate the Swift representation of the type.
    /// - Parameter configuration: The generation configuration.
    /// - Returns: The code.
    func generate(configuration: GenerationConfiguration) throws -> String {
        if let cType {
            return cType.convertCType(configuration: configuration)
        } else if let name, let type = configuration.cTypeReplacements[name] {
            return type
        }
        return "String"
    }

    /// Generate the Swift type as a binding.
    /// - Parameter configuration: The generation configuration.
    /// - Returns: The code.
    func binding(configuration: GenerationConfiguration) throws -> String {
        "Binding<\(try generate(configuration: configuration))>"
    }

}
