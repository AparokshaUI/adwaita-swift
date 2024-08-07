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
        newSelf.appearFunctions.append { storage, modifiers in
            let view = view().storage(modifiers: modifiers)
            gtk_fixed_put(
                storage.pointer?.cast(),
                view.pointer?.cast(),
                xCoordinate,
                yCoordinate
            )
            storage.content[id] = [view]
        }
        newSelf.updateFunctions.append { storage, modifiers, updateProperties in
            guard let content = storage.content[id]?.first else {
                return
            }
            view().updateStorage(content, modifiers: modifiers, updateProperties: updateProperties)
            if updateProperties {
                gtk_fixed_move(
                    storage.pointer?.cast(),
                    content.pointer?.cast(),
                    xCoordinate,
                    yCoordinate
                )
            }
        }
        return newSelf
    }

}
