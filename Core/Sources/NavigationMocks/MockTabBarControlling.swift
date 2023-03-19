import Navigation

public class MockTabBarControlling: TabBarControlling, Equatable {
    public init() {}
    
    public var mockSetViewControllers: (([MockViewControlling]?, Bool) -> Void)!
    public var mockViewControllers: [MockViewControlling]?!
    public var mockPresent: ((MockViewControlling, Bool, (() -> Void)?) -> Void)!
    public var mockDismiss: ((Bool, (() -> Void)?) -> Void)!
    
    public var viewControllers: [MockViewControlling]? {
        mockViewControllers
    }
    
    public func setViewControllers(_ viewControllers: [MockViewControlling]?, animated: Bool) {
        mockSetViewControllers(viewControllers, animated)
    }
    
    public func present(_ viewController: MockViewControlling, animated: Bool, completion: (() -> Void)?) {
        mockPresent(viewController, animated, completion)
    }
    
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        mockDismiss(animated, completion)
    }
    
    public static func == (lhs: MockTabBarControlling, rhs: MockTabBarControlling) -> Bool {
        lhs === rhs
    }
}
