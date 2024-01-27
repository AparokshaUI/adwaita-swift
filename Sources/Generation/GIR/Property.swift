//
//  Property.swift
//  Adwaita
//
//  Created by david-swift on 14.01.24.
//

/// A property.
struct Property: Decodable {

    /// The property's name.
    var name: String
    /// The docs.
    var doc: String?
    /// The property's getter.
    var getter: String?
    /// The property's setter.
    var setter: String?
    /// The property's type.
    var type: GIRType?
    /// This overwrites the prefix provided by the caller of a function.
    var prefix: String?
    // swiftlint:disable discouraged_optional_boolean
    /// This overwrites the cast information provided by the caller of a function.
    var cast: Bool?
    // swiftlint:enable discouraged_optional_boolean

    /// Get the Swift property name.
    /// - Parameter configuration: The generation configuration.
    /// - Returns: The name.
    func convertPropertyName(configuration: GenerationConfiguration) -> String {
        name.convertDelimitedCasingToCamel(delimiter: "-", configuration: configuration, unshorten: true)
    }

    /// Get the property's name and type for parameters or as part of a property definition.
    /// - Parameters:
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    ///     - modifier: Whether it is used as a parameter.
    ///     - defaultValue: Whether to set the default value.
    /// - Returns: The code.
    func parameter(
        config: WidgetConfiguration,
        genConfig: GenerationConfiguration,
        modifier: Bool = false,
        defaultValue: Bool = false
    ) -> String {
        var type: String
        if config.bindings.contains { $0.property == name } {
            type = (try? self.type?.binding(configuration: genConfig)) ?? "Binding<String>"
        } else {
            type = (try? self.type?.generate(configuration: genConfig)) ?? "String"
        }
        if self.type?.isWidget ?? false {
            type = "\(modifier ? "@escaping" : "") (() -> Body)"
        } else if self.type?.isMenu ?? false {
            type = "\(modifier ? "@escaping" : "") (() -> MenuContent)"
        }
        if !config.requiredProperties.contains(name)
        && !(((self.type?.isWidget ?? false) || (self.type?.isMenu ?? false)) && modifier) {
            type += "?"
        }
        if defaultValue, let value = genConfig.defaultModifierValues[type] {
            type += " = \(value)"
        }
        return "\(convertPropertyName(configuration: genConfig)): \(type)"
    }

    /// Generate the property as a Swift property.
    /// - Parameters:
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    /// - Returns: The code.
    func generate(config: WidgetConfiguration, genConfig: GenerationConfiguration) -> String {
        """

        \(doc?.docComment(indent: "    ") ?? "/// \(name)")
            var \(parameter(config: config, genConfig: genConfig))
        """
    }

    // swiftlint:disable line_length
    /// Generate the property's modifier.
    /// - Parameters:
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    /// - Returns: The code.
    func generateModifier(config: WidgetConfiguration, genConfig: GenerationConfiguration) -> String {
        let property = convertPropertyName(configuration: genConfig)
        let builder = (type?.isWidget ?? false) ? "@ViewBuilder " : ((type?.isMenu ?? false) ? "@MenuBuilder " : "")
        let mainParameter = parameter(config: config, genConfig: genConfig, modifier: true, defaultValue: true)
        var sideParameters = ""
        var sideAssignments = ""
        if type?.isMenu ?? false {
            sideParameters += "app: GTUIApp, window: GTUIApplicationWindow? = nil, "
            sideAssignments += "newSelf.app = app; newSelf.window = window"
        }
        return """

        \(doc?.docComment(indent: "    ") ?? "/// \(name)")
            public func \(convertPropertyName(configuration: genConfig))(\(sideParameters)\(builder)_ \(mainParameter)) -> Self {
                var newSelf = self
                newSelf.\(property) = \(property)
                \(sideAssignments)
                return newSelf
            }

        """
    }

