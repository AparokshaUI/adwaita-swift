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

    /// The coding keys.
    enum CodingKeys: String, CodingKey {

        /// Coding key.
        case classes = "class"

    }

}
