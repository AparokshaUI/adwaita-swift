//
//  Array.swift
//  Adwaita
//
//  Created by david-swift on 06.08.23.
//

import GTUI

extension Array where Element == View {

    /// Get a widget from a collection of views.
    /// - Returns: A widget.
    public func widget() -> Widget {
        if count == 1, let widget = self[safe: 0]?.widget() {
            return widget
        } else {
            return VStack { self }
        }
    }

    /// Update a collection of views with a collection of view storages.
    /// - Parameters:
    ///     - storage: The collection of view storages.
    public func update(_ storage: [ViewStorage]) {
        for (index, element) in enumerated() {
            if let storage = storage[safe: index] {
                element.widget().updateStorage(storage)
            }
        }
    }

}

extension Array {

    /// Accesses the element at the specified position safely.
    /// - Parameters:
    ///   - index: The position of the element to access.
    ///
    ///   Access and set elements the safe way:
    ///   ```swift
    ///   var array = ["Hello", "World"]
    ///   print(array[safe: 2] ?? "Out of range")
    ///   ```
    public subscript(safe index: Int?) -> Element? {
        get {
            if let index, checkIndex(index) {
                return self[index]
            }
            return nil
        }
        set {
            if let index, let value = newValue, checkIndex(index) {
                self[index] = value
            }
        }
    }

    /// Check if a given index is valid for the array.
    /// - Parameter index: The index to test.
    /// - Returns: Return whether the index is valid or not.
    private func checkIndex(_ index: Int) -> Bool {
        index < count && index >= 0
    }

}
