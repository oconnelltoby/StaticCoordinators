protocol Presenting {
    associatedtype Pusher: Pushing
    associatedtype Presenter: Presenting

    func present(presenter: Presenter, completion: (() -> Void)?)
    func present(pusher: Pusher, completion: (() -> Void)?)
    func dismiss(completion: (() -> Void)?)
}

extension Presenting {
    func present(presenter: Presenter) {
        present(presenter: presenter, completion: nil)
    }
    
    func present(pusher: Pusher) {
        present(pusher: pusher, completion: nil)
    }
    
    func dismiss() {
        dismiss(completion: nil)
    }
}
