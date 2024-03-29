import Navigation
import Analytics
import UIKit

public protocol NumberScreenBuilding<ViewController> {
    associatedtype ViewController: ViewControlling
    
    func one(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> ViewController
    
    func two(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> ViewController
    
    func three(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> ViewController
    
    func completionAlert(startAgain: @escaping () -> Void) -> ViewController
}

public struct NumberScreenBuilder: NumberScreenBuilding {
    public typealias ViewController = UIViewController
    
    public init() {}
    
    public func one(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> UIViewController {
        NumberViewController(
            viewModel: .init(number: 1, analyticsTracker: analyticsTracker, completion: completion, dismiss: dismiss)
        )
    }
    
    public func two(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> UIViewController {
        NumberViewController(
            viewModel: .init(number: 2, analyticsTracker: analyticsTracker, completion: completion, dismiss: dismiss)
        )
    }
    
    public func three(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> UIViewController {
        NumberViewController(
            viewModel: .init(number: 3, analyticsTracker: analyticsTracker, completion: completion, dismiss: dismiss)
        )
    }
    
    public func completionAlert(startAgain: @escaping () -> Void) -> UIViewController {
        let alertController = UIAlertController(title: "Reached the end!", message: nil, preferredStyle: .alert)
        alertController.addAction(.init(title: "Ok", style: .default, handler: { _ in }))
        alertController.addAction(.init(title: "Start again", style: .default, handler: { _ in startAgain() }))
        return alertController
    }
}
