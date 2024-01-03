//
//  Progressbar.swift
//  Adwaita
//
//  Created by david-swift on 03.01.24.
//

import Libadwaita

/// A progress bar widget.
public struct ProgressBar: Widget {

    /// The value.
    var value: Double

    /// Initialize a progress bar widget.
    /// - Parameters:
    ///     - value: The value.
    ///     - total: The maximum value.
    public init(value: Double, total: Double) {
        if total != 0 {
            self.value = value / total
        } else {
            self.value = 0
        }
    }

    /// Update the view storage of the progress bar widget.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        if let bar = storage.view as? Libadwaita.ProgressBar {
            _ = bar.fraction(value)
        }
    }

    /// Get the container of the progress bar widget.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let bar = Libadwaita.ProgressBar().fraction(value)
        _ = bar.sensitive(false)
        return .init(bar)
    }

}
