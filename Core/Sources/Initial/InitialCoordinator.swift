import Navigation
import Analytics

public struct InitialCoordinator<
    NavigationController: AnyObject & NavigationControlling<ViewController>,
    ViewController: AnyObject & ViewControlling<ViewController>,
    ScreenBuilder: InitialScreenBuilding<NavigationController, ViewController>
> {
    public struct Configuration {
        public init(
            navigationController: NavigationController?,
            screenBuilder: ScreenBuilder,
            analyticsTracker: AnalyticsTracking
        ) {
            self.navigationController = navigationController
            self.screenBuilder = screenBuilder
            self.analyticsTracker = analyticsTracker
        }
        
        weak var navigationController: NavigationController?
        var screenBuilder: ScreenBuilder
        var analyticsTracker: AnalyticsTracking
    }
    
    public static func start(configuration: Configuration) {
        let screen = configuration.screenBuilder.alphabetCoordinator(
            analyticsTracker: configuration.analyticsTracker,
            completion: {
                showColorCoordinator(configuration: configuration)
            }
        )
        configuration.navigationController?.pushViewController(screen, animated: true)
    }
    
    private static func showColorCoordinator(configuration: Configuration) {
        configuration.screenBuilder.colorCoordinator(
            navigationCoordinator: configuration.navigationController,
            analyticsTracker: configuration.analyticsTracker
        )
    }
}
    
