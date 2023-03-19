import Navigation
import Analytics

public struct AlphabetCoordinator<
    TabBarController: AnyObject & TabBarControlling<ViewController>,
    ViewController: AnyObject & ViewControlling<ViewController>,
    ScreenBuilder: AlphabetScreenBuilding<ViewController>
> {
    public struct Configuration {
        public init(
            tabBarController: TabBarController?,
            screenBuilder: ScreenBuilder,
            analyticsTracker: AnalyticsTracking,
            completion: @escaping () -> Void
        ) {
            self.tabBarController = tabBarController
            self.screenBuilder = screenBuilder
            self.analyticsTracker = analyticsTracker
            self.completion = completion
        }
        
        weak var tabBarController: TabBarController?
        var screenBuilder: ScreenBuilder
        var analyticsTracker: AnalyticsTracking
        var completion: () -> Void
    }
    
    public static func start(configuration: Configuration) {
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
 
