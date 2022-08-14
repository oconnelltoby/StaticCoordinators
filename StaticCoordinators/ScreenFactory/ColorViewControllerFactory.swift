import UIKit

protocol ColorScreenFactoryProtocol {
    associatedtype Pusher: Pushing
    associatedtype Presenter: Presenting
    
    func red(completion: @escaping () -> Void) -> Presenter
    func green(completion: @escaping () -> Void) -> Presenter
    func blue(completion: @escaping () -> Void) -> Presenter
    func numberCoordinator(completion: @escaping () -> Void, dismiss: @escaping () -> Void) -> Pusher
}

struct ColorViewControllerFactory: ColorScreenFactoryProtocol {
    typealias Presenter = UIViewController
    typealias Pusher = UINavigationController
    
    func red(completion: @escaping () -> Void) -> UIViewController {
        ColorViewController(viewModel: .init(style: .red, completion: completion))
    }
    
    func green(completion: @escaping () -> Void) -> UIViewController {
        ColorViewController(viewModel: .init(style: .green, completion: completion))
    }
    
    func blue(completion: @escaping () -> Void) -> UIViewController {
        ColorViewController(viewModel: .init(style: .blue, completion: completion))
    }
    
    func numberCoordinator(completion: @escaping () -> Void, dismiss: @escaping () -> Void) -> UINavigationController {
        let navigationController = UINavigationController()
        
        let configuration = NumberCoordinator.Configuration(
            pusher: navigationController,
            screenFactory: NumberViewControllerFactory(),
            completion: completion,
            dismiss: dismiss
        )
        
        NumberCoordinator.start(configuration: configuration)
        
        return navigationController
    }
}
