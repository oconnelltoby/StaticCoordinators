import UIKit

protocol AlphabetScreenBuilding<ViewController> {
    associatedtype ViewController: ViewControlling
    
    func alphabetA(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> ViewController
    func alphabetB(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> ViewController
    func alphabetC(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> ViewController
}

struct AlphabetScreenBuilder: AlphabetScreenBuilding {
    typealias NavigationController = UINavigationController
    typealias ViewController = UIViewController

    func alphabetA(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> ViewController {
        AlphabetViewController(
            viewModel: .init(character: "A", analyticsTracker: analyticsTracker, completion: completion)
        )
    }
    
    func alphabetB(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> ViewController {
        AlphabetViewController(
            viewModel: .init(character: "B", analyticsTracker: analyticsTracker, completion: completion)
        )
    }
    
    func alphabetC(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> ViewController {
        AlphabetViewController(
            viewModel: .init(character: "C", analyticsTracker: analyticsTracker, completion: completion)
        )
    }
}
