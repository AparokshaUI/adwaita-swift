//
//  Class+.swift
//  Adwaita
//
//  Created by david-swift on 22.01.24.
//

extension Class {

    /// Generate the Swift initializer.
    /// - Parameters:
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    ///     - namespace: The namespace.
    ///     - configs: The available widget configurations.
    /// - Returns: The code.
    func generateAdwaitaInitializer(
        config: WidgetConfiguration,
        genConfig: GenerationConfiguration,
        namespace: Namespace,
        configs: [WidgetConfiguration]
    ) -> String {
        let requiredProperties = properties(namespace: namespace, configurations: configs)
            .filter { config.requiredProperties.contains($0.name) }
        var initializer = "public init("
        if config.dynamicWidget != nil {
            initializer.append("_ elements: [Element], ")
        }
        for property in requiredProperties {
            initializer.append("\(property.parameter(config: config, genConfig: genConfig)), ")
        }
        if config.dynamicWidget != nil {
            initializer.append("@ViewBuilder content: @escaping (Element) -> Body, ")
        }
        if !requiredProperties.isEmpty || config.dynamicWidget != nil {
            initializer.removeLast(", ".count)
        }
        initializer.append(") {")
        for property in requiredProperties {
            let name = property.convertPropertyName(configuration: genConfig)
            initializer.append("\n        self.\(name) = \(name)")
        }
        if config.dynamicWidget != nil {
            initializer.append(
                """

                        self.elements = elements
                        self.content = content
                """
            )
        }
        initializer.append("\n    }")
        return initializer
    }

    /// Generate the call of the C initializer.
    /// - Parameters:
    ///     - name: The class name.
    ///     - config: The widget configuration.
    ///     - namespace: The namespace.
    ///     - configs: The available widget configurations.
    /// - Returns: The code.
    func generateInitializer(
        name: String,
        config: WidgetConfiguration,
        namespace: Namespace,
        configs: [WidgetConfiguration]
    ) -> String {
        if let initializer = config.initializer {
            return initializer
        }
        if let initializer = constructors.first(where: { ($0.parameters?.parameters.count ?? 0) == 0 }) {
            return initializer.cIdentifier + "()"
        }
        // swiftlint:disable fatal_error
        fatalError("No initializer with no parameters for \(name). Configure manually.")
        // swiftlint:enable fatal_error
    }

    /// Generate the assignments for the widgets and menus.
    /// - Parameters:
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    ///     - namespace: The namespace.
    ///     - configs: The available widget configurations.
    /// - Returns: The code.
    func generateWidgetAssignments(
        config: WidgetConfiguration,
        genConfig: GenerationConfiguration,
        namespace: Namespace,
        configs: [WidgetConfiguration]
    ) -> String {
        var content = ""
        for property in properties(namespace: namespace, configurations: configs)
        where !config.excludeProperties.contains(property.name) && (property.type?.isWidget ?? false) {
            content += property.generateWidgetAssignment(prefix: prefix(), config: config, genConfig: genConfig)
        }
        for property in properties(namespace: namespace, configurations: configs)
        where !config.excludeProperties.contains(property.name) && (property.type?.isMenu ?? false) {
            content += property.generateMenuAssignment(prefix: prefix(), config: config, genConfig: genConfig)
        }
        content += staticWidgets(namespace: namespace, configs: configs)
        return content
    }

    /// Generate the assignments for bindings.
    /// - Parameters:
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    ///     - namespace: The namespace.
    ///     - configs: The available widget configurations.
    /// - Returns: The code.
    func generateBindingAssignments(
        config: WidgetConfiguration,
        genConfig: GenerationConfiguration,
        namespace: Namespace,
        configs: [WidgetConfiguration]
    ) -> String {
        var content = ""
        for property in properties(namespace: namespace, configurations: configs) {
            if let binding = config.bindings.first(where: { $0.property == property.name }) {
                content += property.generateBindingAssignment(
                    prefix: prefix(),
                    signal: binding.signal,
                    config: config,
                    genConfig: genConfig
                )
            }
        }
        return content
    }

    /// Generate the properties.
    /// - Parameters:
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    ///     - namespace: The namespace.
    ///     - configs: The available widget configurations.
    /// - Returns: The code.
    func generateProperties(
        config: WidgetConfiguration,
        genConfig: GenerationConfiguration,
        namespace: Namespace,
        configs: [WidgetConfiguration]
    ) -> String {
        var content = ""
        for property in properties(namespace: namespace, configurations: configs)
        where !config.excludeProperties.contains(property.name) || config.requiredProperties.contains(property.name) {
            content += property.generate(config: config, genConfig: genConfig)
        }
        for signal in signals(namespace: namespace) where !config.excludeSignals.contains(signal.name) {
            content += signal.generateProperty(config: config, genConfig: genConfig)
        }
        if config.dynamicWidget != nil {
            content += """

                /// The dynamic widget elements.
                var elements: [Element]
                /// The dynamic widget content.
                var content: (Element) -> Body
            """
        }
        content += staticWidgetProperties(namespace: namespace, configs: configs)
        return content
    }

