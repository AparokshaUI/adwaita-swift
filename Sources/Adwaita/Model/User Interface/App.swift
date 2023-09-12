//
//  App.swift
//  Adwaita
//
//  Created by david-swift on 05.08.23.
//

import GTUI

/// A structure conforming to `App` is the entry point of your app.
///
/// ```swift
/// @main
/// struct Test: App {
///
///     let id = "io.github.david-swift.TestApp"
///     var app: GTUIApp!
///
///     var scene: Scene {
///         WindowScene()
///     }
///
/// }
/// ```
/// 
public protocol App {

    /// The app's application ID.
    var id: String { get }
    /// The app's windows.
    @SceneBuilder var scene: Scene { get }
    // swiftlint:disable implicitly_unwrapped_optional
    /// The app.
    var app: GTUIApp! { get set }
    // swiftlint:enable implicitly_unwrapped_optional

    /// An app has to have an `init()` initializer.
    init()

}

extension App {

    /// The application's entry point.
    public static func main() {
        var appInstance = self.init()
        appInstance.app = GTUIApp(appInstance.id) { appInstance }
        GTUIApp.updateHandlers.append {
            for (windowIndex, window) in appInstance.scene.enumerated() {
                if let stored = appInstance.app.sceneStorage[safe: windowIndex] {
                    window.widget().updateStorage(stored.view)
                }
            }
        }
        appInstance.app.run()
    }

}
