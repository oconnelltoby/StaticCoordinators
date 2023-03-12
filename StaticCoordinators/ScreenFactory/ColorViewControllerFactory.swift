import UIKit

protocol ColorScreenFactoryProtocol<Pusher, Presenter> {
    associatedtype Pusher: Pushing
    associatedtype Presenter: Presenting
    
    func red(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> Presenter
    func green(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> Presenter
    func blue(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> Presenter
    func numberCoordinator(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> Pusher
}

struct ColorViewControllerFactory: ColorScreenFactoryProtocol {
    typealias Presenter = UIViewController
    typealias Pusher = UINavigationController
    
    func red(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> UIViewController {
        ColorViewController(viewModel: .init(style: .red, analyticsTracker: analyticsTracker, completion: completion))
    }
    
    func green(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> UIViewController {
        ColorViewController(viewModel: .init(style: .green, analyticsTracker: analyticsTracker, completion: completion))
    }
    
    func blue(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> UIViewController {
        ColorViewController(viewModel: .init(style: .blue, analyticsTracker: analyticsTracker, completion: completion))
    }
    
    func numberCoordinator(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> UINavigationController {
        let navigationController = UINavigationController()
        
        let configuration = NumberCoordinator.Configuration(
            pusher: navigationController,
            screenFactory: NumberViewControllerFactory(),
            analyticsTracker: analyticsTracker,
            completion: completion,
            dismiss: dismiss
        )
        
        NumberCoordinator.start(configuration: configuration)
        
        return navigationController
    }
}
