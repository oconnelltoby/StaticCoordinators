import UIKit

protocol ColorScreenBuilding<ViewController> {
    associatedtype ViewController: ViewControlling
    
    func red(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> ViewController
    func green(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> ViewController
    func blue(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> ViewController
    func numberCoordinator(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> ViewController
}

struct ColorScreenBuilder: ColorScreenBuilding {
    typealias ViewController = UIViewController
    
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
    ) -> UIViewController {
        let navigationController = UINavigationController()
        
        let configuration = NumberCoordinator.Configuration(
            navigationController: navigationController,
            screenBuilder: NumberScreenBuilder(),
            analyticsTracker: analyticsTracker,
            completion: completion,
            dismiss: dismiss
        )
        
        NumberCoordinator.start(configuration: configuration)
        
        return navigationController
    }
}
