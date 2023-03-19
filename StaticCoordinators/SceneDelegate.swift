import UIKit
import Initial

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.tintColor = .label
        
        let configuration = InitialCoordinator.Configuration(
            navigationController: navigationController,
            screenBuilder: InitialScreenBuilder(),
            analyticsTracker: AnalyticsPrinter()
        )
        
        InitialCoordinator.start(configuration: configuration)
    }
}

