//
//  SpinRow+.swift
//  Adwaita
//
//  Created by david-swift on 20.01.24.
//

import CAdw

extension SpinRow {

    /// Initialize a spin row.
    /// - Parameters:
    ///     - title: The row's title.
    ///     - value: The selected value.
    ///     - min: The minimum value.
    ///     - max: The maximum value.
    public init(_ title: String, value: Binding<Int>, min: Int, max: Int) {
        self.init(
            title,
            value: .init { .init(value.wrappedValue) } set: { value.wrappedValue = .init($0) },
            min: .init(min),
            max: .init(max)
        )
    }

    /// Initialize a spin row.
    /// - Parameters:
    ///     - title: The row's title.
    ///     - value: The selected value.
    ///     - min: The minimum value.
    ///     - max: The maximum value.
    public init(_ title: String, value: Binding<Double>, min: Double, max: Double) {
        self.init(climbRate: 1, digits: 0)
        self = self.title(title)
        self = self.value(value)
        self = self.step(1)
        updateFunctions.append { storage, _, _ in
            adw_spin_row_set_range(storage.opaquePointer, min, max)
        }
    }

    /// Set the difference a single click on the increase/decrease buttons makes.
    /// - Parameter step: The increase/decrease step.
    /// - Returns: The spin row.
    public func step(_ step: Int) -> Self {
        self.step(.init(step))
    }

    /// Set the difference a single click on the increase/decrease buttons makes.
    /// - Parameter step: The increase/decrease step.
    /// - Returns: The spin row.
    public func step(_ step: Double) -> Self {
        var newSelf = self
        newSelf.updateFunctions.append { storage, _, _ in
            let adjustment = adw_spin_row_get_adjustment(storage.opaquePointer)
            gtk_adjustment_set_step_increment(adjustment, step)
        }
        return newSelf
    }

}
