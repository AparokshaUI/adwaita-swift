//
//  Signal.swift
//  Adwaita
//
//  Created by david-swift on 14.01.24.
//

/// A signal.
struct Signal: Decodable {

    /// The signal's name.
    var name: String
    /// The signal's documentation.
    var doc: String?

    /// Generate the signal's property.
    /// - Parameters:
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    /// - Returns: The code.
    func generateProperty(config: WidgetConfiguration, genConfig: GenerationConfiguration) -> String {
        let name = name.convertDelimitedCasingToCamel(delimiter: "-", configuration: genConfig, unshorten: true)
        return """

        \(doc?.docComment(indent: "    ") ?? "    /// \(name)")
            var \(name): (() -> Void)?
        """
    }

    /// Generate the signal's modifier.
    /// - Parameters:
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    /// - Returns: The code.
    func generateModifier(config: WidgetConfiguration, genConfig: GenerationConfiguration) -> String {
        let name = name.convertDelimitedCasingToCamel(delimiter: "-", configuration: genConfig, unshorten: true)
        return """

        \(doc?.docComment(indent: "    ") ?? "    /// \(name)")
            public func \(name)(_ \(name): @escaping () -> Void) -> Self {
                var newSelf = self
                newSelf.\(name) = \(name)
                return newSelf
            }

        """
    }

    /// Generate the signal's modification.
    /// - Parameters:
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    /// - Returns: The code.
    func generateModification(config: WidgetConfiguration, genConfig: GenerationConfiguration) -> String {
        let name = name.convertDelimitedCasingToCamel(delimiter: "-", configuration: genConfig, unshorten: true)
        return """

                if let \(name) {
                    storage.connectSignal(name: "\(self.name)") {
                        \(name)()
                    }
                }
        """
    }

}
