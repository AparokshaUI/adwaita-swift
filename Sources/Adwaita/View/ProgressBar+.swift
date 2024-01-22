//
//  Progressbar+.swift
//  Adwaita
//
//  Created by david-swift on 15.01.24.
//

extension ProgressBar {

    /// Initialize a progress bar widget.
    /// - Parameters:
    ///     - value: The value.
    ///     - total: The maximum value.
    public init(value: Double, total: Double) {
        self.init()
        if total != 0 {
            self = self.fraction(value / total)
        } else {
            self = self.fraction(0)
        }
    }

}
