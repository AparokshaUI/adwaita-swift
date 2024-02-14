//
//  Label.swift
//  Adwaita
//
//  Created by auto-generation on 14.02.24.
//

import CAdw
import LevenshteinTransformations

/// The `GtkLabel` widget displays a small amount of text.
/// 
/// As the name implies, most labels are used to label another widget
/// such as a [class@Button].
/// 
/// ![An example GtkLabel](label.png)
/// 
/// # CSS nodes
/// 
/// ```
/// label
/// ├── [selection]
/// ├── [link]
/// ┊
/// ╰── [link]
/// ```
/// 
/// `GtkLabel` has a single CSS node with the name label. A wide variety
/// of style classes may be applied to labels, such as .title, .subtitle,
/// .dim-label, etc. In the `GtkShortcutsWindow`, labels are used with the
/// .keycap style class.
/// 
/// If the label has a selection, it gets a subnode with name selection.
/// 
/// If the label has links, there is one subnode per link. These subnodes
/// carry the link or visited state depending on whether they have been
/// visited. In this case, label node also gets a .link style class.
/// 
/// # GtkLabel as GtkBuildable
/// 
/// The GtkLabel implementation of the GtkBuildable interface supports a
/// custom `<attributes>` element, which supports any number of `<attribute>`
/// elements. The <attribute> element has attributes named “name“, “value“,
/// “start“ and “end“ and allows you to specify [struct@Pango.Attribute]
/// values for this label.
/// 
/// An example of a UI definition fragment specifying Pango attributes:
/// ```xml
/// <object class="GtkLabel"><attributes><attribute name="weight" value="PANGO_WEIGHT_BOLD"/><attribute name="background" value="red" start="5" end="10"/></attributes></object>
/// ```
/// 
/// The start and end attributes specify the range of characters to which the
/// Pango attribute applies. If start and end are not specified, the attribute is
/// applied to the whole text. Note that specifying ranges does not make much
/// sense with translatable attributes. Use markup embedded in the translatable
/// content instead.
/// 
/// # Accessibility
/// 
/// `GtkLabel` uses the %GTK_ACCESSIBLE_ROLE_LABEL role.
/// 
/// # Mnemonics
/// 
/// Labels may contain “mnemonics”. Mnemonics are underlined characters in the
/// label, used for keyboard navigation. Mnemonics are created by providing a
/// string with an underscore before the mnemonic character, such as `"_File"`,
/// to the functions [ctor@Gtk.Label.new_with_mnemonic] or
/// [method@Gtk.Label.set_text_with_mnemonic].
/// 
/// Mnemonics automatically activate any activatable widget the label is
/// inside, such as a [class@Gtk.Button]; if the label is not inside the
/// mnemonic’s target widget, you have to tell the label about the target
/// using [class@Gtk.Label.set_mnemonic_widget]. Here’s a simple example where
/// the label is inside a button:
/// 
/// ```c
/// // Pressing Alt+H will activate this button
/// GtkWidget *button = gtk_button_new ();
/// GtkWidget *label = gtk_label_new_with_mnemonic ("_Hello");
/// gtk_button_set_child (GTK_BUTTON (button), label);
/// ```
/// 
/// There’s a convenience function to create buttons with a mnemonic label
/// already inside:
/// 
/// ```c
/// // Pressing Alt+H will activate this button
/// GtkWidget *button = gtk_button_new_with_mnemonic ("_Hello");
/// ```
/// 
/// To create a mnemonic for a widget alongside the label, such as a
/// [class@Gtk.Entry], you have to point the label at the entry with
/// [method@Gtk.Label.set_mnemonic_widget]:
/// 
/// ```c
/// // Pressing Alt+H will focus the entry
/// GtkWidget *entry = gtk_entry_new ();
/// GtkWidget *label = gtk_label_new_with_mnemonic ("_Hello");
/// gtk_label_set_mnemonic_widget (GTK_LABEL (label), entry);
/// ```
/// 
/// # Markup (styled text)
/// 
/// To make it easy to format text in a label (changing colors,
/// fonts, etc.), label text can be provided in a simple
/// markup format:
/// 
/// Here’s how to create a label with a small font:
/// ```c
/// GtkWidget *label = gtk_label_new (NULL);
/// gtk_label_set_markup (GTK_LABEL (label), "<small>Small text</small>");
/// ```
/// 
/// (See the Pango manual for complete documentation] of available
/// tags, [func@Pango.parse_markup])
/// 
/// The markup passed to [method@Gtk.Label.set_markup] must be valid; for example,
/// literal `<`, `>` and `&` characters must be escaped as `&lt;`, `&gt;`, and `&amp;`.
/// If you pass text obtained from the user, file, or a network to
/// [method@Gtk.Label.set_markup], you’ll want to escape it with
/// [func@GLib.markup_escape_text] or [func@GLib.markup_printf_escaped].
/// 
/// Markup strings are just a convenient way to set the [struct@Pango.AttrList]
/// on a label; [method@Gtk.Label.set_attributes] may be a simpler way to set
/// attributes in some cases. Be careful though; [struct@Pango.AttrList] tends
/// to cause internationalization problems, unless you’re applying attributes
/// to the entire string (i.e. unless you set the range of each attribute
/// to [0, %G_MAXINT)). The reason is that specifying the start_index and
/// end_index for a [struct@Pango.Attribute] requires knowledge of the exact
/// string being displayed, so translations will cause problems.
/// 
/// # Selectable labels
/// 
/// Labels can be made selectable with [method@Gtk.Label.set_selectable].
/// Selectable labels allow the user to copy the label contents to
/// the clipboard. Only labels that contain useful-to-copy information
/// — such as error messages — should be made selectable.
/// 
/// # Text layout
/// 
/// A label can contain any number of paragraphs, but will have
/// performance problems if it contains more than a small number.
/// Paragraphs are separated by newlines or other paragraph separators
/// understood by Pango.
/// 
/// Labels can automatically wrap text if you call [method@Gtk.Label.set_wrap].
/// 
/// [method@Gtk.Label.set_justify] sets how the lines in a label align
/// with one another. If you want to set how the label as a whole aligns
/// in its available space, see the [property@Gtk.Widget:halign] and
/// [property@Gtk.Widget:valign] properties.
/// 
/// The [property@Gtk.Label:width-chars] and [property@Gtk.Label:max-width-chars]
/// properties can be used to control the size allocation of ellipsized or
/// wrapped labels. For ellipsizing labels, if either is specified (and less
/// than the actual text size), it is used as the minimum width, and the actual
/// text size is used as the natural width of the label. For wrapping labels,
/// width-chars is used as the minimum width, if specified, and max-width-chars
/// is used as the natural width. Even if max-width-chars specified, wrapping
/// labels will be rewrapped to use all of the available width.
/// 
/// # Links
/// 
/// GTK supports markup for clickable hyperlinks in addition to regular Pango
/// markup. The markup for links is borrowed from HTML, using the `<a>` with
/// “href“, “title“ and “class“ attributes. GTK renders links similar to the
/// way they appear in web browsers, with colored, underlined text. The “title“
/// attribute is displayed as a tooltip on the link. The “class“ attribute is
/// used as style class on the CSS node for the link.
/// 
/// An example looks like this:
/// 
/// ```c
/// const char *text =
/// "Go to the "
/// "<a href=\"https://www.gtk.org\" title=\"&lt;i&gt;Our&lt;/i&gt; website\">"
/// "GTK website</a> for more...";
/// GtkWidget *label = gtk_label_new (NULL);
/// gtk_label_set_markup (GTK_LABEL (label), text);
/// ```
/// 
/// It is possible to implement custom handling for links and their tooltips
/// with the [signal@Gtk.Label::activate-link] signal and the
/// [method@Gtk.Label.get_current_uri] function.
public struct Label: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage) -> Void] = []

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    var accessibleRole: String?
    /// The contents of the label.
    /// 
    /// If the string contains Pango markup (see [func@Pango.parse_markup]),
    /// you will have to set the [property@Gtk.Label:use-markup] property to
    /// %TRUE in order for the label to display the markup attributes. See also
    /// [method@Gtk.Label.set_markup] for a convenience function that sets both
    /// this property and the [property@Gtk.Label:use-markup] property at the
    /// same time.
    /// 
    /// If the string contains underlines acting as mnemonics, you will have to
    /// set the [property@Gtk.Label:use-underline] property to %TRUE in order
    /// for the label to display them.
    var label: String
    /// The number of lines to which an ellipsized, wrapping label
    /// should be limited.
    /// 
    /// This property has no effect if the label is not wrapping or ellipsized.
    /// Set this property to -1 if you don't want to limit the number of lines.
    var lines: Int?
    /// The desired maximum width of the label, in characters.
    /// 
    /// If this property is set to -1, the width will be calculated automatically.
    /// 
    /// See the section on [text layout](class.Label.html#text-layout) for details of how
    /// [property@Gtk.Label:width-chars] and [property@Gtk.Label:max-width-chars]
    /// determine the width of ellipsized and wrapped labels.
    var maxWidthChars: Int?
    /// The mnemonic accelerator key for the label.
    var mnemonicKeyval: UInt?
    /// The widget to be activated when the labels mnemonic key is pressed.
    var mnemonicWidget:  (() -> Body)?
    /// Whether the label text can be selected with the mouse.
    var selectable: Bool?
    /// Whether the label is in single line mode.
    /// 
    /// In single line mode, the height of the label does not depend on the
    /// actual text, it is always set to ascent + descent of the font. This
    /// can be an advantage in situations where resizing the label because
    /// of text changes would be distracting, e.g. in a statusbar.
    var singleLineMode: Bool?
    /// %TRUE if the text of the label includes Pango markup.
    /// 
    /// See [func@Pango.parse_markup].
    var useMarkup: Bool?
    /// %TRUE if the text of the label indicates a mnemonic with an _
    /// before the mnemonic character.
    var useUnderline: Bool?
    /// The desired width of the label, in characters.
    /// 
    /// If this property is set to -1, the width will be calculated automatically.
    /// 
    /// See the section on [text layout](class.Label.html#text-layout) for details of how
    /// [property@Gtk.Label:width-chars] and [property@Gtk.Label:max-width-chars]
    /// determine the width of ellipsized and wrapped labels.
    var widthChars: Int?
    /// %TRUE if the label text will wrap if it gets too wide.
    var wrap: Bool?
    /// The horizontal alignment of the label text inside its size allocation.
    /// 
    /// Compare this to [property@Gtk.Widget:halign], which determines how the
    /// labels size allocation is positioned in the space available for the label.
    var xalign: Float?
    /// The vertical alignment of the label text inside its size allocation.
    /// 
    /// Compare this to [property@Gtk.Widget:valign], which determines how the
    /// labels size allocation is positioned in the space available for the label.
    var yalign: Float?
    /// Gets emitted to copy the selection to the clipboard.
    /// 
    /// The ::copy-clipboard signal is a [keybinding signal](class.SignalAction.html).
    /// 
    /// The default binding for this signal is <kbd>Ctrl</kbd>+<kbd>c</kbd>.
    var copyClipboard: (() -> Void)?
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `Label`.
    public init(label: String) {
        self.label = label
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(gtk_label_new(label)?.opaque())
        update(storage, modifiers: modifiers, updateProperties: true)
        if let mnemonicWidgetStorage = mnemonicWidget?().widget(modifiers: modifiers).storage(modifiers: modifiers) {
            storage.content["mnemonicWidget"] = [mnemonicWidgetStorage]
            gtk_label_set_mnemonic_widget(storage.pointer, mnemonicWidgetStorage.pointer?.cast())
        }

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
        if let copyClipboard {
            storage.connectSignal(name: "copy-clipboard", argCount: 0) {
                copyClipboard()
            }
        }
        storage.modify { widget in

            if updateProperties {
                gtk_label_set_label(widget, label)
            }
            if let lines, updateProperties {
                gtk_label_set_lines(widget, lines.cInt)
            }
            if let maxWidthChars, updateProperties {
                gtk_label_set_max_width_chars(widget, maxWidthChars.cInt)
            }
            if let widget = storage.content["mnemonicWidget"]?.first {
                mnemonicWidget?().widget(modifiers: modifiers).update(widget, modifiers: modifiers, updateProperties: updateProperties)
            }
            if let selectable, updateProperties {
                gtk_label_set_selectable(widget, selectable.cBool)
            }
            if let singleLineMode, updateProperties {
                gtk_label_set_single_line_mode(widget, singleLineMode.cBool)
            }
            if let useMarkup, updateProperties {
                gtk_label_set_use_markup(widget, useMarkup.cBool)
            }
            if let useUnderline, updateProperties {
                gtk_label_set_use_underline(widget, useUnderline.cBool)
            }
            if let widthChars, updateProperties {
                gtk_label_set_width_chars(widget, widthChars.cInt)
            }
            if let wrap, updateProperties {
                gtk_label_set_wrap(widget, wrap.cBool)
            }
            if let xalign, updateProperties {
                gtk_label_set_xalign(widget, xalign)
            }
            if let yalign, updateProperties {
                gtk_label_set_yalign(widget, yalign)
            }


        }
        for function in updateFunctions {
            function(storage)
        }
    }

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    public func accessibleRole(_ accessibleRole: String?) -> Self {
        var newSelf = self
        newSelf.accessibleRole = accessibleRole
        
        return newSelf
    }

    /// The contents of the label.
    /// 
    /// If the string contains Pango markup (see [func@Pango.parse_markup]),
    /// you will have to set the [property@Gtk.Label:use-markup] property to
    /// %TRUE in order for the label to display the markup attributes. See also
    /// [method@Gtk.Label.set_markup] for a convenience function that sets both
    /// this property and the [property@Gtk.Label:use-markup] property at the
    /// same time.
    /// 
    /// If the string contains underlines acting as mnemonics, you will have to
    /// set the [property@Gtk.Label:use-underline] property to %TRUE in order
    /// for the label to display them.
    public func label(_ label: String) -> Self {
        var newSelf = self
        newSelf.label = label
        
        return newSelf
    }

    /// The number of lines to which an ellipsized, wrapping label
    /// should be limited.
    /// 
    /// This property has no effect if the label is not wrapping or ellipsized.
    /// Set this property to -1 if you don't want to limit the number of lines.
    public func lines(_ lines: Int?) -> Self {
        var newSelf = self
        newSelf.lines = lines
        
        return newSelf
    }

    /// The desired maximum width of the label, in characters.
    /// 
    /// If this property is set to -1, the width will be calculated automatically.
    /// 
    /// See the section on [text layout](class.Label.html#text-layout) for details of how
    /// [property@Gtk.Label:width-chars] and [property@Gtk.Label:max-width-chars]
    /// determine the width of ellipsized and wrapped labels.
    public func maxWidthChars(_ maxWidthChars: Int?) -> Self {
        var newSelf = self
        newSelf.maxWidthChars = maxWidthChars
        
        return newSelf
    }

    /// The mnemonic accelerator key for the label.
    public func mnemonicKeyval(_ mnemonicKeyval: UInt?) -> Self {
        var newSelf = self
        newSelf.mnemonicKeyval = mnemonicKeyval
        
        return newSelf
    }

    /// The widget to be activated when the labels mnemonic key is pressed.
    public func mnemonicWidget(@ViewBuilder _ mnemonicWidget: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.mnemonicWidget = mnemonicWidget
        
        return newSelf
    }

    /// Whether the label text can be selected with the mouse.
    public func selectable(_ selectable: Bool? = true) -> Self {
        var newSelf = self
        newSelf.selectable = selectable
        
        return newSelf
    }

    /// Whether the label is in single line mode.
    /// 
    /// In single line mode, the height of the label does not depend on the
    /// actual text, it is always set to ascent + descent of the font. This
    /// can be an advantage in situations where resizing the label because
    /// of text changes would be distracting, e.g. in a statusbar.
    public func singleLineMode(_ singleLineMode: Bool? = true) -> Self {
        var newSelf = self
        newSelf.singleLineMode = singleLineMode
        
        return newSelf
    }

    /// %TRUE if the text of the label includes Pango markup.
    /// 
    /// See [func@Pango.parse_markup].
    public func useMarkup(_ useMarkup: Bool? = true) -> Self {
        var newSelf = self
        newSelf.useMarkup = useMarkup
        
        return newSelf
    }

    /// %TRUE if the text of the label indicates a mnemonic with an _
    /// before the mnemonic character.
    public func useUnderline(_ useUnderline: Bool? = true) -> Self {
        var newSelf = self
        newSelf.useUnderline = useUnderline
        
        return newSelf
    }

    /// The desired width of the label, in characters.
    /// 
    /// If this property is set to -1, the width will be calculated automatically.
    /// 
    /// See the section on [text layout](class.Label.html#text-layout) for details of how
    /// [property@Gtk.Label:width-chars] and [property@Gtk.Label:max-width-chars]
    /// determine the width of ellipsized and wrapped labels.
    public func widthChars(_ widthChars: Int?) -> Self {
        var newSelf = self
        newSelf.widthChars = widthChars
        
        return newSelf
    }

    /// %TRUE if the label text will wrap if it gets too wide.
    public func wrap(_ wrap: Bool? = true) -> Self {
        var newSelf = self
        newSelf.wrap = wrap
        
        return newSelf
    }

    /// The horizontal alignment of the label text inside its size allocation.
    /// 
    /// Compare this to [property@Gtk.Widget:halign], which determines how the
    /// labels size allocation is positioned in the space available for the label.
    public func xalign(_ xalign: Float?) -> Self {
        var newSelf = self
        newSelf.xalign = xalign
        
        return newSelf
    }

    /// The vertical alignment of the label text inside its size allocation.
    /// 
    /// Compare this to [property@Gtk.Widget:valign], which determines how the
    /// labels size allocation is positioned in the space available for the label.
    public func yalign(_ yalign: Float?) -> Self {
        var newSelf = self
        newSelf.yalign = yalign
        
        return newSelf
    }

    /// Gets emitted to copy the selection to the clipboard.
    /// 
    /// The ::copy-clipboard signal is a [keybinding signal](class.SignalAction.html).
    /// 
    /// The default binding for this signal is <kbd>Ctrl</kbd>+<kbd>c</kbd>.
    public func copyClipboard(_ copyClipboard: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.copyClipboard = copyClipboard
        return newSelf
    }

}
