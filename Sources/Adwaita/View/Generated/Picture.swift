//
//  Picture.swift
//  Adwaita
//
//  Created by auto-generation on 21.04.24.
//

import CAdw
import LevenshteinTransformations

/// The `GtkPicture` widget displays a `GdkPaintable`.
/// 
/// ![An example GtkPicture](picture.png)
/// 
/// Many convenience functions are provided to make pictures simple to use.
/// For example, if you want to load an image from a file, and then display
/// it, there’s a convenience function to do this:
/// 
/// ```c
/// GtkWidget *widget = gtk_picture_new_for_filename ("myfile.png");
/// ```
/// 
/// If the file isn’t loaded successfully, the picture will contain a
/// “broken image” icon similar to that used in many web browsers.
/// If you want to handle errors in loading the file yourself,
/// for example by displaying an error message, then load the image with
/// [ctor@Gdk.Texture.new_from_file], then create the `GtkPicture` with
/// [ctor@Gtk.Picture.new_for_paintable].
/// 
/// Sometimes an application will want to avoid depending on external data
/// files, such as image files. See the documentation of `GResource` for details.
/// In this case, [ctor@Gtk.Picture.new_for_resource] and
/// [method@Gtk.Picture.set_resource] should be used.
/// 
/// `GtkPicture` displays an image at its natural size. See [class@Gtk.Image]
/// if you want to display a fixed-size image, such as an icon.
/// 
/// ## Sizing the paintable
/// 
/// You can influence how the paintable is displayed inside the `GtkPicture`
/// by changing [property@Gtk.Picture:content-fit]. See [enum@Gtk.ContentFit]
/// for details. [property@Gtk.Picture:can-shrink] can be unset to make sure
/// that paintables are never made smaller than their ideal size - but
/// be careful if you do not know the size of the paintable in use (like
/// when displaying user-loaded images). This can easily cause the picture to
/// grow larger than the screen. And [property@Gtk.Widget:halign] and
/// [property@Gtk.Widget:valign] can be used to make sure the paintable doesn't
/// fill all available space but is instead displayed at its original size.
/// 
/// ## CSS nodes
/// 
/// `GtkPicture` has a single CSS node with the name `picture`.
/// 
/// ## Accessibility
/// 
/// `GtkPicture` uses the `GTK_ACCESSIBLE_ROLE_IMG` role.
public struct Picture: Widget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(View) -> View], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(View) -> View]) -> Void] = []

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    var accessibleRole: String?
    /// The alternative textual description for the picture.
    var alternativeText: String?
    /// If the `GtkPicture` can be made smaller than the natural size of its contents.
    var canShrink: Bool?
    /// Whether the GtkPicture will render its contents trying to preserve the aspect
    /// ratio.
    var keepAspectRatio: Bool?
    /// The application.
    var app: GTUIApp?
    /// The window.
    var window: GTUIApplicationWindow?

    /// Initialize `Picture`.
    public init() {
    }

    /// Get the widget's view storage.
    /// - Parameter modifiers: The view modifiers.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let storage = ViewStorage(gtk_picture_new()?.opaque())
        update(storage, modifiers: modifiers, updateProperties: true)

        for function in appearFunctions {
            function(storage, modifiers)
        }
        return storage
    }

    /// Update the widget's view storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: The view modifiers.
    ///     - updateProperties: Whether to update the view's properties.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
        storage.modify { widget in

            if let alternativeText, updateProperties {
                gtk_picture_set_alternative_text(widget, alternativeText)
            }
            if let canShrink, updateProperties {
                gtk_picture_set_can_shrink(widget, canShrink.cBool)
            }
            if let keepAspectRatio, updateProperties {
                gtk_picture_set_keep_aspect_ratio(widget, keepAspectRatio.cBool)
            }


        }
        for function in updateFunctions {
            function(storage, modifiers, updateProperties)
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

    /// The alternative textual description for the picture.
    public func alternativeText(_ alternativeText: String?) -> Self {
        var newSelf = self
        newSelf.alternativeText = alternativeText
        
        return newSelf
    }

    /// If the `GtkPicture` can be made smaller than the natural size of its contents.
    public func canShrink(_ canShrink: Bool? = true) -> Self {
        var newSelf = self
        newSelf.canShrink = canShrink
        
        return newSelf
    }

    /// Whether the GtkPicture will render its contents trying to preserve the aspect
    /// ratio.
    public func keepAspectRatio(_ keepAspectRatio: Bool? = true) -> Self {
        var newSelf = self
        newSelf.keepAspectRatio = keepAspectRatio
        
        return newSelf
    }

}