    /// Generate the property modifications for updating.
    /// - Parameters:
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    ///     - namespace: The namespace.
    ///     - configs: The available widget configurations.
    /// - Returns: The code.
    func generateModifications(
        config: WidgetConfiguration,
        genConfig: GenerationConfiguration,
        namespace: Namespace,
        configs: [WidgetConfiguration]
    ) -> String {
        var content = ""
        for property in properties(namespace: namespace, configurations: configs)
        .sorted(by: { config.lastProperties.contains($1.name) })
        where !config.excludeProperties.contains(property.name) {
            content += property.generateModification(config: config, genConfig: genConfig, prefix: prefix())
        }
        for widget in config.staticWidgets {
            content += """

                        if let \(widget.name)Storage = storage.content["\(widget.name)"] {
                            for (index, view) in \(widget.name)().enumerated() {
                                if let storage = \(widget.name)Storage[safe: index] {
                                    view.updateStorage(
                                        storage,
                                        data: data,
                                        updateProperties: updateProperties,
                                        type: type
                                    )
                                }
                            }
                        }
            """
        }
        return content
    }

    /// Generate the content of the update closure for dynamic widgets.
    /// - Parameters:
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    /// - Returns: The code.
    func generateDynamicWidgetUpdate(config: WidgetConfiguration, genConfig: GenerationConfiguration) -> String {
        let child = "let child = content(element).storage(data: data, type: type)"
        let pointer = "child.opaquePointer?.cast()"
        let widget = "widget" + (config.cast ? "?.cast()" : "")
        if let dynamicWidget = config.dynamicWidget {
            // swiftlint:disable line_length
            return """
                        var contentStorage: [ViewStorage] = storage.content[.mainContent] ?? []
                        let old = storage.fields["element"] as? [Element] ?? []
                        old.identifiableTransform(
                            to: elements,
                            functions: .init { index, element in
                                \(child)
                                \(dynamicWidget.remove)(\(widget), \(dynamicWidget.getElement))
                                \(dynamicWidget.insert)(\(widget), \(pointer), index.cInt)
                                contentStorage.remove(at: index)
                                contentStorage.insert(child, at: index)
                            } delete: { index in
                                \(dynamicWidget.remove)(\(widget), \(dynamicWidget.getElement))
                                contentStorage.remove(at: index)
                            } insert: { index, element in
                                \(child)
                                \(dynamicWidget.insert)(\(widget), \(pointer), index.cInt)
                                contentStorage.insert(child, at: index)
                            }
                        )
                        storage.fields["element"] = elements
                        storage.content[.mainContent] = contentStorage
                        for (index, element) in elements.enumerated() {
                            content(element).updateStorage(contentStorage[index], data: data, updateProperties: updateProperties, type: type)
                        }
            """
            // swiftlint:enable line_length
        } else {
            return ""
        }
    }

    /// Generate the modifications for the signals.
    /// - Parameters:
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    ///     - namespace: The namespace.
    /// - Returns: The code.
    func generateSignalModifications(
        config: WidgetConfiguration,
        genConfig: GenerationConfiguration,
        namespace: Namespace
    ) -> String {
        var content = ""
        for signal in signals(namespace: namespace) where !config.excludeSignals.contains(signal.name) {
            content += signal.generateModification(config: config, genConfig: genConfig)
        }
        return content
    }

    /// Generate the modifiers.
    /// - Parameters:
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    ///     - namespace: The namespace.
    ///     - configs: The available widget configurations.
    /// - Returns: The code.
    func generateModifiers(
        config: WidgetConfiguration,
        genConfig: GenerationConfiguration,
        namespace: Namespace,
        configs: [WidgetConfiguration]
    ) -> String {
        var content = ""
        for property in properties(namespace: namespace, configurations: configs)
        where !config.excludeProperties.contains(property.name) {
            content += property.generateModifier(config: config, genConfig: genConfig)
        }
        for signal in signals(namespace: namespace) where !config.excludeSignals.contains(signal.name) {
            content += signal.generateModifier(config: config, genConfig: genConfig)
        }
        content += generateWidgetModifiers(config: config, configs: configs, namespace: namespace)
        return content
    }
}
