@testable import StaticCoordinators

class MockPresenting: Presenting, Equatable {
    var mockPresentPresenter: ((MockPresenting, (() -> Void)?) -> Void)!
    var mockPresentPusher: ((MockPushing, (() -> Void)?) -> Void)!
    var mockDismiss: (((() -> Void)?) -> Void)!
    
    func present(presenter: MockPresenting, completion: (() -> Void)?) {
        mockPresentPresenter(presenter, completion)
    }
    
    func present(pusher: MockPushing, completion: (() -> Void)?) {
        mockPresentPusher(pusher, completion)
    }
    
    func dismiss(completion: (() -> Void)?) {
        mockDismiss(completion)
    }
    
    static func == (lhs: MockPresenting, rhs: MockPresenting) -> Bool {
        lhs === rhs
    }
}
