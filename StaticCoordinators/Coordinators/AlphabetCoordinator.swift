struct AlphabetCoordinator<
    TabBarController: AnyObject & TabBarControlling<ViewController>,
    ViewController: AnyObject & ViewControlling<ViewController>,
    ScreenBuilder: AlphabetScreenBuilding<ViewController>
> {
    struct Configuration {
        weak var tabBarController: TabBarController?
        var screenBuilder: ScreenBuilder
        var analyticsTracker: AnalyticsTracking
        var completion: () -> Void
    }
    
    static func start(configuration: Configuration) {
        let screens = [
            configuration.screenBuilder.alphabetA(
                analyticsTracker: configuration.analyticsTracker,
                completion: configuration.completion
            ),
            configuration.screenBuilder.alphabetB(
                analyticsTracker: configuration.analyticsTracker,
                completion: configuration.completion
            ),
            configuration.screenBuilder.alphabetC(
                analyticsTracker: configuration.analyticsTracker,
                completion: configuration.completion
            )
        ]
        configuration.tabBarController?.setViewControllers(screens, animated: false)
    }
}
 
