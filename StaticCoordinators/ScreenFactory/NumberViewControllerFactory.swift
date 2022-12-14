import UIKit

protocol NumberScreenFactoryProtocol {
    associatedtype Pusher: Pushing
    associatedtype Presenter: Presenting
    
    func one(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> Presenter
    
    func two(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> Presenter
    
    func three(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> Presenter
    
    func completionAlert(startAgain: @escaping () -> Void) -> Presenter
}

struct NumberViewControllerFactory: NumberScreenFactoryProtocol {
    typealias Presenter = UIViewController
    typealias Pusher = UINavigationController
    
    func one(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> UIViewController {
        NumberViewController(
            viewModel: .init(number: 1, analyticsTracker: analyticsTracker, completion: completion, dismiss: dismiss)
        )
    }
    
    func two(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> UIViewController {
        NumberViewController(
            viewModel: .init(number: 2, analyticsTracker: analyticsTracker, completion: completion, dismiss: dismiss)
        )
    }
    
    func three(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> UIViewController {
        NumberViewController(
            viewModel: .init(number: 3, analyticsTracker: analyticsTracker, completion: completion, dismiss: dismiss)
        )
    }
    
    func completionAlert(startAgain: @escaping () -> Void) -> UIViewController {
        let alertController = UIAlertController(title: "Reached the end!", message: nil, preferredStyle: .alert)
        alertController.addAction(.init(title: "Ok", style: .default, handler: { _ in }))
        alertController.addAction(.init(title: "Start again", style: .default, handler: { _ in startAgain() }))
        return alertController
    }
}
