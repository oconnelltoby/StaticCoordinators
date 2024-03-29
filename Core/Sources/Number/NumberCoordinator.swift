import Navigation
import Analytics

public struct NumberCoordinator<
    NavigationController: AnyObject & NavigationControlling<ViewController>,
    ViewController: AnyObject & ViewControlling<ViewController>,
    ScreenBuilder: NumberScreenBuilding<ViewController>
> {
    public struct Configuration {
        public init(
            navigationController: NavigationController?,
            screenBuilder: ScreenBuilder,
            analyticsTracker: AnalyticsTracking,
            completion: @escaping () -> Void,
            dismiss: @escaping () -> Void
        ) {
            self.navigationController = navigationController
            self.screenBuilder = screenBuilder
            self.analyticsTracker = analyticsTracker
            self.completion = completion
            self.dismiss = dismiss
        }
        
        weak var navigationController: NavigationController?
        var screenBuilder: ScreenBuilder
        var analyticsTracker: AnalyticsTracking
        var completion: () -> Void
        var dismiss: () -> Void
    }
    
    public static func start(configuration: Configuration) {
        pushOneScreen(configuration: configuration)
    }
    
    private static func pushOneScreen(configuration: Configuration) {
        let screen = configuration.screenBuilder.one(
            analyticsTracker: configuration.analyticsTracker,
            completion: { pushTwoScreen(configuration: configuration) },
            dismiss: configuration.dismiss
        )
        configuration.navigationController?.pushViewController(screen)
    }
    
    private static func pushTwoScreen(configuration: Configuration) {
        let screen = configuration.screenBuilder.two(
            analyticsTracker: configuration.analyticsTracker,
            completion: { pushThreeScreen(configuration: configuration) },
            dismiss: configuration.dismiss
        )
        configuration.navigationController?.pushViewController(screen)
    }
    
    private static func pushThreeScreen(configuration: Configuration) {
        var completion: (() -> Void)?
        let screen = configuration.screenBuilder.three(
            analyticsTracker: configuration.analyticsTracker,
            completion: { completion?() },
            dismiss: configuration.dismiss
        )
        configuration.navigationController?.pushViewController(screen)
        completion = { [weak screen] in
            presentCompletionAlert(on: screen, configuration: configuration)
        }
    }
 
    private static func presentCompletionAlert(on presentingScreen: ViewController?, configuration: Configuration) {
        let screen = configuration.screenBuilder.completionAlert(startAgain: configuration.completion)
        presentingScreen?.present(screen)
    }
}
