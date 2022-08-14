struct NumberCoordinator<Pusher: AnyObject, Presenter: AnyObject, ScreenFactory: NumberScreenFactoryProtocol> where
    Pusher.Presenter == Presenter,
    Presenter.Presenter == Presenter,
    Presenter.Pusher == Pusher,
    ScreenFactory.Pusher == Pusher,
    ScreenFactory.Presenter == Presenter
{
    struct Configuration {
        weak var pusher: Pusher?
        var screenFactory: ScreenFactory
        var completion: () -> Void
        var dismiss: () -> Void
    }
    
    static func start(configuration: Configuration) {
        pushOneScreen(configuration: configuration)
    }
    
    static func pushOneScreen(configuration: Configuration) {
        let completion = { pushTwoScreen(configuration: configuration) }
        let screen = configuration.screenFactory.one(completion: completion, dismiss: configuration.dismiss)
        configuration.pusher?.push(presenter: screen)
    }
    
    static func pushTwoScreen(configuration: Configuration) {
        let completion = { pushThreeScreen(configuration: configuration) }
        let screen = configuration.screenFactory.two(completion: completion, dismiss: configuration.dismiss)
        configuration.pusher?.push(presenter: screen)
    }
    
    static func pushThreeScreen(configuration: Configuration) {
        var completion: (() -> Void)?
        let screen = configuration.screenFactory.three(completion: { completion?() }, dismiss: configuration.dismiss)
        configuration.pusher?.push(presenter: screen)
        completion = { [weak screen] in
            presentCompletionAlert(on: screen, configuration: configuration)
        }
    }
 
    static func presentCompletionAlert(on presentingScreen: Presenter?, configuration: Configuration) {
        let screen = configuration.screenFactory.completionAlert(startAgain: configuration.completion)
        presentingScreen?.present(presenter: screen)
    }
}
