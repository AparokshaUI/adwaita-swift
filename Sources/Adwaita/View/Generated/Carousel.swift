//
//  Carousel.swift
//  Adwaita
//
//  Created by auto-generation on 10.02.24.
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
public struct Carousel<Element>: Widget where Element: Identifiable {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage) -> Void] = []

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
    /// after every scroll. Note that an empty carousel is indicated by
    /// `(int)index == -1`.
    var pageChanged: (() -> Void)?
    /// The dynamic widget elements.
    var elements: [Element]
    /// The dynamic widget content.
    var content: (Element) -> Body
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `Carousel`.
    public init(_ elements: [Element], @ViewBuilder content: @escaping (Element) -> Body) {
        self.elements = elements
        self.content = content
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(adw_carousel_new()?.opaque())
        update(storage, modifiers: modifiers, updateProperties: true)


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
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
        if let pageChanged {
            storage.connectSignal(name: "page-changed", argCount: 1) {
                pageChanged()
            }
        }
        storage.modify { widget in
            if let allowLongSwipes, updateProperties {
                adw_carousel_set_allow_long_swipes(widget, allowLongSwipes.cBool)
            }
            if let allowMouseDrag, updateProperties {
                adw_carousel_set_allow_mouse_drag(widget, allowMouseDrag.cBool)
            }
            if let allowScrollWheel, updateProperties {
                adw_carousel_set_allow_scroll_wheel(widget, allowScrollWheel.cBool)
            }
            if let interactive, updateProperties {
                adw_carousel_set_interactive(widget, interactive.cBool)
            }
            if let revealDuration, updateProperties {
                adw_carousel_set_reveal_duration(widget, revealDuration.cInt)
            }
            if let spacing, updateProperties {
                adw_carousel_set_spacing(widget, spacing.cInt)
            }

            var contentStorage: [ViewStorage] = storage.content[.mainContent] ?? []
            let old = storage.fields["element"] as? [Element] ?? []
            old.identifiableTransform(
                to: elements,
                functions: .init { index, element in
                    let child = content(element).widget(modifiers: modifiers).container(modifiers: modifiers)
                    adw_carousel_remove(widget, adw_carousel_get_nth_page(widget, UInt(index).cInt))
                    adw_carousel_insert(widget, child.pointer?.cast(), index.cInt)
                    contentStorage.remove(at: index)
                    contentStorage.insert(child, at: index)
                } delete: { index in
                    adw_carousel_remove(widget, adw_carousel_get_nth_page(widget, UInt(index).cInt))
                    contentStorage.remove(at: index)
                } insert: { index, element in
                    let child = content(element).widget(modifiers: modifiers).container(modifiers: modifiers)
                    adw_carousel_insert(widget, child.pointer?.cast(), index.cInt)
                    contentStorage.insert(child, at: index)
                }
            )
            storage.fields["element"] = elements
            storage.content[.mainContent] = contentStorage
            for (index, element) in elements.enumerated() {
                content(element).widget(modifiers: modifiers).update(contentStorage[index], modifiers: modifiers, updateProperties: updateProperties)
            }
        }
        for function in updateFunctions {
            function(storage)
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
    /// after every scroll. Note that an empty carousel is indicated by
    /// `(int)index == -1`.
    public func pageChanged(_ pageChanged: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.pageChanged = pageChanged
        return newSelf
    }

}
