@testable import StaticCoordinators

class MockPushing: Pushing, Equatable {
    var mockPush: ((MockPresenting, Bool) -> Void)!
    var mockPopTo: ((MockPresenting, Bool) -> Void)!
    var mockPop: ((Bool) -> Void)!
    var mockPopToRoot: ((Bool) -> Void)!
    var mockSetPresenters: (([MockPresenting], Bool) -> Void)!
    var mockPresenters: [MockPresenting]!
    
    var presenters: [MockPresenting] {
        mockPresenters
    }

    func push(presenter: MockPresenting, animated: Bool) {
        mockPush(presenter, animated)
    }
    
    func pop(animated: Bool) {
        mockPop(animated)
    }
    
    func popToRoot(animated: Bool) {
        mockPopToRoot(animated)
    }
    
    func popTo(presenter: MockPresenting, animated: Bool) {
        mockPopTo(presenter, animated)
    }
    
    func setPresenters(_ presenters: [MockPresenting], animated: Bool) {
        mockSetPresenters(presenters, animated)
    }
    
    static func == (lhs: MockPushing, rhs: MockPushing) -> Bool {
        lhs === rhs
    }
}
