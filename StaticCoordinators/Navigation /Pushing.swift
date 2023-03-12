protocol Pushing<Presenter> {
    associatedtype Presenter: Presenting
    
    func push(presenter: Presenter, animated: Bool)
    func popToRoot(animated: Bool)
    func pop(animated: Bool)
    func popTo(presenter: Presenter, animated: Bool)
    func setPresenters(_ presenters: [Presenter], animated: Bool)
    var presenters: [Presenter] { get }
}

extension Pushing {
    func push(presenter: Presenter) {
        push(presenter: presenter, animated: true)
    }
    
    func popToRoot() {
        popToRoot(animated: true)
    }
    
    func pop() {
        pop(animated: true)
    }
    
    func popTo(presenter: Presenter) {
        popTo(presenter: presenter, animated: true)
    }
    
    func setPresenters(_ presenters: [Presenter]) {
        setPresenters(presenters, animated: true)
    }
}
