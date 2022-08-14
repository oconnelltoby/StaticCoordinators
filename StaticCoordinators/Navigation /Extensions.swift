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
    func push(presenter: UIViewController) {
        pushViewController(presenter, animated: true)
    }
    
    func pop() {
        popViewController(animated: true)
    }
    
    func popToRoot() {
        popToRootViewController(animated: true)
    }
}
