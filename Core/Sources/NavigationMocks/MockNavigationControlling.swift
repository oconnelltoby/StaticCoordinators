import Navigation

public class MockNavigationControlling: NavigationControlling, Equatable {
    public typealias ViewController = MockViewControlling
    
    public init() {}
    
    public var mockPushViewController: ((MockViewControlling, Bool) -> Void)!
    public var mockPopToViewController: ((MockViewControlling, Bool) -> [MockViewControlling]?)!
    public var mockPopViewController: ((Bool) -> MockViewControlling?)!
    public var mockPopToRootViewController: ((Bool) -> [MockViewControlling]?)!
    public var mockSetViewControllers: (([MockViewControlling], Bool) -> Void)!
    public var mockViewControllers: [MockViewControlling]!
    public var mockPresent: ((MockViewControlling, Bool, (() -> Void)?) -> Void)!
    public var mockDismiss: ((Bool, (() -> Void)?) -> Void)!
    
    public var viewControllers: [MockViewControlling] {
        mockViewControllers
    }

    public func pushViewController(_ viewController: MockViewControlling, animated: Bool) {
        mockPushViewController(viewController, animated)
    }
    
    public func popToViewController(_ viewController: MockViewControlling, animated: Bool) -> [MockViewControlling]? {
        mockPopToViewController(viewController, animated)
    }
    
    public func popViewController(animated: Bool) -> MockViewControlling? {
        mockPopViewController(animated)
    }
    
    public func popToRootViewController(animated: Bool) -> [MockViewControlling]? {
        mockPopToRootViewController(animated)
    }
    
    public func present(_ viewController: MockViewControlling, animated: Bool, completion: (() -> Void)?) {
        mockPresent(viewController, animated, completion)
    }
    
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        mockDismiss(animated, completion)
    }
    
    public func setViewControllers(_ viewControllers: [MockViewControlling], animated: Bool) {
        mockSetViewControllers(viewControllers, animated)
    }
    
    public static func == (lhs: MockNavigationControlling, rhs: MockNavigationControlling) -> Bool {
        lhs === rhs
    }
}
