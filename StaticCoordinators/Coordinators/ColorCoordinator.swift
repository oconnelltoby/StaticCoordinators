struct ColorCoordinator<
    NavigationController: AnyObject & NavigationControlling<ViewController>,
    ViewController: AnyObject & ViewControlling<ViewController>,
    ScreenBuilder: ColorScreenBuilding<ViewController>
> {
    struct Configuration {
        weak var navigationController: NavigationController?
        var screenBuilder: ScreenBuilder
        var analyticsTracker: AnalyticsTracking
    }
    
    static func start(configuration: Configuration) {
        pushRedScreen(configuration: configuration)
    }
    
    private static func pushRedScreen(configuration: Configuration) {
        let screen = configuration.screenBuilder.red(
            analyticsTracker: configuration.analyticsTracker,
            completion: { pushGreenScreen(configuration: configuration) }
        )
        configuration.navigationController?.pushViewController(screen)
    }
    
    private static func pushGreenScreen(configuration: Configuration) {
        let screen = configuration.screenBuilder.green(
            analyticsTracker: configuration.analyticsTracker,
            completion: { pushBlueScreen(configuration: configuration) }
        )
        configuration.navigationController?.pushViewController(screen)
    }
    
    private static func pushBlueScreen(configuration: Configuration) {
        var completion: (() -> Void)?
        let screen = configuration.screenBuilder.blue(
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

        let screen = configuration.screenBuilder.numberCoordinator(
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
