//
//  GIR.swift
//  Adwaita
//
//  Created by david-swift on 14.01.24.
//

import Foundation
import XMLCoder

/// The result of decoding a GIR file.
struct GIR: Decodable {

    /// The namespace.
    var namespace: Namespace

    /// Decode a GIR file.
    /// - Returns: The GIR data.
    static func decodeGIR(_ data: Data) throws -> Self {
        let decoder = XMLDecoder()
        decoder.keyDecodingStrategy = .custom { path in
            let codingKey = path[path.count - 1]
            let containsColon = codingKey.stringValue.contains(":")
            let containsHyphen = codingKey.stringValue.contains("-")
            if containsColon || containsHyphen {
                var input = codingKey.stringValue
                var output = ""

                // Remove namespace
                if containsColon {
                    let parts = input.split(separator: ":").map(String.init)
                    output = parts[0]
                    input = parts[1]
                }

                // Convert kebab-case to camelCase
                if containsHyphen {
                    var parts = input.split(separator: "-")
                    let firstPart = String(parts.removeFirst())
                    if containsColon {
                        output += firstPart.capitalized
                    } else {
                        output += firstPart
                    }

                    for part in parts {
                        output += part.capitalized
                    }
                } else {
                    output += input.capitalized
                }
                return output
            } else {
                return codingKey
            }
        }
        return try decoder.decode(Self.self, from: data)
    }

}
