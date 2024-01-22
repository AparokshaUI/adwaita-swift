//
//  Constructor.swift
//  Adwaita
//
//  Created by david-swift on 14.01.24.
//

/// An initializer.
struct Constructor: Decodable {

    /// The identifier of the C constructor.
    var cIdentifier: String
    /// The parameters.
    var parameters: Parameters?

}
