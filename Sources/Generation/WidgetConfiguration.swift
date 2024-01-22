//
//  WidgetConfiguration.swift
//  Adwaita
//
//  Created by david-swift on 14.01.24.
//

import Foundation

/// The configuration for a single widget.
struct WidgetConfiguration {

    /// The class name.
    var `class`: String
    /// The name of the Swift structure.
    var name: String?
    /// Explicitly set the C initializer.
    var initializer: String?
    /// The properties that should be treated as bindings.
    var bindings: [BindingConfiguration] = []
    /// The dynamic widget.
    var dynamicWidget: DynamicWidget?
    /// The static widgets.
    var staticWidgets: [StaticWidget] = []
    /// Non-optional properties.
    var requiredProperties: [String] = []
    /// Excluded properties.
    var excludeProperties: [String] = []
    /// Excluded signals.
    var excludeSignals: [String] = []
    /// Whether to cast the type.
    var cast = false
    /// Conditions for when to update a property.
    var setConditions: [String: String] = [:]

    /// The configuration for a binding.
    struct BindingConfiguration {

        /// The property.
        var property: String
        /// The signal. If not specified, use "notify::property-name".
        var signal: String?

    }

    /// The configuration for a dynamic widget.
    struct DynamicWidget {

        /// The insert function.
        var insert: String
        /// The remove function.
        var remove: String
        /// Get a child to remove from its index.
        var getElement: String = "index.cInt"

    }

    /// The configuration for a static widget.
    struct StaticWidget {

        /// The widget's name.
        var name: String
        /// The function for adding a child.
        var add: String

    }

}
