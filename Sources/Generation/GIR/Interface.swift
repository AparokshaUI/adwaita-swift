//
//  Interface.swift
//  Adwaita
//
//  Created by david-swift on 14.02.24.
//

/// An interface (protocol).
struct Interface: ClassLike, Decodable {

    /// The type's name.
    var name: String
    /// The C symbol prefix.
    var cSymbolPrefix: String
    /// The C type.
    var cType: String?

    /// The signals.
    var signals: [Signal]
    /// The properties.
    var properties: [Property]

    /// The coding keys.
    enum CodingKeys: String, CodingKey {

        /// Coding key.
        case name, cSymbolPrefix, cType
        /// Coding key.
        case signals = "glibSignal"
        /// Coding key
        case properties = "property"

    }

}
