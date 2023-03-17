import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.tintColor = .label
        
        let configuration = ColorCoordinator.Configuration(
            navigationController: navigationController,
            screenFactory: ColorViewControllerFactory(),
            analyticsTracker: AnalyticsPrinter()
        )
        
        ColorCoordinator<UINavigationController, UIViewController, ColorViewControllerFactory>.start(configuration: configuration)
    }
}

