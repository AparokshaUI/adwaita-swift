//
//  NavigationView+.swift
//  Adwaita
//
//  Created by david-swift on 17.02.24.
//

import CAdw

extension NavigationView {

    /// The ID for the component field in a content storage.
    static var componentID: String { "component" }

    /// Initialize a navigation view.
    /// - Parameters:
    ///   - stack: The navigation stack for pushing and popping.
    ///   - initialTitle: The title of the initial view.
    ///   - content: The view for a path component.
    ///   - initialView: The view that is displayed when the path is empty.
    public init<Component>(
        _ stack: Binding<NavigationStack<Component>>,
        _ initialTitle: String,
        @ViewBuilder content: @escaping (Component) -> Body,
        @ViewBuilder initialView: @escaping () -> Body
    ) {
        self.init()
        appearFunctions.append { storage, modifiers in
            let initialStorage = initialView().storage(modifiers: modifiers)
            storage.fields[.mainContent] = [initialStorage]
            adw_navigation_view_push(
                storage.pointer,
                adw_navigation_page_new(initialStorage.pointer?.cast(), initialTitle)
            )
            storage.connectSignal(name: "popped", id: "components", argCount: 1) { args in
                guard var storages = storage.fields[.mainContent] as? [ViewStorage],
                let arg = args.first as? UnsafeRawPointer else {
                    return
                }
                if storages.last?.pointer == adw_navigation_page_get_child(OpaquePointer(arg).cast())?.opaque() {
                    storages.removeLast()
                    storage.fields[.mainContent] = storages
                }
            }
        }
        updateFunctions.append { storage, modifiers, updateProperties in
            guard var storages = storage.fields[.mainContent] as? [ViewStorage] else {
                return
            }
            switch stack.wrappedValue.action {
            case .pop:
                if storages.count > 1 {
                    adw_navigation_view_pop(storage.pointer)
                    storages.removeLast()
                } else { print("Warning: removing the initial view is not allowed.") }
            case let .push(component):
                let contentStorage = content(component).storage(modifiers: modifiers)
                contentStorage.fields[Self.componentID] = component
                storages.append(contentStorage)
                adw_navigation_view_push(
                    storage.pointer,
                    adw_navigation_page_new(contentStorage.pointer?.cast(), component.description)
                )
            default:
                break
            }
            UpdateManager.blockUpdates = true; stack.wrappedValue.action = nil; UpdateManager.blockUpdates = false
            storage.fields[.mainContent] = storages
            for storage in storages {
                if let component = storage.fields[Self.componentID] as? Component {
                    content(component).updateStorage(storage, modifiers: modifiers, updateProperties: updateProperties)
                } else {
                    initialView().updateStorage(storage, modifiers: modifiers, updateProperties: updateProperties)
                }
            }
        }
    }

    /// A stack controls a navigation view.
    public struct NavigationStack<Component> where Component: CustomStringConvertible {

        /// The action to run at the next view update, if any.
        var action: Action<Component>?

        /// Initialize a navigation stack.
        public init() { }

        /// Remove the last item from the navigation view.
        public mutating func pop() {
            action = .pop
        }

        /// Add a new item to the navigation view.
        /// - Parameter component: The component's value.
        public mutating func push(_ component: Component) {
            action = .push(component: component)
        }

    }

    /// An action to run on a view update.
    enum Action<Component> {

        /// Remove the last item.
        case pop
        /// Add a new item.
        case push(component: Component)

    }

}

/// A stack controls a navigation view.
public typealias NavigationStack = NavigationView.NavigationStack
