struct InitialCoordinator<
    NavigationController: AnyObject & NavigationControlling<ViewController>,
    ViewController: AnyObject & ViewControlling<ViewController>,
    ScreenBuilder: InitialScreenBuilding<NavigationController, ViewController>
> {
    struct Configuration {
        weak var navigationController: NavigationController?
        var screenBuilder: ScreenBuilder
        var analyticsTracker: AnalyticsTracking
    }
    
    static func start(configuration: Configuration) {
        let screen = configuration.screenBuilder.alphabetCoordinator(
            analyticsTracker: configuration.analyticsTracker,
            completion: {
                showColorCoordinator(configuration: configuration)
            }
        )
        configuration.navigationController?.pushViewController(screen, animated: true)
    }
    
    static func showColorCoordinator(configuration: Configuration) {
        configuration.screenBuilder.colorCoordinator(
            navigationCoordinator: configuration.navigationController,
            analyticsTracker: configuration.analyticsTracker
        )
    }
}
    
