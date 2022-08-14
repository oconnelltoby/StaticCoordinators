@testable import StaticCoordinators

class MockPushing: Pushing, Equatable {
    var mockPush: ((MockPresenting) -> Void)!
    var mockPop: (() -> Void)!
    var mockPopToRoot: (() -> Void)!

    func push(presenter: MockPresenting) {
        mockPush(presenter)
    }
    
    func pop() {
        mockPop()
    }
    
    func popToRoot() {
        mockPopToRoot()
    }
    
    static func == (lhs: MockPushing, rhs: MockPushing) -> Bool {
        lhs === rhs
    }
}
