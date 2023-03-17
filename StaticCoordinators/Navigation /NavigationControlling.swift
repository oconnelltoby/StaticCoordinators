protocol NavigationControlling<ViewController>: ViewControlling {
    func pushViewController(_ viewController: ViewController, animated: Bool)
    @discardableResult
    func popToRootViewController(animated: Bool) -> [ViewController]?
    @discardableResult
    func popViewController(animated: Bool) -> ViewController?
    @discardableResult
    func popToViewController(_ viewController: ViewController, animated: Bool) -> [ViewController]?
    func setViewControllers(_ viewControllers: [ViewController], animated: Bool)
    var viewControllers: [ViewController] { get }
}

extension NavigationControlling {
    func pushViewController(_ viewController: ViewController) {
        pushViewController(viewController, animated: true)
    }
    
    @discardableResult
    func popToRootViewController() -> [ViewController]? {
        popToRootViewController(animated: true)
    }
    
    @discardableResult
    func popViewController() -> ViewController? {
        popViewController(animated: true)
    }
    
    @discardableResult
    func popToViewcontroller(viewController: ViewController) -> [ViewController]? {
        popToViewController(viewController, animated: true)
    }
    
    func setViewControllers(_ viewControllers: [ViewController]) {
        setViewControllers(viewControllers, animated: true)
    }
}
