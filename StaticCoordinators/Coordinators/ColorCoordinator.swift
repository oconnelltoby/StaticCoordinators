struct ColorCoordinator<
    NavigationController: AnyObject & NavigationControlling<ViewController>,
    ViewController: AnyObject & ViewControlling<ViewController>,
    ScreenFactory: ColorScreenFactoryProtocol<ViewController>
> {
    struct Configuration {
        weak var navigationController: NavigationController?
        var screenFactory: ScreenFactory
        var analyticsTracker: AnalyticsTracking
    }
    
    static func start(configuration: Configuration) {
        pushRedScreen(configuration: configuration)
    }
    
    private static func pushRedScreen(configuration: Configuration) {
        let screen = configuration.screenFactory.red(
            analyticsTracker: configuration.analyticsTracker,
            completion: { pushGreenScreen(configuration: configuration) }
        )
        configuration.navigationController?.pushViewController(screen)
    }
    
    private static func pushGreenScreen(configuration: Configuration) {
        let screen = configuration.screenFactory.green(
            analyticsTracker: configuration.analyticsTracker,
            completion: { pushBlueScreen(configuration: configuration) }
        )
        configuration.navigationController?.pushViewController(screen)
    }
    
    private static func pushBlueScreen(configuration: Configuration) {
        var completion: (() -> Void)?
        let screen = configuration.screenFactory.blue(
            analyticsTracker: configuration.analyticsTracker,
            completion: { completion?() }
        )
        configuration.navigationController?.pushViewController(screen)
        completion = { [weak screen] in
            presentNumberCoordinator(on: screen, configuration: configuration)
        }
    }
 
    private static func presentNumberCoordinator(on presentingScreen: ViewController?, configuration: Configuration) {
        var completion: (() -> Void)?
        var dismiss: (() -> Void)?

        let screen = configuration.screenFactory.numberCoordinator(
            analyticsTracker: configuration.analyticsTracker,
            completion: { completion?() },
            dismiss: { dismiss?() }
        )
        
        presentingScreen?.present(screen)
        
        completion = {
            presentingScreen?.dismiss(animated: true) {
                configuration.navigationController?.popToRootViewController()
            }
        }
        
        dismiss = {
            presentingScreen?.dismiss()
        }
    }
}
