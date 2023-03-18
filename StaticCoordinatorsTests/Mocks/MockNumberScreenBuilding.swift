@testable import StaticCoordinators

class MockNumberScreenBuilding: NumberScreenBuilding {
    typealias NavigationController = MockNavigationControlling
    typealias ViewController = MockViewControlling
    
    var mockOne: ((AnalyticsTracking, @escaping () -> Void, @escaping () -> Void) -> MockViewControlling)!
    var mockTwo: ((AnalyticsTracking, @escaping () -> Void, @escaping () -> Void) -> MockViewControlling)!
    var mockThree: ((AnalyticsTracking, @escaping () -> Void, @escaping () -> Void) -> MockViewControlling)!
    var mockCompletionAlert: ((@escaping () -> Void) -> MockViewControlling)!

    func one(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> MockViewControlling {
        mockOne(analyticsTracker, completion, dismiss)
    }
    
    func two(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> MockViewControlling {
        mockTwo(analyticsTracker, completion, dismiss)
    }
    
    func three(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> MockViewControlling {
        mockThree(analyticsTracker, completion, dismiss)
    }
    
    func completionAlert(startAgain: @escaping () -> Void) -> MockViewControlling {
        mockCompletionAlert(startAgain)
    }
}
