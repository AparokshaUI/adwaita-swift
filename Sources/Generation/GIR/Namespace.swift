//
//  Namespace.swift
//  Adwaita
//
//  Created by david-swift on 14.01.24.
//

/// A namespace.
struct Namespace: Decodable {

    /// The classes.
    var classes: [Class]
    /// The interfaces (protocols).
    var interfaces: [Interface]

    /// The coding keys.
    enum CodingKeys: String, CodingKey {

        /// Coding key.
        case classes = "class"
        /// Coding key.
        case interfaces = "interface"

    }

}
