//
//  Array.swift
//  Adwaita
//
//  Created by david-swift on 06.08.23.
//

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
