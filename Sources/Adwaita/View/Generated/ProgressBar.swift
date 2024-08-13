//
//  ProgressBar.swift
//  Adwaita
//
//  Created by auto-generation on 03.08.24.
//

import CAdw
import LevenshteinTransformations

/// `GtkProgressBar` is typically used to display the progress of a long
/// running operation.
/// 
/// It provides a visual clue that processing is underway. `GtkProgressBar`
/// can be used in two different modes: percentage mode and activity mode.
/// 
/// ![An example GtkProgressBar](progressbar.png)
/// 
/// When an application can determine how much work needs to take place
/// (e.g. read a fixed number of bytes from a file) and can monitor its
/// progress, it can use the `GtkProgressBar` in percentage mode and the
/// user sees a growing bar indicating the percentage of the work that
/// has been completed. In this mode, the application is required to call
/// [method@Gtk.ProgressBar.set_fraction] periodically to update the progress bar.
/// 
/// When an application has no accurate way of knowing the amount of work
/// to do, it can use the `GtkProgressBar` in activity mode, which shows
/// activity by a block moving back and forth within the progress area. In
/// this mode, the application is required to call [method@Gtk.ProgressBar.pulse]
/// periodically to update the progress bar.
/// 
/// There is quite a bit of flexibility provided to control the appearance
/// of the `GtkProgressBar`. Functions are provided to control the orientation
/// of the bar, optional text can be displayed along with the bar, and the
/// step size used in activity mode can be set.
/// 
/// # CSS nodes
/// 
/// ```
/// progressbar[.osd]
/// ├── [text]
/// ╰── trough[.empty][.full]
/// ╰── progress[.pulse]
/// ```
/// 
/// `GtkProgressBar` has a main CSS node with name progressbar and subnodes with
/// names text and trough, of which the latter has a subnode named progress. The
/// text subnode is only present if text is shown. The progress subnode has the
/// style class .pulse when in activity mode. It gets the style classes .left,
/// .right, .top or .bottom added when the progress 'touches' the corresponding
/// end of the GtkProgressBar. The .osd class on the progressbar node is for use
/// in overlays like the one Epiphany has for page loading progress.
/// 
/// # Accessibility
/// 
/// `GtkProgressBar` uses the %GTK_ACCESSIBLE_ROLE_PROGRESS_BAR role.
public struct ProgressBar: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, [(AnyView) -> AnyView], Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, [(AnyView) -> AnyView]) -> Void] = []

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    var accessibleRole: String?
    /// The fraction of total work that has been completed.
    var fraction: Double?
    /// Invert the direction in which the progress bar grows.
    var inverted: Bool?
    /// The fraction of total progress to move the bounding block when pulsed.
    var pulseStep: Double?
    /// Sets whether the progress bar will show a text in addition
    /// to the bar itself.
    /// 
    /// The shown text is either the value of the [property@Gtk.ProgressBar:text]
    /// property or, if that is %NULL, the [property@Gtk.ProgressBar:fraction]
    /// value, as a percentage.
    /// 
    /// To make a progress bar that is styled and sized suitably for showing text
    /// (even if the actual text is blank), set [property@Gtk.ProgressBar:show-text]
    /// to %TRUE and [property@Gtk.ProgressBar:text] to the empty string (not %NULL).
    var showText: Bool?
    /// Text to be displayed in the progress bar.
    var text: String?
    /// The application.
    var app: AdwaitaApp?
    /// The window.
    var window: AdwaitaWindow?

    /// Initialize `ProgressBar`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The type of the app storage.
    /// - Returns: The view storage.
    public func container<Data>(modifiers: [(AnyView) -> AnyView], type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(gtk_progress_bar_new()?.opaque())
        for function in appearFunctions {
            function(storage, modifiers)
        }
        update(storage, modifiers: modifiers, updateProperties: true, type: type)

        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The type of the app storage.
    public func update<Data>(_ storage: ViewStorage, modifiers: [(AnyView) -> AnyView], updateProperties: Bool, type: Data.Type) where Data: ViewRenderData {
        storage.modify { widget in

            if let fraction, updateProperties, (storage.previousState as? Self)?.fraction != fraction {
                gtk_progress_bar_set_fraction(widget, fraction)
            }
            if let inverted, updateProperties, (storage.previousState as? Self)?.inverted != inverted {
                gtk_progress_bar_set_inverted(widget, inverted.cBool)
            }
            if let pulseStep, updateProperties, (storage.previousState as? Self)?.pulseStep != pulseStep {
                gtk_progress_bar_set_pulse_step(widget, pulseStep)
            }
            if let showText, updateProperties, (storage.previousState as? Self)?.showText != showText {
                gtk_progress_bar_set_show_text(widget, showText.cBool)
            }
            if let text, updateProperties, (storage.previousState as? Self)?.text != text {
                gtk_progress_bar_set_text(widget, text)
            }


        }
        for function in updateFunctions {
            function(storage, modifiers, updateProperties)
        }
        if updateProperties {
            storage.previousState = self
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

    /// The fraction of total work that has been completed.
    public func fraction(_ fraction: Double?) -> Self {
        var newSelf = self
        newSelf.fraction = fraction
        
        return newSelf
    }

    /// Invert the direction in which the progress bar grows.
    public func inverted(_ inverted: Bool? = true) -> Self {
        var newSelf = self
        newSelf.inverted = inverted
        
        return newSelf
    }

    /// The fraction of total progress to move the bounding block when pulsed.
    public func pulseStep(_ pulseStep: Double?) -> Self {
        var newSelf = self
        newSelf.pulseStep = pulseStep
        
        return newSelf
    }

    /// Sets whether the progress bar will show a text in addition
    /// to the bar itself.
    /// 
    /// The shown text is either the value of the [property@Gtk.ProgressBar:text]
    /// property or, if that is %NULL, the [property@Gtk.ProgressBar:fraction]
    /// value, as a percentage.
    /// 
    /// To make a progress bar that is styled and sized suitably for showing text
    /// (even if the actual text is blank), set [property@Gtk.ProgressBar:show-text]
    /// to %TRUE and [property@Gtk.ProgressBar:text] to the empty string (not %NULL).
    public func showText(_ showText: Bool? = true) -> Self {
        var newSelf = self
        newSelf.showText = showText
        
        return newSelf
    }

    /// Text to be displayed in the progress bar.
    public func text(_ text: String?) -> Self {
        var newSelf = self
        newSelf.text = text
        
        return newSelf
    }

}
