//
//  Array.swift
//  Adwaita
//
//  Created by david-swift on 06.08.23.
//

import Foundation

extension Array: View where Element == View {

    /// The array's view body is the array itself.
    public var view: Body { self }

    /// Get a widget from a collection of views.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: A widget.
    public func widget(modifiers: [(View) -> View]) -> Widget {
        if count == 1, let widget = self[safe: 0]?.widget(modifiers: modifiers) {
            return widget
        } else {
            var modified = self
            for (index, view) in modified.enumerated() {
                for modifier in modifiers {
                    modified[safe: index] = modifier(view)
                }
            }
            return VStack { modified }
        }
    }

    /// Update a collection of views with a collection of view storages.
    /// - Parameters:
    ///     - storage: The collection of view storages.
    ///     - modifiers: Modify views before being updated.
    ///     - updateProperties: Whether to update properties.
    public func update(_ storage: [ViewStorage], modifiers: [(View) -> View], updateProperties: Bool) {
        for (index, element) in enumerated() {
            if let storage = storage[safe: index] {
                element
                    .widget(modifiers: modifiers)
                    .updateStorage(storage, modifiers: modifiers, updateProperties: updateProperties)
            }
        }
    }

}

extension Array where Element == WindowSceneGroup {

    /// Get the content of an array of window scene groups.
    /// - Returns: The array of windows.
    public func windows() -> [WindowScene] {
        flatMap { $0.windows() }
    }

}

extension Array where Element == String {

    /// Get the C version of the array.
    var cArray: UnsafePointer<UnsafePointer<CChar>?>? {
        let cStrings = self.map { $0.utf8CString }
        let cStringPointers = cStrings.map { $0.withUnsafeBufferPointer { $0.baseAddress } }
        let optionalCStringPointers = cStringPointers + [nil]
        var optionalCStringPointersCopy = optionalCStringPointers
        optionalCStringPointersCopy.withUnsafeMutableBufferPointer { bufferPointer in
            bufferPointer.baseAddress?.advanced(by: cStrings.count).pointee = nil
        }
        let flatArray = optionalCStringPointersCopy.compactMap { $0 }
        let pointer = UnsafeMutablePointer<UnsafePointer<CChar>?>.allocate(capacity: flatArray.count + 1)
        for (index, element) in flatArray.enumerated() {
            pointer.advanced(by: index).pointee = element
        }
        pointer.advanced(by: flatArray.count).pointee = nil
        return UnsafePointer(pointer)
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
            if let index, indices.contains(index) {
                return self[index]
            }
            return nil
        }
        set {
            if let index, let value = newValue, indices.contains(index) {
                self[index] = value
            }
        }
    }

}

extension Binding where Value == [Any] {

    /// Get a child at a certain index of the array as a binding.
    /// - Parameters:
    ///     - index: The child's index.
    ///     - defaultValue: The value used if the index is out of range does not exist.
    /// - Returns: The child as a binding.
    public subscript(safe index: Int?, default defaultValue: Value.Element) -> Binding<Value.Element> {
        .init {
            wrappedValue[safe: index] ?? defaultValue
        } set: { newValue in
            wrappedValue[safe: index] = newValue
        }
    }

}
