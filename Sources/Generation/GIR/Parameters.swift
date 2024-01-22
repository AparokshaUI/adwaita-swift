//
//  Parameters.swift
//  Adwaita
//
//  Created by david-swift on 14.01.24.
//

/// Parameters.
struct Parameters: Decodable {

    /// The parameters.
    var parameters: [Parameter]

    /// The coding keys.
    enum CodingKeys: String, CodingKey {

        /// Coding key.
        case parameters = "parameter"

    }

}
