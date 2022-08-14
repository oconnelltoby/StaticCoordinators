@testable import StaticCoordinators

class MockNumberScreenFactoryProtocol: NumberScreenFactoryProtocol {
    typealias Pusher = MockPushing
    typealias Presenter = MockPresenting
    
    var mockOne: ((@escaping () -> Void, @escaping () -> Void) -> MockPresenting)!
    var mockTwo: ((@escaping () -> Void, @escaping () -> Void) -> MockPresenting)!
    var mockThree: ((@escaping () -> Void, @escaping () -> Void) -> MockPresenting)!
    var mockCompletionAlert: ((@escaping () -> Void) -> MockPresenting)!

    func one(completion: @escaping () -> Void, dismiss: @escaping () -> Void) -> MockPresenting {
        mockOne(completion, dismiss)
    }
    
    func two(completion: @escaping () -> Void, dismiss: @escaping () -> Void) -> MockPresenting {
        mockTwo(completion, dismiss)
    }
    
    func three(completion: @escaping () -> Void, dismiss: @escaping () -> Void) -> MockPresenting {
        mockThree(completion, dismiss)
    }
    
    func completionAlert(startAgain: @escaping () -> Void) -> MockPresenting {
        mockCompletionAlert(startAgain)
    }
}
