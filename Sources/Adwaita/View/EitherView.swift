//
//  EitherView.swift
//  Adwaita
//
//  Created by david-swift on 22.08.23.
//

import Libadwaita

/// An equivalent to GtkStack for two views.
public struct EitherView: Widget {

    /// The view that is displayed when `isTrue` is true.
    var trueView: Body?
    /// The view that is displayed when `isTrue` is false.
    var falseView: Body?
    /// The state.
    var isTrue: Bool

    /// Initialize an `EitherView`.
    /// - Parameters:
    ///   - isTrue: The state.
    ///   - _:  The view that is presented if `isTrue` is true.
    ///   - else: The view that is presented if `isTrue` is false.
    public init(
        _ isTrue: Bool,
        @ViewBuilder _ trueView: @escaping () -> Body,
        @ViewBuilder else falseView: @escaping () -> Body
    ) {
        self.init(isTrue, .some(trueView), else: .some(falseView))
    }

    /// Initialize an `EitherView`.
    /// - Parameters:
    ///   - isTrue: The state.
    ///   - trueView:  The view that is presented if `isTrue` is true.
    ///   - falseView: The view that is presented if `isTrue` is false.
    init(_ isTrue: Bool, _ trueView: (() -> Body)? = nil, else falseView: (() -> Body)? = nil) {
        self.trueView = trueView?()
        self.falseView = falseView?()
        self.isTrue = isTrue
    }

    /// Update an `EitherView`'s storage.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - modifiers: Modify views before being updated.
    public func update(_ storage: ViewStorage, modifiers: [(View) -> View]) {
        let stack = storage.view as? Stack
        updateContent(storage, state: true, stack: stack, modifiers: modifiers)
        updateContent(storage, state: false, stack: stack, modifiers: modifiers)
        if isTrue, let trueView = storage.content["\(true)"]?.last?.view {
            setVisible(stack, view: trueView)
        } else if !isTrue, let falseView = storage.content["\(false)"]?.last?.view {
            setVisible(stack, view: falseView)
        }
    }

    /// Update the content of a view in the view storage.
    /// - Parameters:
    ///   - storage: The view storage.
    ///   - state: Whether it is the true or false view.
    ///   - stack: The stack.
    ///   - modifiers: Modify views before being updated.
    private func updateContent(_ storage: ViewStorage, state: Bool, stack: Stack?, modifiers: [(View) -> View]) {
        let activeView = (state ? trueView : falseView)?.widget(modifiers: modifiers)
        if let view = storage.content["\(state)"]?[safe: 0] {
            activeView?.updateStorage(view, modifiers: modifiers)
        } else if let view = activeView?.storage(modifiers: modifiers) {
            _ = stack?.append(view.view)
            storage.content["\(state)"] = [view]
        }
    }

    /// Set the visible content page.
    /// - Parameters:
    ///   - stack: The stack.
    ///   - view: The visible view.
    private func setVisible(_ stack: Stack?, view: NativeWidgetPeer) {
        stack?.setVisible(view, transition: view.fields[.transition] as? Transition)
    }

    /// Get a GtkStack view storage.
    /// - Parameter modifiers: Modify views before being updated.
    /// - Returns: The view storage.
    public func container(modifiers: [(View) -> View]) -> ViewStorage {
        let stack = Stack()
        var content: [String: [ViewStorage]] = [:]
        if let trueView {
            let view = trueView.widget(modifiers: modifiers).storage(modifiers: modifiers)
            _ = stack.append(view.view)
            content["\(true)"] = [view]
        }
        if let falseView {
            let view = falseView.widget(modifiers: modifiers).storage(modifiers: modifiers)
            _ = stack.append(view.view)
            content["\(false)"] = [view]
        }
        if isTrue, let trueView = content["\(true)"]?.last?.view {
            stack.setVisible(trueView)
        } else if let falseView = content["\(false)"]?.last?.view {
            stack.setVisible(falseView)
        }
        return .init(stack, content: content)
    }

}
