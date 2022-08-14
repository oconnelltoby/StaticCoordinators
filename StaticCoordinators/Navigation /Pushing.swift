protocol Pushing {
    associatedtype Presenter: Presenting
    
    func push(presenter: Presenter)
    func popToRoot()
    func pop()
}
