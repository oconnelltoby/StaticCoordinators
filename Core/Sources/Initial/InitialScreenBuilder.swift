import Navigation
import Analytics
import Alphabet
import Number
import Color
import UIKit

public protocol InitialScreenBuilding<NavigationController, ViewController> {
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

public struct InitialScreenBuilder: InitialScreenBuilding {
    public typealias ViewController = UIViewController
    public typealias NavigationController = UINavigationController
    
    public init() {}

    public func alphabetCoordinator(
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
    
    public func colorCoordinator(
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
