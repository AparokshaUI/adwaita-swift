**STRUCT**

# `Popover`

`GtkPopover` is a bubble-like context popup.

![An example GtkPopover](popover.png)

It is primarily meant to provide context-dependent information
or options. Popovers are attached to a parent widget. By default,
they point to the whole widget area, although this behavior can be
changed with [method@Gtk.Popover.set_pointing_to].

The position of a popover relative to the widget it is attached to
can also be changed with [method@Gtk.Popover.set_position]

By default, `GtkPopover` performs a grab, in order to ensure input
events get redirected to it while it is shown, and also so the popover
is dismissed in the expected situations (clicks outside the popover,
or the Escape key being pressed). If no such modal behavior is desired
on a popover, [method@Gtk.Popover.set_autohide] may be called on it to
tweak its behavior.

## GtkPopover as menu replacement

`GtkPopover` is often used to replace menus. The best was to do this
is to use the [class@Gtk.PopoverMenu] subclass which supports being
populated from a `GMenuModel` with [ctor@Gtk.PopoverMenu.new_from_model].

```xml
<section><attribute name="display-hint">horizontal-buttons</attribute><item><attribute name="label">Cut</attribute><attribute name="action">app.cut</attribute><attribute name="verb-icon">edit-cut-symbolic</attribute></item><item><attribute name="label">Copy</attribute><attribute name="action">app.copy</attribute><attribute name="verb-icon">edit-copy-symbolic</attribute></item><item><attribute name="label">Paste</attribute><attribute name="action">app.paste</attribute><attribute name="verb-icon">edit-paste-symbolic</attribute></item></section>
```

# CSS nodes

```
popover.background[.menu]
├── arrow
╰── contents
╰── <child>
```

`GtkPopover` has a main node with name `popover`, an arrow with name `arrow`,
and another node for the content named `contents`. The `popover` node always
gets the `.background` style class. It also gets the `.menu` style class
if the popover is menu-like, e.g. is a [class@Gtk.PopoverMenu].

Particular uses of `GtkPopover`, such as touch selection popups or
magnifiers in `GtkEntry` or `GtkTextView` get style classes like
`.touch-selection` or `.magnifier` to differentiate from plain popovers.

When styling a popover directly, the `popover` node should usually
not have any background. The visible part of the popover can have
a shadow. To specify it in CSS, set the box-shadow of the `contents` node.

Note that, in order to accomplish appropriate arrow visuals, `GtkPopover`
uses custom drawing for the `arrow` node. This makes it possible for the
arrow to change its shape dynamically, but it also limits the possibilities
of styling it using CSS. In particular, the `arrow` gets drawn over the
`content` node's border and shadow, so they look like one shape, which
means that the border width of the `content` node and the `arrow` node should
be the same. The arrow also does not support any border shape other than
solid, no border-radius, only one border width (border-bottom-width is
used) and no box-shadow.

## Properties
### `updateFunctions`

Additional update functions for type extensions.

### `appearFunctions`

Additional appear functions for type extensions.

### `accessibleRole`

The accessible role of the given `GtkAccessible` implementation.

The accessible role cannot be changed once set.

### `autohide`

Whether to dismiss the popover on outside clicks.

### `cascadePopdown`

Whether the popover pops down after a child popover.

This is used to implement the expected behavior of submenus.

### `child`

The child widget.

### `defaultWidget`

The default widget inside the popover.

### `hasArrow`

Whether to draw an arrow.

### `mnemonicsVisible`

Whether mnemonics are currently visible in this popover.

### `activateDefault`

Emitted whend the user activates the default widget.

This is a [keybinding signal](class.SignalAction.html).

### `closed`

Emitted when the popover is closed.

### `app`

The application.

### `window`

The window.

## Methods
### `init()`

Initialize `Popover`.

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

### `accessibleRole(_:)`

The accessible role of the given `GtkAccessible` implementation.

The accessible role cannot be changed once set.

### `autohide(_:)`

Whether to dismiss the popover on outside clicks.

### `cascadePopdown(_:)`

Whether the popover pops down after a child popover.

This is used to implement the expected behavior of submenus.

### `child(_:)`

The child widget.

### `defaultWidget(_:)`

The default widget inside the popover.

### `hasArrow(_:)`

Whether to draw an arrow.

### `mnemonicsVisible(_:)`

Whether mnemonics are currently visible in this popover.

### `activateDefault(_:)`

Emitted whend the user activates the default widget.

This is a [keybinding signal](class.SignalAction.html).

### `closed(_:)`

Emitted when the popover is closed.