    // swiftlint:disable function_body_length
    /// Generate the property's modification when being updated.
    /// - Parameters:
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    ///     - prefix: The widget's prefix.
    /// - Returns: The code.
    func generateModification(
        config: WidgetConfiguration,
        genConfig: GenerationConfiguration,
        prefix: String
    ) -> String {
        let name = convertPropertyName(configuration: genConfig)
        guard !(type?.isWidget ?? false) else {
            return """
                        if let widget = storage.content["\(name)"]?.first {
                            \(name)?().widget(modifiers: modifiers).update(widget, modifiers: modifiers, updateProperties: updateProperties)
                        }

            """
        }
        guard !(type?.isMenu ?? false) else {
            return ""
        }
        guard var setter else {
            return ""
        }
        setter = (self.prefix ?? prefix) + "_" + setter
        let type = try? type?.generate(configuration: genConfig)
        let cProperty = genConfig.cTypeProperties.first { $0.key == type }
        let propertyString = cProperty == nil ? "" : ".\(cProperty?.value ?? "")"
        let widget = (self.cast ?? config.cast) ? "widget?.cast()" : "widget"
        var setConditions = ""
        var onlySetConditions = ""
        var onlySetConditionsIndentation = ""
        var onlySetConditionsEnd = ""
        if let conditions = config.setConditions[name] {
            setConditions = ", \(conditions)"
            onlySetConditions = "if \(conditions) {\n            "
            onlySetConditionsIndentation = "    "
            onlySetConditionsEnd = "\n            }"
        }
        if config.bindings.contains { $0.property == self.name } {
            return """
                        if let \(name)\(setConditions), updateProperties {
                            \(setter)(\(widget), \(name).wrappedValue\(propertyString))
                        }

            """
        } else if config.requiredProperties.contains(self.name) {
            return """
                        if updateProperties {
                            \(onlySetConditions)\(onlySetConditionsIndentation)\(setter)(\(widget), \(name)\(propertyString))\(onlySetConditionsEnd)
                        }

            """
        } else {
            return """
                        if let \(name)\(setConditions), updateProperties {
                            \(setter)(\(widget), \(name)\(propertyString))
                        }

            """
        }
    }
    // swiftlint:enable line_length function_body_length

    /// Generate the widget assignments.
    /// - Parameters:
    ///     - prefix: The widget's prefix.
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    /// - Returns: The code.
    func generateWidgetAssignment(
        prefix: String,
        config: WidgetConfiguration,
        genConfig: GenerationConfiguration
    ) -> String {
        guard var setter else {
            return ""
        }
        setter = (self.prefix ?? prefix) + "_" + setter
        let name = convertPropertyName(configuration: genConfig)
        let view = (self.cast ?? config.cast) ? "storage.pointer?.cast()" : "storage.pointer"
        return """
                if let \(name)Storage = \(name)?().widget(modifiers: modifiers).storage(modifiers: modifiers) {
                    storage.content["\(name)"] = [\(name)Storage]
                    \(setter)(\(view), \(name)Storage.pointer?.cast())
                }

        """
    }

    /// Generate the menu assignments.
    /// - Parameters:
    ///     - prefix: The widget's prefix.
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    /// - Returns: The code.
    func generateMenuAssignment(
        prefix: String,
        config: WidgetConfiguration,
        genConfig: GenerationConfiguration
    ) -> String {
        guard var setter else {
            return ""
        }
        setter = (self.prefix ?? prefix) + "_" + setter
        let name = convertPropertyName(configuration: genConfig)
        let view = (self.cast ?? config.cast) ? "storage.pointer?.cast()" : "storage.pointer"
        return """
                if let declarative = \(name)?(), let app {
                    let menu = g_menu_new()
                    \(setter)(\(view), menu?.cast())
                    for item in declarative {
                        item.addMenuItems(menu: menu, app: app, window: window)
                    }
                }

        """
    }

    /// Generate a binding assignment.
    /// - Parameters:
    ///     - prefix: The widget's prefix.
    ///     - signal: The signal's name, if there is one.
    ///     - config: The widget configuration.
    ///     - genConfig: The generation configuration.
    /// - Returns: The code.
    func generateBindingAssignment(
        prefix: String,
        signal: String?,
        config: WidgetConfiguration,
        genConfig: GenerationConfiguration
    ) -> String {
        guard var getter else {
            return ""
        }
        let widget = (self.cast ?? config.cast) ? "storage.pointer?.cast()" : "storage.pointer"
        getter = "\((self.prefix ?? prefix) + "_" + getter)(\(widget))"
        let name = convertPropertyName(configuration: genConfig)
        let finalGetter = genConfig.getterTypeConversions[type?.name ?? ""]?(getter) ?? getter
        let setter = "\(name)?.wrappedValue = \(finalGetter)"
        if let signal {
            return """

                    storage.connectSignal(name: "\(signal)", id: "\(self.name)") {
                        \(setter)
                    }
            """
        } else {
            return """

                    storage.notify(name: "\(self.name)") {
                        \(setter)
                    }
            """
        }
    }

}
