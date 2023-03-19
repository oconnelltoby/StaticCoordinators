public protocol ViewControlling<ViewController> {
    associatedtype ViewController: ViewControlling

    func present(_ viewController: ViewController, animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

public extension ViewControlling {
    func present(_ viewController: ViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
