//
//  Carousel.swift
//  Adwaita
//
//  Created by auto-generation on 15.08.24.
//

import CAdw
import LevenshteinTransformations

/// A paginated scrolling widget.
/// 
/// <picture><source srcset="carousel-dark.png" media="(prefers-color-scheme: dark)"><img src="carousel.png" alt="carousel"></picture>
/// 
/// The `AdwCarousel` widget can be used to display a set of pages with
/// swipe-based navigation between them.
/// 
/// [class@CarouselIndicatorDots] and [class@CarouselIndicatorLines] can be used
/// to provide page indicators for `AdwCarousel`.
/// 
/// ## CSS nodes
/// 
/// `AdwCarousel` has a single CSS node with name `carousel`.
public struct Carousel<Element>: AdwaitaWidget where Element: Identifiable {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, WidgetData, Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, WidgetData) -> Void] = []

    /// Whether to allow swiping for more than one page at a time.
    /// 
    /// If the value is `FALSE`, each swipe can only move to the adjacent pages.
    var allowLongSwipes: Bool?
    /// Sets whether the `AdwCarousel` can be dragged with mouse pointer.
    /// 
    /// If the value is `FALSE`, dragging is only available on touch.
    var allowMouseDrag: Bool?
    /// Whether the widget will respond to scroll wheel events.
    /// 
    /// If the value is `FALSE`, wheel events will be ignored.
    var allowScrollWheel: Bool?
    /// Whether the carousel can be navigated.
    /// 
    /// This can be used to temporarily disable the carousel to only allow
    /// navigating it in a certain state.
    var interactive: Bool?
    /// The number of pages in a `AdwCarousel`.
    var nPages: UInt?
    /// Page reveal duration, in milliseconds.
    /// 
    /// Reveal duration is used when animating adding or removing pages.
    var revealDuration: UInt?
    /// Spacing between pages in pixels.
    var spacing: UInt?
    /// This signal is emitted after a page has been changed.
    /// 
    /// It can be used to implement "infinite scrolling" by amending the pages
    /// after every scroll.
    /// 
    /// ::: note
    /// An empty carousel is indicated by `(int)index == -1`.
    var pageChanged: (() -> Void)?
    /// The dynamic widget elements.
    var elements: [Element]
    /// The dynamic widget content.
    var content: (Element) -> Body

    /// Initialize `Carousel`.
    public init(_ elements: [Element], @ViewBuilder content: @escaping (Element) -> Body) {
        self.elements = elements
        self.content = content
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The view render data type.
    /// - Returns: The view storage.
    public func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_carousel_new()?.opaque())
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
        if let pageChanged {
            storage.connectSignal(name: "page-changed", argCount: 1) {
                pageChanged()
            }
        }
        storage.modify { widget in

            if let allowLongSwipes, updateProperties, (storage.previousState as? Self)?.allowLongSwipes != allowLongSwipes {
                adw_carousel_set_allow_long_swipes(widget, allowLongSwipes.cBool)
            }
            if let allowMouseDrag, updateProperties, (storage.previousState as? Self)?.allowMouseDrag != allowMouseDrag {
                adw_carousel_set_allow_mouse_drag(widget, allowMouseDrag.cBool)
            }
            if let allowScrollWheel, updateProperties, (storage.previousState as? Self)?.allowScrollWheel != allowScrollWheel {
                adw_carousel_set_allow_scroll_wheel(widget, allowScrollWheel.cBool)
            }
            if let interactive, updateProperties, (storage.previousState as? Self)?.interactive != interactive {
                adw_carousel_set_interactive(widget, interactive.cBool)
            }
            if let revealDuration, updateProperties, (storage.previousState as? Self)?.revealDuration != revealDuration {
                adw_carousel_set_reveal_duration(widget, revealDuration.cInt)
            }
            if let spacing, updateProperties, (storage.previousState as? Self)?.spacing != spacing {
                adw_carousel_set_spacing(widget, spacing.cInt)
            }

            var contentStorage: [ViewStorage] = storage.content[.mainContent] ?? []
            let old = storage.fields["element"] as? [Element] ?? []
            old.identifiableTransform(
                to: elements,
                functions: .init { index, element in
                    let child = content(element).storage(data: data, type: type)
                    adw_carousel_remove(widget, adw_carousel_get_nth_page(widget, UInt(index).cInt))
                    adw_carousel_insert(widget, child.opaquePointer?.cast(), index.cInt)
                    contentStorage.remove(at: index)
                    contentStorage.insert(child, at: index)
                } delete: { index in
                    adw_carousel_remove(widget, adw_carousel_get_nth_page(widget, UInt(index).cInt))
                    contentStorage.remove(at: index)
                } insert: { index, element in
                    let child = content(element).storage(data: data, type: type)
                    adw_carousel_insert(widget, child.opaquePointer?.cast(), index.cInt)
                    contentStorage.insert(child, at: index)
                }
            )
            storage.fields["element"] = elements
            storage.content[.mainContent] = contentStorage
            for (index, element) in elements.enumerated() {
                content(element).updateStorage(contentStorage[index], data: data, updateProperties: updateProperties, type: type)
            }
        }
        for function in updateFunctions {
            function(storage, data, updateProperties)
        }
        if updateProperties {
            storage.previousState = self
        }
    }

    /// Whether to allow swiping for more than one page at a time.
    /// 
    /// If the value is `FALSE`, each swipe can only move to the adjacent pages.
    public func allowLongSwipes(_ allowLongSwipes: Bool? = true) -> Self {
        var newSelf = self
        newSelf.allowLongSwipes = allowLongSwipes
        
        return newSelf
    }

    /// Sets whether the `AdwCarousel` can be dragged with mouse pointer.
    /// 
    /// If the value is `FALSE`, dragging is only available on touch.
    public func allowMouseDrag(_ allowMouseDrag: Bool? = true) -> Self {
        var newSelf = self
        newSelf.allowMouseDrag = allowMouseDrag
        
        return newSelf
    }

    /// Whether the widget will respond to scroll wheel events.
    /// 
    /// If the value is `FALSE`, wheel events will be ignored.
    public func allowScrollWheel(_ allowScrollWheel: Bool? = true) -> Self {
        var newSelf = self
        newSelf.allowScrollWheel = allowScrollWheel
        
        return newSelf
    }

    /// Whether the carousel can be navigated.
    /// 
    /// This can be used to temporarily disable the carousel to only allow
    /// navigating it in a certain state.
    public func interactive(_ interactive: Bool? = true) -> Self {
        var newSelf = self
        newSelf.interactive = interactive
        
        return newSelf
    }

    /// The number of pages in a `AdwCarousel`.
    public func nPages(_ nPages: UInt?) -> Self {
        var newSelf = self
        newSelf.nPages = nPages
        
        return newSelf
    }

    /// Page reveal duration, in milliseconds.
    /// 
    /// Reveal duration is used when animating adding or removing pages.
    public func revealDuration(_ revealDuration: UInt?) -> Self {
        var newSelf = self
        newSelf.revealDuration = revealDuration
        
        return newSelf
    }

    /// Spacing between pages in pixels.
    public func spacing(_ spacing: UInt?) -> Self {
        var newSelf = self
        newSelf.spacing = spacing
        
        return newSelf
    }

    /// This signal is emitted after a page has been changed.
    /// 
    /// It can be used to implement "infinite scrolling" by amending the pages
    /// after every scroll.
    /// 
    /// ::: note
    /// An empty carousel is indicated by `(int)index == -1`.
    public func pageChanged(_ pageChanged: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.pageChanged = pageChanged
        return newSelf
    }

}
