@testable import StaticCoordinators

class MockInitialScreenBuilding: InitialScreenBuilding {
    typealias NavigationController = MockNavigationControlling
    typealias ViewController = MockViewControlling
    
    var mockAlphabetCoordinator: ((AnalyticsTracking, @escaping () -> Void) -> MockViewControlling)!
    var mockColorCoordinator: ((NavigationController?, AnalyticsTracking) -> Void)!

    func alphabetCoordinator(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> ViewController {
        mockAlphabetCoordinator(analyticsTracker, completion)
    }
    
    func colorCoordinator(navigationCoordinator: NavigationController?, analyticsTracker: AnalyticsTracking) {
        mockColorCoordinator(navigationCoordinator, analyticsTracker)
    }
}
