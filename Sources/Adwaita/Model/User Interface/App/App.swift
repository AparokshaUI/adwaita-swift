//
//  App.swift
//  Adwaita
//
//  Created by david-swift on 05.08.23.
//

/// A structure conforming to `App` is the entry point of your app.
///
/// ```swift
/// @main
/// struct Test: App {
///
///     let id = "io.github.AparokshaUI.TestApp"
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

/// An extension
extension App {

    /// The application's entry point.
    public static func main() {
        let app = setupApp()
        app.run()
    }

    /// Initialize and get the GTUI app.
    ///
    /// To run the app, call the ``GTUIApp/run(automaticSetup:manualSetup:)`` function.
    public static func setupApp() -> GTUIApp {
        var appInstance = self.init()
        appInstance.app = GTUIApp(appInstance.id) { appInstance }
        GTUIApp.updateHandlers.append { force in
            var removeIndices: [Int] = []
            for (index, window) in appInstance.app.sceneStorage.enumerated() {
                if window.destroy {
                    removeIndices.insert(index, at: 0)
                } else if let scene = appInstance.scene.windows().first(where: { $0.id == window.id }) {
                    scene.update(window, app: appInstance.app, force: force)
                }
            }
            for index in removeIndices {
                appInstance.app.sceneStorage.remove(at: index)
            }
        }
        GTUIApp.appID = appInstance.id
        return appInstance.app
    }

}
