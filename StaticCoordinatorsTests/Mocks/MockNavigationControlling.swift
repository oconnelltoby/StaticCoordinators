@testable import StaticCoordinators

class MockNavigationControlling: NavigationControlling, Equatable {
    typealias ViewController = MockViewControlling
    
    var mockPushViewController: ((MockViewControlling, Bool) -> Void)!
    var mockPopToViewController: ((MockViewControlling, Bool) -> [MockViewControlling]?)!
    var mockPopViewController: ((Bool) -> MockViewControlling?)!
    var mockPopToRootViewController: ((Bool) -> [MockViewControlling]?)!
    var mockSetViewControllers: (([MockViewControlling], Bool) -> Void)!
    var mockViewControllers: [MockViewControlling]!
    var mockPresent: ((MockViewControlling, Bool, (() -> Void)?) -> Void)!
    var mockDismiss: ((Bool, (() -> Void)?) -> Void)!
    
    var viewControllers: [MockViewControlling] {
        mockViewControllers
    }

    func pushViewController(_ viewController: MockViewControlling, animated: Bool) {
        mockPushViewController(viewController, animated)
    }
    
    func popToViewController(_ viewController: MockViewControlling, animated: Bool) -> [MockViewControlling]? {
        mockPopToViewController(viewController, animated)
    }
    
    func popViewController(animated: Bool) -> MockViewControlling? {
        mockPopViewController(animated)
    }
    
    func popToRootViewController(animated: Bool) -> [MockViewControlling]? {
        mockPopToRootViewController(animated)
    }
    
    func present(_ viewController: MockViewControlling, animated: Bool, completion: (() -> Void)?) {
        mockPresent(viewController, animated, completion)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        mockDismiss(animated, completion)
    }
    
    func setViewControllers(_ viewControllers: [MockViewControlling], animated: Bool) {
        mockSetViewControllers(viewControllers, animated)
    }
    
    static func == (lhs: MockNavigationControlling, rhs: MockNavigationControlling) -> Bool {
        lhs === rhs
    }
}
