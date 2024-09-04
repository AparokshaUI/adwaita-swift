//
//  NavigationView.swift
//  Adwaita
//
//  Created by auto-generation on 15.08.24.
//

import CAdw
import LevenshteinTransformations

/// A page-based navigation container.
/// 
/// <picture><source srcset="navigation-view-dark.png" media="(prefers-color-scheme: dark)"><img src="navigation-view.png" alt="navigation-view"></picture>
/// 
/// `AdwNavigationView` presents one child at a time, similar to
/// [class@Gtk.Stack].
/// 
/// `AdwNavigationView` can only contain [class@NavigationPage] children.
/// 
/// It maintains a navigation stack that can be controlled with
/// [method@NavigationView.push] and [method@NavigationView.pop]. The whole
/// navigation stack can also be replaced using [method@NavigationView.replace].
/// 
/// `AdwNavigationView` allows to manage pages statically or dynamically.
/// 
/// Static pages can be added using the [method@NavigationView.add] method. The
/// `AdwNavigationView` will keep a reference to these pages, but they aren't
/// accessible to the user until [method@NavigationView.push] is called (except
/// for the first page, which is pushed automatically). Use the
/// [method@NavigationView.remove] method to remove them. This is useful for
/// applications that have a small number of unique pages and just need
/// navigation between them.
/// 
/// Dynamic pages are automatically destroyed once they are popped off the
/// navigation stack. To add a page like this, push it using the
/// [method@NavigationView.push] method without calling
/// [method@NavigationView.add] first.
/// 
/// ## Tags
/// 
/// Static pages, as well as any pages in the navigation stack, can be accessed
/// by their [property@NavigationPage:tag]. For example,
/// [method@NavigationView.push_by_tag] can be used to push a static page that's
/// not in the navigation stack without having to keep a reference to it manually.
/// 
/// ## Header Bar Integration
/// 
/// When used inside `AdwNavigationView`, [class@HeaderBar] will automatically
/// display a back button that can be used to go back to the previous page when
/// possible. The button also has a context menu, allowing to pop multiple pages
/// at once, potentially across multiple navigation views.
/// 
/// Set [property@HeaderBar:show-back-button] to `FALSE` to disable this behavior
/// in rare scenarios where it's unwanted.
/// 
/// `AdwHeaderBar` will also display the title of the `AdwNavigationPage` it's
/// placed into, so most applications shouldn't need to customize it at all.
/// 
/// ## Shortcuts and Gestures
/// 
/// `AdwNavigationView` supports the following shortcuts for going to the
/// previous page:
/// 
/// - <kbd>Escape</kbd> (unless [property@NavigationView:pop-on-escape] is set to
/// `FALSE`)
/// - <kbd>Alt</kbd>+<kbd>←</kbd>
/// - Back mouse button
/// 
/// Additionally, it supports interactive gestures:
/// 
/// - One-finger swipe towards the right on touchscreens
/// - Scrolling towards the right on touchpads (usually two-finger swipe)
/// 
/// These gestures have transitions enabled regardless of the
/// [property@NavigationView:animate-transitions] value.
/// 
/// Applications can also enable shortcuts for pushing another page onto the
/// navigation stack via connecting to the [signal@NavigationView::get-next-page]
/// signal, in that case the following shortcuts are supported:
/// 
/// - <kbd>Alt</kbd>+<kbd>→</kbd>
/// - Forward mouse button
/// - Swipe/scrolling towards the left
/// 
/// For right-to-left locales, the gestures and shortcuts are reversed.
/// 
/// [property@NavigationPage:can-pop] can be used to disable them, along with the
/// header bar back buttons.
/// 
/// ## Actions
/// 
/// `AdwNavigationView` defines actions for controlling the navigation stack.
/// actions for controlling the navigation stack:
/// 
/// - `navigation.push` takes a string parameter specifying the tag of the page to
/// push, and is equivalent to calling [method@NavigationView.push_by_tag].
/// 
/// - `navigation.pop` doesn't take any parameters and pops the current page from
/// the navigation stack, equivalent to calling [method@NavigationView.pop].
/// 
/// ## `AdwNavigationView` as `GtkBuildable`
/// 
/// `AdwNavigationView` allows to add pages as children, equivalent to using the
/// [method@NavigationView.add] method.
/// 
/// Example of an `AdwNavigationView` UI definition:
/// 
/// ```xml
/// <object class="AdwNavigationView"><child><object class="AdwNavigationPage"><property name="title" translatable="yes">Page 1</property><property name="child"><object class="AdwToolbarView"><child type="top"><object class="AdwHeaderBar"/></child><property name="content"><object class="GtkButton"><property name="label" translatable="yes">Open Page 2</property><property name="halign">center</property><property name="valign">center</property><property name="action-name">navigation.push</property><property name="action-target">'page-2'</property><style><class name="pill"/></style></object></property></object></property></object></child><child><object class="AdwNavigationPage"><property name="title" translatable="yes">Page 2</property><property name="tag">page-2</property><property name="child"><object class="AdwToolbarView"><child type="top"><object class="AdwHeaderBar"/></child><property name="content"><!-- ... --></property></object></property></object></child></object>
/// ```
/// 
/// <picture><source srcset="navigation-view-example-dark.png" media="(prefers-color-scheme: dark)"><img src="navigation-view-example.png" alt="navigation-view-example"></picture>
/// 
/// ## CSS nodes
/// 
/// `AdwNavigationView` has a single CSS node with the name `navigation-view`.
/// 
/// ## Accessibility
/// 
/// `AdwNavigationView` uses the `GTK_ACCESSIBLE_ROLE_GROUP` role.
public struct NavigationView: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, WidgetData, Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, WidgetData) -> Void] = []

    /// Whether to animate page transitions.
    /// 
    /// Gesture-based transitions are always animated.
    var animateTransitions: Bool?
    /// Whether pressing Escape pops the current page.
    /// 
    /// Applications using `AdwNavigationView` to implement a browser may want to
    /// disable it.
    var popOnEscape: Bool?
    /// Emitted when a push shortcut or a gesture is triggered.
    /// 
    /// To support the push shortcuts and gestures, the application is expected to
    /// return the page to push in the handler.
    /// 
    /// This signal can be emitted multiple times for the gestures, for example
    /// when the gesture is cancelled by the user. As such, the application must
    /// not make any irreversible changes in the handler, such as removing the page
    /// from a forward stack.
    /// 
    /// Instead, it should be done in the [signal@NavigationView::pushed] handler.
    var getNextPage: (() -> Void)?
    /// Emitted after @page has been popped from the navigation stack.
    /// 
    /// See [method@NavigationView.pop].
    /// 
    /// When using [method@NavigationView.pop_to_page] or
    /// [method@NavigationView.pop_to_tag], this signal is emitted for each of the
    /// popped pages.
    var popped: (() -> Void)?
    /// Emitted after a page has been pushed to the navigation stack.
    /// 
    /// See [method@NavigationView.push].
    var pushed: (() -> Void)?
    /// Emitted after the navigation stack has been replaced.
    /// 
    /// See [method@NavigationView.replace].
    var replaced: (() -> Void)?

    /// Initialize `NavigationView`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The view render data type.
    /// - Returns: The view storage.
    public func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_navigation_view_new()?.opaque())
        for function in appearFunctions {
            function(storage, data)
        }
        update(storage, data: data, updateProperties: true, type: type)

        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The view render data type.
    public func update<Data>(_ storage: ViewStorage, data: WidgetData, updateProperties: Bool, type: Data.Type) where Data: ViewRenderData {
        if let getNextPage {
            storage.connectSignal(name: "get-next-page", argCount: 0) {
                getNextPage()
            }
        }
        if let popped {
            storage.connectSignal(name: "popped", argCount: 1) {
                popped()
            }
        }
        if let pushed {
            storage.connectSignal(name: "pushed", argCount: 0) {
                pushed()
            }
        }
        if let replaced {
            storage.connectSignal(name: "replaced", argCount: 0) {
                replaced()
            }
        }
        storage.modify { widget in

            if let animateTransitions, updateProperties, (storage.previousState as? Self)?.animateTransitions != animateTransitions {
                adw_navigation_view_set_animate_transitions(widget, animateTransitions.cBool)
            }
            if let popOnEscape, updateProperties, (storage.previousState as? Self)?.popOnEscape != popOnEscape {
                adw_navigation_view_set_pop_on_escape(widget, popOnEscape.cBool)
            }


        }
        for function in updateFunctions {
            function(storage, data, updateProperties)
        }
        if updateProperties {
            storage.previousState = self
        }
    }

    /// Whether to animate page transitions.
    /// 
    /// Gesture-based transitions are always animated.
    public func animateTransitions(_ animateTransitions: Bool? = true) -> Self {
        var newSelf = self
        newSelf.animateTransitions = animateTransitions
        
        return newSelf
    }

    /// Whether pressing Escape pops the current page.
    /// 
    /// Applications using `AdwNavigationView` to implement a browser may want to
    /// disable it.
    public func popOnEscape(_ popOnEscape: Bool? = true) -> Self {
        var newSelf = self
        newSelf.popOnEscape = popOnEscape
        
        return newSelf
    }

    /// Emitted when a push shortcut or a gesture is triggered.
    /// 
    /// To support the push shortcuts and gestures, the application is expected to
    /// return the page to push in the handler.
    /// 
    /// This signal can be emitted multiple times for the gestures, for example
    /// when the gesture is cancelled by the user. As such, the application must
    /// not make any irreversible changes in the handler, such as removing the page
    /// from a forward stack.
    /// 
    /// Instead, it should be done in the [signal@NavigationView::pushed] handler.
    public func getNextPage(_ getNextPage: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.getNextPage = getNextPage
        return newSelf
    }

    /// Emitted after @page has been popped from the navigation stack.
    /// 
    /// See [method@NavigationView.pop].
    /// 
    /// When using [method@NavigationView.pop_to_page] or
    /// [method@NavigationView.pop_to_tag], this signal is emitted for each of the
    /// popped pages.
    public func popped(_ popped: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.popped = popped
        return newSelf
    }

    /// Emitted after a page has been pushed to the navigation stack.
    /// 
    /// See [method@NavigationView.push].
    public func pushed(_ pushed: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.pushed = pushed
        return newSelf
    }

    /// Emitted after the navigation stack has been replaced.
    /// 
    /// See [method@NavigationView.replace].
    public func replaced(_ replaced: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.replaced = replaced
        return newSelf
    }

}
