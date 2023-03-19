import Navigation
import Analytics
import UIKit

public protocol AlphabetScreenBuilding<ViewController> {
    associatedtype ViewController: ViewControlling
    
    func alphabetA(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> ViewController
    func alphabetB(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> ViewController
    func alphabetC(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> ViewController
}

public struct AlphabetScreenBuilder: AlphabetScreenBuilding {
    public typealias NavigationController = UINavigationController
    public typealias ViewController = UIViewController
    
    public init() {}

    public func alphabetA(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> ViewController {
        AlphabetViewController(
            viewModel: .init(character: "A", analyticsTracker: analyticsTracker, completion: completion)
        )
    }
    
    public func alphabetB(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> ViewController {
        AlphabetViewController(
            viewModel: .init(character: "B", analyticsTracker: analyticsTracker, completion: completion)
        )
    }
    
    public func alphabetC(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> ViewController {
        AlphabetViewController(
            viewModel: .init(character: "C", analyticsTracker: analyticsTracker, completion: completion)
        )
    }
}
