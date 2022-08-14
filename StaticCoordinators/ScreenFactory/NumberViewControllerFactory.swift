import UIKit

protocol NumberScreenFactoryProtocol {
    associatedtype Pusher: Pushing
    associatedtype Presenter: Presenting
    
    func one(completion: @escaping () -> Void, dismiss: @escaping () -> Void) -> Presenter
    func two(completion: @escaping () -> Void, dismiss: @escaping () -> Void) -> Presenter
    func three(completion: @escaping () -> Void, dismiss: @escaping () -> Void) -> Presenter
    func completionAlert(startAgain: @escaping () -> Void) -> Presenter
}

struct NumberViewControllerFactory: NumberScreenFactoryProtocol {
    typealias Presenter = UIViewController
    typealias Pusher = UINavigationController
    
    func one(completion: @escaping () -> Void, dismiss: @escaping () -> Void) -> UIViewController {
        NumberViewController(viewModel: .init(number: 1, completion: completion, dismiss: dismiss))
    }
    
    func two(completion: @escaping () -> Void, dismiss: @escaping () -> Void) -> UIViewController {
        NumberViewController(viewModel: .init(number: 2, completion: completion, dismiss: dismiss))
    }
    
    func three(completion: @escaping () -> Void, dismiss: @escaping () -> Void) -> UIViewController {
        NumberViewController(viewModel: .init(number: 3, completion: completion, dismiss: dismiss))
    }
    
    func completionAlert(startAgain: @escaping () -> Void) -> UIViewController {
        let alertController = UIAlertController(title: "Reached the end!", message: nil, preferredStyle: .alert)
        alertController.addAction(.init(title: "Ok", style: .default, handler: { _ in }))
        alertController.addAction(.init(title: "Start again", style: .default, handler: { _ in startAgain() }))
        return alertController
    }
}
