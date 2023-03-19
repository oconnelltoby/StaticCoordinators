import Navigation

public class MockViewControlling: ViewControlling, Equatable {
    public init() {}
    
    public var mockPresent: ((MockViewControlling, Bool, (() -> Void)?) -> Void)!
    public var mockDismiss: ((Bool, (() -> Void)?) -> Void)!
    
    public func present(_ viewController: MockViewControlling, animated: Bool, completion: (() -> Void)?) {
        mockPresent(viewController, animated, completion)
    }
    
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        mockDismiss(animated, completion)
    }
    
    public static func == (lhs: MockViewControlling, rhs: MockViewControlling) -> Bool {
        lhs === rhs
    }
}
