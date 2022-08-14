struct ColorCoordinator<Pusher: AnyObject, Presenter: AnyObject, ScreenFactory: ColorScreenFactoryProtocol> where
    Pusher.Presenter == Presenter,
    Presenter.Presenter == Presenter,
    Presenter.Pusher == Pusher,
    ScreenFactory.Pusher == Pusher,
    ScreenFactory.Presenter == Presenter
{
    struct Configuration {
        weak var pusher: Pusher?
        var screenFactory: ScreenFactory
    }
    
    static func start(configuration: Configuration) {
        pushRedScreen(configuration: configuration)
    }
    
    private static func pushRedScreen(configuration: Configuration) {
        let completion = { pushGreenScreen(configuration: configuration) }
        let screen = configuration.screenFactory.red(completion: completion)
        configuration.pusher?.push(presenter: screen)
    }
    
    private static func pushGreenScreen(configuration: Configuration) {
        let completion = { pushBlueScreen(configuration: configuration) }
        let screen = configuration.screenFactory.green(completion: completion)
        configuration.pusher?.push(presenter: screen)
    }
    
    private static func pushBlueScreen(configuration: Configuration) {
        var completion: (() -> Void)?
        let screen = configuration.screenFactory.blue(completion: { completion?() })
        configuration.pusher?.push(presenter: screen)
        completion = { [weak screen] in
            presentNumberCoordinator(on: screen, configuration: configuration)
        }
    }
 
    private static func presentNumberCoordinator(on presentingScreen: Presenter?, configuration: Configuration) {
        var completion: (() -> Void)?
        var dismiss: (() -> Void)?

        let screen = configuration.screenFactory.numberCoordinator(
            completion: { completion?() },
            dismiss: { dismiss?() }
        )
        
        presentingScreen?.present(pusher: screen)
        
        completion = {
            presentingScreen?.dismiss {
                configuration.pusher?.popToRoot()
            }
        }
        
        dismiss = {
            presentingScreen?.dismiss()
        }
    }
}
