//
//  ToggleButton.swift
//  Adwaita
//
//  Created by auto-generation on 14.02.24.
//

import CAdw
import LevenshteinTransformations

/// A `GtkToggleButton` is a button which remains “pressed-in” when
/// clicked.
/// 
/// Clicking again will cause the toggle button to return to its normal state.
/// 
/// A toggle button is created by calling either [ctor@Gtk.ToggleButton.new] or
/// [ctor@Gtk.ToggleButton.new_with_label]. If using the former, it is advisable
/// to pack a widget, (such as a `GtkLabel` and/or a `GtkImage`), into the toggle
/// button’s container. (See [class@Gtk.Button] for more information).
/// 
/// The state of a `GtkToggleButton` can be set specifically using
/// [method@Gtk.ToggleButton.set_active], and retrieved using
/// [method@Gtk.ToggleButton.get_active].
/// 
/// To simply switch the state of a toggle button, use
/// [method@Gtk.ToggleButton.toggled].
/// 
/// ## Grouping
/// 
/// Toggle buttons can be grouped together, to form mutually exclusive
/// groups - only one of the buttons can be toggled at a time, and toggling
/// another one will switch the currently toggled one off.
/// 
/// To add a `GtkToggleButton` to a group, use [method@Gtk.ToggleButton.set_group].
/// 
/// ## CSS nodes
/// 
/// `GtkToggleButton` has a single CSS node with name button. To differentiate
/// it from a plain `GtkButton`, it gets the `.toggle` style class.
/// 
/// ## Accessibility
/// 
/// `GtkToggleButton` uses the %GTK_ACCESSIBLE_ROLE_TOGGLE_BUTTON role.
/// 
/// ## Creating two `GtkToggleButton` widgets.
/// 
/// ```c
/// static void
/// output_state (GtkToggleButton *source,
/// gpointer         user_data)
/// {
/// g_print ("Toggle button "%s" is active: %s",
/// gtk_button_get_label (GTK_BUTTON (source)),
/// gtk_toggle_button_get_active (source) ? "Yes" : "No");
/// }
/// 
/// static void
/// make_toggles (void)
/// {
/// GtkWidget *window, *toggle1, *toggle2;
/// GtkWidget *box;
/// const char *text;
/// 
/// window = gtk_window_new ();
/// box = gtk_box_new (GTK_ORIENTATION_VERTICAL, 12);
/// 
/// text = "Hi, I’m toggle button one";
/// toggle1 = gtk_toggle_button_new_with_label (text);
/// 
/// g_signal_connect (toggle1, "toggled",
/// G_CALLBACK (output_state),
/// NULL);
/// gtk_box_append (GTK_BOX (box), toggle1);
/// 
/// text = "Hi, I’m toggle button two";
/// toggle2 = gtk_toggle_button_new_with_label (text);
/// g_signal_connect (toggle2, "toggled",
/// G_CALLBACK (output_state),
/// NULL);
/// gtk_box_append (GTK_BOX (box), toggle2);
/// 
/// gtk_window_set_child (GTK_WINDOW (window), box);
/// gtk_window_present (GTK_WINDOW (window));
/// }
/// ```
public struct ToggleButton: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage) -> Void] = []

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    var accessibleRole: String?
/// action-name
    var actionName: String?
    /// If the toggle button should be pressed in.
    var active: Binding<Bool>?
    /// Whether the size of the button can be made smaller than the natural
    /// size of its contents.
    /// 
    /// For text buttons, setting this property will allow ellipsizing the label.
    /// 
    /// If the contents of a button are an icon or a custom widget, setting this
    /// property has no effect.
    var canShrink: Bool?
    /// The child widget.
    var child:  (() -> Body)?
    /// Whether the button has a frame.
    var hasFrame: Bool?
    /// The name of the icon used to automatically populate the button.
    var iconName: String?
    /// Text of the label inside the button, if the button contains a label widget.
    var label: String?
    /// If set, an underline in the text indicates that the following character is
    /// to be used as mnemonic.
    var useUnderline: Bool?
    /// Emitted to animate press then release.
    /// 
    /// This is an action signal. Applications should never connect
    /// to this signal, but use the [signal@Gtk.Button::clicked] signal.
    /// 
    /// The default bindings for this signal are all forms of the
    /// <kbd>␣</kbd> and <kbd>Enter</kbd> keys.
    var activate: (() -> Void)?
    /// Emitted when the button has been activated (pressed and released).
    var clicked: (() -> Void)?
    /// Emitted whenever the `GtkToggleButton`'s state is changed.
    var toggled: (() -> Void)?
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `ToggleButton`.
    public init() {
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(gtk_toggle_button_new()?.opaque())
        update(storage, modifiers: modifiers, updateProperties: true)
        if let childStorage = child?().widget(modifiers: modifiers).storage(modifiers: modifiers) {
            storage.content["child"] = [childStorage]
            gtk_button_set_child(storage.pointer?.cast(), childStorage.pointer?.cast())
        }


        storage.notify(name: "active") {
            active?.wrappedValue = gtk_toggle_button_get_active(storage.pointer?.cast()) != 0
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
        if let activate {
            storage.connectSignal(name: "activate", argCount: 0) {
                activate()
            }
        }
        if let clicked {
            storage.connectSignal(name: "clicked", argCount: 0) {
                clicked()
            }
        }
        if let toggled {
            storage.connectSignal(name: "toggled", argCount: 0) {
                toggled()
            }
        }
        storage.modify { widget in
            if let actionName, updateProperties {
                gtk_actionable_set_action_name(widget, actionName)
            }
            if let active, updateProperties {
                gtk_toggle_button_set_active(widget?.cast(), active.wrappedValue.cBool)
            }
            if let canShrink, updateProperties {
                gtk_button_set_can_shrink(widget?.cast(), canShrink.cBool)
            }
            if let widget = storage.content["child"]?.first {
                child?().widget(modifiers: modifiers).update(widget, modifiers: modifiers, updateProperties: updateProperties)
            }
            if let hasFrame, updateProperties {
                gtk_button_set_has_frame(widget?.cast(), hasFrame.cBool)
            }
            if let iconName, updateProperties {
                gtk_button_set_icon_name(widget?.cast(), iconName)
            }
            if let label, storage.content["child"] == nil, updateProperties {
                gtk_button_set_label(widget?.cast(), label)
            }
            if let useUnderline, updateProperties {
                gtk_button_set_use_underline(widget?.cast(), useUnderline.cBool)
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

/// action-name
    public func actionName(_ actionName: String?) -> Self {
        var newSelf = self
        newSelf.actionName = actionName
        
        return newSelf
    }

    /// If the toggle button should be pressed in.
    public func active(_ active: Binding<Bool>?) -> Self {
        var newSelf = self
        newSelf.active = active
        
        return newSelf
    }

    /// Whether the size of the button can be made smaller than the natural
    /// size of its contents.
    /// 
    /// For text buttons, setting this property will allow ellipsizing the label.
    /// 
    /// If the contents of a button are an icon or a custom widget, setting this
    /// property has no effect.
    public func canShrink(_ canShrink: Bool? = true) -> Self {
        var newSelf = self
        newSelf.canShrink = canShrink
        
        return newSelf
    }

    /// The child widget.
    public func child(@ViewBuilder _ child: @escaping (() -> Body)) -> Self {
        var newSelf = self
        newSelf.child = child
        
        return newSelf
    }

    /// Whether the button has a frame.
    public func hasFrame(_ hasFrame: Bool? = true) -> Self {
        var newSelf = self
        newSelf.hasFrame = hasFrame
        
        return newSelf
    }

    /// The name of the icon used to automatically populate the button.
    public func iconName(_ iconName: String?) -> Self {
        var newSelf = self
        newSelf.iconName = iconName
        
        return newSelf
    }

    /// Text of the label inside the button, if the button contains a label widget.
    public func label(_ label: String?) -> Self {
        var newSelf = self
        newSelf.label = label
        
        return newSelf
    }

    /// If set, an underline in the text indicates that the following character is
    /// to be used as mnemonic.
    public func useUnderline(_ useUnderline: Bool? = true) -> Self {
        var newSelf = self
        newSelf.useUnderline = useUnderline
        
        return newSelf
    }

    /// Emitted to animate press then release.
    /// 
    /// This is an action signal. Applications should never connect
    /// to this signal, but use the [signal@Gtk.Button::clicked] signal.
    /// 
    /// The default bindings for this signal are all forms of the
    /// <kbd>␣</kbd> and <kbd>Enter</kbd> keys.
    public func activate(_ activate: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.activate = activate
        return newSelf
    }

    /// Emitted when the button has been activated (pressed and released).
    public func clicked(_ clicked: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.clicked = clicked
        return newSelf
    }

    /// Emitted whenever the `GtkToggleButton`'s state is changed.
    public func toggled(_ toggled: @escaping () -> Void) -> Self {
        var newSelf = self
        newSelf.toggled = toggled
        return newSelf
    }

}
