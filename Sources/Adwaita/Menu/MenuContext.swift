//
//  MenuContext.swift
//  Adwaita
//
//  Created by david-swift on 01.08.24.
//

/// The menu items view context.
public enum MenuContext: ViewRenderData {

    /// The type of the widgets.
    public typealias WidgetType = MenuWidget
    /// The wrapper type.
    public typealias WrapperType = MenuCollection
    /// The either view type.
    public typealias EitherViewType = MenuEitherView

}

/// The type of the widgets.
public protocol MenuWidget: Meta.Widget { }
