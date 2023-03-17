struct NumberCoordinator<
    NavigationController: AnyObject & NavigationControlling<ViewController>,
    ViewController: AnyObject & ViewControlling<ViewController>,
    ScreenFactory: NumberScreenFactoryProtocol<ViewController>
> {
    struct Configuration {
        weak var navigationController: NavigationController?
        var screenFactory: ScreenFactory
        var analyticsTracker: AnalyticsTracking
        var completion: () -> Void
        var dismiss: () -> Void
    }
    
    static func start(configuration: Configuration) {
        pushOneScreen(configuration: configuration)
    }
    
    static func pushOneScreen(configuration: Configuration) {
        let screen = configuration.screenFactory.one(
            analyticsTracker: configuration.analyticsTracker,
            completion: { pushTwoScreen(configuration: configuration) },
            dismiss: configuration.dismiss
        )
        configuration.navigationController?.pushViewController(screen)
    }
    
    static func pushTwoScreen(configuration: Configuration) {
        let screen = configuration.screenFactory.two(
            analyticsTracker: configuration.analyticsTracker,
            completion: { pushThreeScreen(configuration: configuration) },
            dismiss: configuration.dismiss
        )
        configuration.navigationController?.pushViewController(screen)
    }
    
    static func pushThreeScreen(configuration: Configuration) {
        var completion: (() -> Void)?
        let screen = configuration.screenFactory.three(
            analyticsTracker: configuration.analyticsTracker,
            completion: { completion?() },
            dismiss: configuration.dismiss
        )
        configuration.navigationController?.pushViewController(screen)
        completion = { [weak screen] in
            presentCompletionAlert(on: screen, configuration: configuration)
        }
    }
 
    static func presentCompletionAlert(on presentingScreen: ViewController?, configuration: Configuration) {
        let screen = configuration.screenFactory.completionAlert(startAgain: configuration.completion)
        presentingScreen?.present(screen)
    }
}
