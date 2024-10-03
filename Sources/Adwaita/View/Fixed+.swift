//
//  Fixed+.swift
//  Adwaita
//
//  Created by david-swift on 21.07.24.
//

import CAdw

extension Fixed {

    /// Place an element in the coordinate system.
    /// - Parameters:
    ///     - xCoordinate: The x coordinate.
    ///     - yCoordinate: The y coordinate.
    ///     - id: A unique identifier.
    ///     - view: The element.
    /// - Returns: The coordinate system with the element.
    public func element(
        x xCoordinate: Double,
        y yCoordinate: Double,
        id: String,
        @ViewBuilder view: @escaping () -> Body
    ) -> Self {
        var newSelf = self
        newSelf.appearFunctions.append { storage, data in
            let view = view().storage(data: data, type: AdwaitaMainView.self)
            gtk_fixed_put(
                storage.opaquePointer?.cast(),
                view.opaquePointer?.cast(),
                xCoordinate,
                yCoordinate
            )
            storage.content[id] = [view]
        }
        newSelf.updateFunctions.append { storage, data, updateProperties in
            guard let content = storage.content[id]?.first else {
                return
            }
            view()
                .updateStorage(
                    content,
                    data: data,
                    updateProperties: updateProperties,
                    type: AdwaitaMainView.self
                )
            if updateProperties {
                gtk_fixed_move(
                    storage.opaquePointer?.cast(),
                    content.opaquePointer?.cast(),
                    xCoordinate,
                    yCoordinate
                )
            }
        }
        return newSelf
    }

}
