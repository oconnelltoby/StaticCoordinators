@testable import StaticCoordinators

class MockNumberScreenFactoryProtocol: NumberScreenFactoryProtocol {
    typealias Pusher = MockPushing
    typealias Presenter = MockPresenting
    
    var mockOne: ((AnalyticsTracking, @escaping () -> Void, @escaping () -> Void) -> MockPresenting)!
    var mockTwo: ((AnalyticsTracking, @escaping () -> Void, @escaping () -> Void) -> MockPresenting)!
    var mockThree: ((AnalyticsTracking, @escaping () -> Void, @escaping () -> Void) -> MockPresenting)!
    var mockCompletionAlert: ((@escaping () -> Void) -> MockPresenting)!

    func one(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> MockPresenting {
        mockOne(analyticsTracker, completion, dismiss)
    }
    
    func two(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> MockPresenting {
        mockTwo(analyticsTracker, completion, dismiss)
    }
    
    func three(
        analyticsTracker: AnalyticsTracking,
        completion: @escaping () -> Void,
        dismiss: @escaping () -> Void
    ) -> MockPresenting {
        mockThree(analyticsTracker, completion, dismiss)
    }
    
    func completionAlert(startAgain: @escaping () -> Void) -> MockPresenting {
        mockCompletionAlert(startAgain)
    }
}
