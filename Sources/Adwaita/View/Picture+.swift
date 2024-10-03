//
//  Picture+.swift
//  Adwaita
//
//  Created by david-swift on 21.04.24.
//

import CAdw
import Foundation

extension Picture {

    /// Load the picture from Foundation's `Data`.
    /// - Parameter data: The data.
    /// - Returns: The view.
    public func data(_ data: Data?) -> AnyView {
        let oldData = "old-data"
        return inspect { storage, updateProperties in
            if updateProperties {
                let pointer = storage.opaquePointer
                guard let data else {
                    if storage.fields[oldData] != nil {
                        gtk_picture_set_paintable(pointer, gdk_paintable_new_empty(0, 0))
                        storage.fields[oldData] = nil
                    }
                    return
                }
                guard data != storage.fields[oldData] as? Data else {
                    return
                }
                let bytes = data.withUnsafeBytes { ptr in
                    g_bytes_new(ptr.baseAddress, .init(data.count))
                }
                let texture = gdk_texture_new_from_bytes(bytes, nil)
                gtk_picture_set_paintable(pointer, texture)
                storage.fields[oldData] = data
            }
        }
    }

}
