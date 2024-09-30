//
//  String.swift
//  Adwaita
//
//  Created by david-swift on 14.01.24.
//

extension String: @retroactive CodingKey {

    /// The string.
    public var stringValue: String {
        self
    }

    /// A string cannot be represented as an integer.
    public var intValue: Int? {
        nil
    }

    /// Initialize from an int value.
    /// - Parameter intValue: The int value.
    public init?(intValue: Int) {
        nil
    }

    /// Initialize from a string value.
    /// - Parameter stringValue: The string value.
    public init?(stringValue: String) {
        self = stringValue
    }

    /// Generate a doc comment out of the string.
    /// - Parameter indent: Indentation added at the beginning of every line.
    /// - Returns: The comment.
    func docComment(indent: String = "") -> String {
        split(separator: "\n", omittingEmptySubsequences: false)
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .enumerated()
            .map { $0.offset == 0 ? $0.element.prefix(1).capitalized + $0.element.dropFirst() : $0.element }
            .map { "\(indent)/// \($0)" }
            .joined(separator: "\n")
    }

    /// Convert delimited to camel casing.
    /// - Parameters:
    ///     - delimiter: The demiliter.
    ///     - unshorten: Whether to unshorten.
    ///     - configuration: The generation configuration.
    /// - Returns: The string using camel casing.
    func convertDelimitedCasingToCamel(
        delimiter: Character,
        configuration: GenerationConfiguration,
        unshorten: Bool = false
    ) -> String {
        var parts = split(separator: delimiter).map(String.init)
        for (index, part) in parts.enumerated() {
            if let replacement = configuration.unshorteningMap[part] {
                parts[index] = replacement
            }
        }
        let first = parts.removeFirst()
        return first + parts.map(\.capitalized).joined()
    }

    /// Convert a C type to its Swift equivalent using the generation configuration.
    /// - Parameter configuration: The generation configuration.
    /// - Returns: The Swift type.
    func convertCType(configuration: GenerationConfiguration) -> String {
        if let replacement = configuration.cTypeReplacements[self] {
            return replacement
        }
        var type = self
        if type.last == "*" {
            let pointeeType = String(type.dropLast()).convertCType(configuration: configuration)
            type = "UnsafeMutablePointer<\(pointeeType)>!"
        }
        return type
    }

}
