//
//  Class.swift
//  Adwaita
//
//  Created by david-swift on 14.01.24.
//

import Foundation

/// A class.
struct Class: ClassLike, Decodable {

    /// The name of the class.
    var name: String
    /// The prefix for C symbols.
    var cSymbolPrefix: String
    /// The type in C.
    var cType: String?
    /// The parent class.
    var parent: String?

    /// The doc string.
    var doc: String
    /// The available initializers.
    var constructors: [Constructor]
    /// The available properties.
    var properties: [Property]
    /// The available signals (callbacks).
    var signals: [Signal]
    /// Protocol conformances.
    var conformances: [Conformance]

    /// The coding keys for the class
    enum CodingKeys: String, CodingKey {

        /// Coding key
        case name, cSymbolPrefix, cType, parent, doc
        /// Coding key
        case constructors = "constructor"
        /// Coding key
        case properties = "property"
        /// Coding key
        case signals = "glibSignal"
        /// Coding key
        case conformances = "implements"

    }

    // swiftlint:disable function_body_length line_length
    /// Generate the code for the class.
    /// - Parameters:
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    ///     - namespace: The namespace.
    ///     - configs: The available widget configurations.
    /// - Returns: The code.
    func generate(
        config: WidgetConfiguration,
        genConfig: GenerationConfiguration,
        namespace: Namespace,
        configs: [WidgetConfiguration]
    ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let widgetName = config.name ?? config.class
        let definition: String
        if config.dynamicWidget == nil {
            definition = "\(widgetName): Widget"
        } else {
            definition = "\(widgetName)<Element>: Widget where Element: Identifiable"
        }
        return """
        //
        //  \(widgetName).swift
        //  Adwaita
        //
        //  Created by auto-generation on \(dateFormatter.string(from: .now)).
        //

        import CAdw
        import LevenshteinTransformations

        \(doc.docComment())
        public struct \(definition) {

            /// Additional update functions for type extensions.
            var updateFunctions: [(ViewStorage) -> Void] = []
            /// Additional appear functions for type extensions.
            var appearFunctions: [(ViewStorage) -> Void] = []
        \(generateProperties(config: config, genConfig: genConfig, namespace: namespace, configs: configs))

            /// Initialize `\(widgetName)`.
            \(generateAdwaitaInitializer(config: config, genConfig: genConfig, namespace: namespace, configs: configs))

            /// Get the widget's view storage.
            /// - Parameter modifiers: The view modifiers.
            /// - Returns: The view storage.
            public func container(modifiers: [(View) -> View]) -> ViewStorage {
                let storage = ViewStorage(\(generateInitializer(name: widgetName, config: config, namespace: namespace, configs: configs))?.opaque())
                update(storage, modifiers: modifiers, updateProperties: true)
        \(generateWidgetAssignments(config: config, genConfig: genConfig, namespace: namespace, configs: configs))
                for function in appearFunctions {
                    function(storage)
                }
                return storage
            }

            /// Update the widget's view storage.
            /// - Parameters:
            ///     - storage: The view storage.
            ///     - modifiers: The view modifiers.
            ///     - updateProperties: Whether to update the view's properties.
            public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {\(generateSignalModifications(config: config, genConfig: genConfig, namespace: namespace))
                storage.modify { widget in
        \(generateBindingAssignments(config: config, genConfig: genConfig, namespace: namespace, configs: configs))
        \(generateModifications(config: config, genConfig: genConfig, namespace: namespace, configs: configs))
        \(generateDynamicWidgetUpdate(config: config, genConfig: genConfig))
                }
                for function in updateFunctions {
                    function(storage)
                }
            }
        \(generateModifiers(config: config, genConfig: genConfig, namespace: namespace, configs: configs))
        }

        """
    }
    // swiftlint:enable function_body_length line_length

}
