**STRUCT**

# `Carousel`

A paginated scrolling widget.

<picture><source srcset="carousel-dark.png" media="(prefers-color-scheme: dark)"><img src="carousel.png" alt="carousel"></picture>

The `AdwCarousel` widget can be used to display a set of pages with
swipe-based navigation between them.

[class@CarouselIndicatorDots] and [class@CarouselIndicatorLines] can be used
to provide page indicators for `AdwCarousel`.

## CSS nodes

`AdwCarousel` has a single CSS node with name `carousel`.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `allowLongSwipes`

Whether to allow swiping for more than one page at a time.

If the value is `FALSE`, each swipe can only move to the adjacent pages.

### `allowMouseDrag`

Sets whether the `AdwCarousel` can be dragged with mouse pointer.

If the value is `FALSE`, dragging is only available on touch.

### `allowScrollWheel`

Whether the widget will respond to scroll wheel events.

If the value is `FALSE`, wheel events will be ignored.

### `interactive`

Whether the carousel can be navigated.

This can be used to temporarily disable the carousel to only allow
navigating it in a certain state.

### `nPages`

The number of pages in a `AdwCarousel`.

### `revealDuration`

Page reveal duration, in milliseconds.

Reveal duration is used when animating adding or removing pages.

### `spacing`

Spacing between pages in pixels.

### `pageChanged`

This signal is emitted after a page has been changed.

It can be used to implement "infinite scrolling" by amending the pages
after every scroll. Note that an empty carousel is indicated by
`(int)index == -1`.

### `elements`

The dynamic widget elements.

### `content`

The dynamic widget content.

### `app`

The application.

### `window`

The window.

## Methods
### `init(_:content:)`

Initialize `Carousel`.

### `container(modifiers:)`

Get the widget's view storage.
- Parameter modifiers: The view modifiers.
- Returns: The view storage.

### `update(_:modifiers:updateProperties:)`

Update the widget's view storage.
- Parameters:
    - storage: The view storage.
    - modifiers: The view modifiers.
    - updateProperties: Whether to update the view's properties.

### `allowLongSwipes(_:)`

Whether to allow swiping for more than one page at a time.

If the value is `FALSE`, each swipe can only move to the adjacent pages.

### `allowMouseDrag(_:)`

Sets whether the `AdwCarousel` can be dragged with mouse pointer.

If the value is `FALSE`, dragging is only available on touch.

### `allowScrollWheel(_:)`

Whether the widget will respond to scroll wheel events.

If the value is `FALSE`, wheel events will be ignored.

### `interactive(_:)`

Whether the carousel can be navigated.

This can be used to temporarily disable the carousel to only allow
navigating it in a certain state.

### `nPages(_:)`

The number of pages in a `AdwCarousel`.

### `revealDuration(_:)`

Page reveal duration, in milliseconds.

Reveal duration is used when animating adding or removing pages.

### `spacing(_:)`

Spacing between pages in pixels.

### `pageChanged(_:)`

This signal is emitted after a page has been changed.

It can be used to implement "infinite scrolling" by amending the pages
after every scroll. Note that an empty carousel is indicated by
`(int)index == -1`.
