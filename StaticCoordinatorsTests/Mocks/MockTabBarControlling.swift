@testable import StaticCoordinators

class MockTabBarControlling: TabBarControlling, Equatable {
    var mockSetViewControllers: (([MockViewControlling]?, Bool) -> Void)!
    var mockViewControllers: [MockViewControlling]?!
    var mockPresent: ((MockViewControlling, Bool, (() -> Void)?) -> Void)!
    var mockDismiss: ((Bool, (() -> Void)?) -> Void)!
    
    var viewControllers: [MockViewControlling]? {
        mockViewControllers
    }
    
    func setViewControllers(_ viewControllers: [MockViewControlling]?, animated: Bool) {
        mockSetViewControllers(viewControllers, animated)
    }
    
    func present(_ viewController: MockViewControlling, animated: Bool, completion: (() -> Void)?) {
        mockPresent(viewController, animated, completion)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        mockDismiss(animated, completion)
    }
    
    static func == (lhs: MockTabBarControlling, rhs: MockTabBarControlling) -> Bool {
        lhs === rhs
    }
}
