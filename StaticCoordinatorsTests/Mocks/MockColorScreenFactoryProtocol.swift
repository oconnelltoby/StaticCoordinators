@testable import StaticCoordinators

class MockColorScreenFactoryProtocol: ColorScreenFactoryProtocol {
    typealias Pusher = MockPushing
    typealias Presenter = MockPresenting
    
    var mockRed: ((AnalyticsTracking, @escaping () -> Void) -> MockPresenting)!
    var mockGreen: ((AnalyticsTracking, @escaping () -> Void) -> MockPresenting)!
    var mockBlue: ((AnalyticsTracking, @escaping () -> Void) -> MockPresenting)!
    var mockNumberCoordinator: ((AnalyticsTracking, @escaping () -> Void, @escaping () -> Void) -> MockPushing)!

    func red(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> MockPresenting {
        mockRed(analyticsTracker, completion)
    }
    
    func green(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> MockPresenting {
        mockGreen(analyticsTracker, completion)
    }
    
    func blue(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> MockPresenting {
        mockBlue(analyticsTracker, completion)
    }
    
    func numberCoordinator(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void, dismiss: @escaping () -> Void) -> MockPushing {
        mockNumberCoordinator(analyticsTracker, completion, dismiss)
    }
}
