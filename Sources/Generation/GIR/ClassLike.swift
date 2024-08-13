//
//  ClassLike.swift
//  Adwaita
//
//  Created by david-swift on 14.02.24.
//

/// Classes and interfaces share a lot of their properties.
protocol ClassLike {

    /// The type name.
    var name: String { get }
    /// The C symbol prefix.
    var cSymbolPrefix: String { get }
    /// The C type.
    var cType: String? { get }
    /// The signals.
    var signals: [Signal] { get }
    /// The properties.
    var properties: [Property] { get }

}

extension ClassLike {

    /// Get the properties of the class and its parent classes.
    /// - Parameters:
    ///     - namespace: The namespace.
    ///     - configurations: The configurations for the classes in the namespace.
    /// - Returns: The properties.
    func properties(namespace: Namespace, configurations: [WidgetConfiguration]) -> [Property] {
        var properties = properties.filter { !($0.deprecated ?? false) }
        for type in parentTypes(namespace: namespace) {
            properties += type
                .properties(namespace: namespace, configurations: configurations)
                .map { property in
                    var property = property
                    if property.prefix == nil {
                        property.prefix = type.prefix()
                        property.cast = configurations.first { $0.class == type.name }?.cast ?? false
                    }
                    return property
                }
        }
        return properties.reduce(into: [String: Property]()) { result, property in
            result[property.name] = property
        }
        .values
        .sorted { $0.name < $1.name }
    }

    /// Get the code for the properties of the static widgets.
    /// - Parameters:
    ///     - namespace: The namespace.
    ///     - configs: The configurations.
    /// - Returns: The code.
    func staticWidgetProperties(namespace: Namespace, configs: [WidgetConfiguration]) -> String {
        var content = ""
        for type in parentTypes(namespace: namespace) {
            content += type.staticWidgetProperties(namespace: namespace, configs: configs)
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

    /// Get the assignments for the static widgets of the class and its parent classes.
    /// - Parameters:
    ///     - namespace: The namespace.
    ///     - configs: The configurations.
    /// - Returns: The code.
    func staticWidgets(namespace: Namespace, configs: [WidgetConfiguration]) -> String {
        var content = ""
        for type in parentTypes(namespace: namespace) {
            content += type.staticWidgets(namespace: namespace, configs: configs)
        }
        guard let config = configs.first(where: { $0.class == name }) else {
            return content
        }
        let widgetPointer = config.cast ? "storage.opaquePointer?.cast()" : "storage.opaquePointer"
        for widget in config.staticWidgets {
            content += """

                    var \(widget.name)Storage: [ViewStorage] = []
                    for view in \(widget.name)() {
                        \(widget.name)Storage.append(view.storage(modifiers: modifiers, type: type))
                        \(widget.add)(\(widgetPointer), \(widget.name)Storage.last?.opaquePointer?.cast())
                    }
                    storage.content["\(widget.name)"] = \(widget.name)Storage
            """
        }
        return content
    }

    /// Generate the modifiers for static widgets.
    /// - Parameters:
    ///     - config: The widget configuration.
    ///     - configs: The available widget configurations.
    ///     - namespace: The namespace.
    /// - Returns: The code.
    func generateWidgetModifiers(
        config: WidgetConfiguration,
        configs: [WidgetConfiguration],
        namespace: Namespace
    ) -> String {
        var content = ""
        for widget in config.staticWidgets {
            content += """

                /// Set the body for "\(widget.name)".
                /// - Parameter body: The body.
                /// - Returns: The widget.
                public func \(widget.name)(@ViewBuilder _ body: @escaping () -> Body) -> Self {
                    var newSelf = self
                    newSelf.\(widget.name) = body
                    return newSelf
                }
            """
        }
        for type in parentTypes(namespace: namespace) {
            if let config = configs.first(where: { $0.class == type.name }) {
                content += type.generateWidgetModifiers(config: config, configs: configs, namespace: namespace)
            }
        }
        return content
    }

    /// Get the signals of the class and its parent classes.
    /// - Parameter namespace: The namespace.
    /// - Returns: The signals.
    func signals(namespace: Namespace) -> [Signal] {
        var signals: [Signal] = signals
        for type in parentTypes(namespace: namespace) {
            signals += type.signals(namespace: namespace)
        }
        return signals.reduce(into: [String: Signal]()) { result, property in
            result[property.name] = property
        }
        .values
        .sorted { $0.name < $1.name }
    }

    /// Get the parent class and interfaces.
    /// - Parameter namespace: The namespace in the namespace.
    /// - Returns: The types.
    func parentTypes(namespace: Namespace) -> [ClassLike] {
        var types: [ClassLike] = []
        guard let `class` = self as? Class else {
            return types
        }
        if let parent = namespace.classes.first(where: { $0.name == `class`.parent }), parent.name != "Widget" {
            types.append(parent)
        }
        for conformance in `class`.conformances {
            if let type = namespace.interfaces.first(where: { $0.name == conformance.name }) {
                types.append(type)
            }
        }
        return types
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

}
