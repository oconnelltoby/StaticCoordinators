@testable import Color
import NavigationMocks
import Analytics

class MockColorScreenBuilding: ColorScreenBuilding {
    typealias NavigationController = MockNavigationControlling
    typealias ViewController = MockViewControlling
    
    var mockRed: ((AnalyticsTracking, @escaping () -> Void) -> MockViewControlling)!
    var mockGreen: ((AnalyticsTracking, @escaping () -> Void) -> MockViewControlling)!
    var mockBlue: ((AnalyticsTracking, @escaping () -> Void) -> MockViewControlling)!
    var mockNumberCoordinator: ((AnalyticsTracking, @escaping () -> Void, @escaping () -> Void) -> MockViewControlling)!

    func red(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> MockViewControlling {
        mockRed(analyticsTracker, completion)
    }
    
    func green(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> MockViewControlling {
        mockGreen(analyticsTracker, completion)
    }
    
    func blue(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> MockViewControlling {
        mockBlue(analyticsTracker, completion)
    }
    
    func numberCoordinator(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void, dismiss: @escaping () -> Void) -> MockViewControlling {
        mockNumberCoordinator(analyticsTracker, completion, dismiss)
    }
}
