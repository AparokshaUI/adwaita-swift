//
//  Class.swift
//  Adwaita
//
//  Created by david-swift on 14.01.24.
//

import Foundation

/// A class.
struct Class: Decodable {

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

    }

    /// Get the properties of the class and its parent classes.
    /// - Parameters:
    ///     - classes: The classes in the namespace.
    ///     - configurations: The configurations for the classes in the namespace.
    /// - Returns: The properties.
    func properties(classes: [Self], configurations: [WidgetConfiguration]) -> [Property] {
        if let parentClass = parentClass(classes: classes) {
            return properties + parentClass
                .properties(classes: classes, configurations: configurations)
                .map { property in
                    var property = property
                    if property.prefix == nil {
                        property.prefix = parentClass.prefix()
                        property.cast = configurations.first { $0.class == parentClass.name }?.cast ?? false
                    }
                    return property
                }
        }
        return properties
    }

    /// Get the signals of the class and its parent classes.
    /// - Parameter classes: The classes in the namespace.
    /// - Returns: The signals.
    func signals(classes: [Self]) -> [Signal] {
        if let parentClass = parentClass(classes: classes) {
            return signals + parentClass.signals(classes: classes)
        }
        return signals
    }

    /// Get the assignments for the static widgets of the class and its parent classes.
    /// - Parameters:
    ///     - classes: The classes in the namespace.
    ///     - configs: The configurations.
    /// - Returns: The code.
    func staticWidgets(classes: [Self], configs: [WidgetConfiguration]) -> String {
        var content = ""
        if let parentClass = parentClass(classes: classes) {
            content += parentClass.staticWidgets(classes: classes, configs: configs)
        }
        guard let config = configs.first(where: { $0.class == name }) else {
            return content
        }
        let widgetPointer = config.cast ? "storage.pointer?.cast()" : "storage.pointer"
        for widget in config.staticWidgets {
            content += """

                    var \(widget.name)Storage: [ViewStorage] = []
                    for view in \(widget.name)() {
                        \(widget.name)Storage.append(view.storage(modifiers: modifiers))
                        \(widget.add)(\(widgetPointer), \(widget.name)Storage.last?.pointer?.cast())
                    }
                    storage.content["\(widget.name)"] = \(widget.name)Storage
            """
        }
        return content
    }

    /// Get the code for the properties of the static widgets.
    /// - Parameters:
    ///     - classes: The classes in the namespace.
    ///     - configs: The configurations.
    /// - Returns: The code.
    func staticWidgetProperties(classes: [Self], configs: [WidgetConfiguration]) -> String {
        var content = ""
        if let parentClass = parentClass(classes: classes) {
            content += parentClass.staticWidgetProperties(classes: classes, configs: configs)
        }
        guard let config = configs.first(where: { $0.class == name }) else {
            return content
        }
        for staticWidget in config.staticWidgets {
                content += """

                    /// The body for the widget "\(staticWidget.name)".
                    var \(staticWidget.name): () -> Body = { [] }
                """
        }
        return content
    }

    /// Get the parent class.
    /// - Parameter classes: The classes in the namespace.
    /// - Returns: The class.
    func parentClass(classes: [Self]) -> Self? {
        if let parent = classes.first(where: { $0.name == parent }), parent.name != "Widget" {
            return parent
        }
        return nil
    }

    /// Get the widget's prefix (e.g. "adw_preferences_row").
    /// - Returns: The prefix.
    func prefix() -> String {
        if cType?.hasPrefix("Adw") ?? false {
            return "adw_\(cSymbolPrefix)"
        } else {
            return "gtk_\(cSymbolPrefix)"
        }
    }

    // swiftlint:disable function_body_length line_length
    /// Generate the code for the class.
    /// - Parameters:
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    ///     - classes: The available classes.
    ///     - configs: The available widget configurations.
    /// - Returns: The code.
    func generate(
        config: WidgetConfiguration,
        genConfig: GenerationConfiguration,
        classes: [Self],
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
        \(generateProperties(config: config, genConfig: genConfig, classes: classes, configs: configs))

            /// Initialize `\(widgetName)`.
            \(generateAdwaitaInitializer(config: config, genConfig: genConfig, classes: classes, configs: configs))

            /// Get the widget's view storage.
            /// - Parameter modifiers: The view modifiers.
            /// - Returns: The view storage.
            public func container(modifiers: [(View) -> View]) -> ViewStorage {
                let storage = ViewStorage(\(generateInitializer(name: widgetName, config: config, classes: classes, configs: configs))?.opaque())
                update(storage, modifiers: modifiers)
        \(generateWidgetAssignments(config: config, genConfig: genConfig, classes: classes, configs: configs))
        \(generateBindingAssignments(config: config, genConfig: genConfig, classes: classes, configs: configs))
                for function in appearFunctions {
                    function(storage)
                }
                return storage
            }

            /// Update the widget's view storage.
            /// - Parameters:
            ///     - storage: The view storage.
            ///     - modifiers: The view modifiers.
            public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {\(generateSignalModifications(config: config, genConfig: genConfig, classes: classes))
                storage.modify { widget in
        \(generateModifications(config: config, genConfig: genConfig, classes: classes, configs: configs))
        \(generateDynamicWidgetUpdate(config: config, genConfig: genConfig))
                }
                for function in updateFunctions {
                    function(storage)
                }
            }
        \(generateModifiers(config: config, genConfig: genConfig, classes: classes, configs: configs))
        }

        """
    }
    // swiftlint:enable function_body_length line_length

}
