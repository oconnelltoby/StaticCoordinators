import UIKit

extension UIViewController: Presenting {
    func present(presenter: UIViewController, completion: (() -> Void)?) {
        present(presenter, animated: true, completion: completion)
    }
    
    func present(pusher: UINavigationController, completion: (() -> Void)?) {
        present(pusher, animated: true, completion: completion)
    }
    
    func dismiss(completion: (() -> Void)?) {
        dismiss(animated: true, completion: completion)
    }
}

extension UINavigationController: Pushing {
    func push(presenter: UIViewController, animated: Bool) {
        pushViewController(presenter, animated: animated)
    }
    
    func pop(animated: Bool) {
        popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        popToRootViewController(animated: animated)
    }
    
    func popTo(presenter: UIViewController, animated: Bool) {
        popToViewController(presenter, animated: animated)
    }
    
    func setPresenters(_ presenters: [UIViewController], animated: Bool) {
        setViewControllers(presenters, animated: animated)
    }
    
    var presenters: [UIViewController] {
        viewControllers
    }
}
