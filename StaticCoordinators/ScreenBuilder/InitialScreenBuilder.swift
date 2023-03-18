import UIKit

protocol InitialScreenBuilding<NavigationController, ViewController> {
    associatedtype NavigationController: NavigationControlling
    associatedtype ViewController: ViewControlling

    func alphabetCoordinator(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void
    ) -> ViewController
    
    func colorCoordinator(
        navigationCoordinator: NavigationController?,
        analyticsTracker: AnalyticsTracking
    )
}

struct InitialScreenBuilder: InitialScreenBuilding {
    typealias ViewController = UIViewController
    typealias NavigationController = UINavigationController

    func alphabetCoordinator(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void
    ) -> ViewController {
        let tabBarController = UITabBarController()
        tabBarController.title = "Alphabet"
        let configuration = AlphabetCoordinator.Configuration(
            tabBarController: tabBarController,
            screenBuilder: AlphabetScreenBuilder(),
            analyticsTracker: analyticsTracker,
            completion: completion
        )
        AlphabetCoordinator.start(configuration: configuration)
        return tabBarController
    }
    
    func colorCoordinator(
        navigationCoordinator: UINavigationController?,
        analyticsTracker: AnalyticsTracking
    ) {
        let configuration = ColorCoordinator.Configuration(
            navigationController: navigationCoordinator,
            screenBuilder: ColorScreenBuilder(),
            analyticsTracker: analyticsTracker
        )
        ColorCoordinator.start(configuration: configuration)
    }
}
