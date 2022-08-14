@testable import StaticCoordinators

class MockColorScreenFactoryProtocol: ColorScreenFactoryProtocol {
    typealias Pusher = MockPushing
    typealias Presenter = MockPresenting
    
    var mockRed: ((@escaping () -> Void) -> MockPresenting)!
    var mockGreen: ((@escaping () -> Void) -> MockPresenting)!
    var mockBlue: ((@escaping () -> Void) -> MockPresenting)!
    var mockNumberCoordinator: ((@escaping () -> Void, @escaping () -> Void) -> MockPushing)!

    func red(completion: @escaping () -> Void) -> MockPresenting {
        mockRed(completion)
    }
    
    func green(completion: @escaping () -> Void) -> MockPresenting {
        mockGreen(completion)
    }
    
    func blue(completion: @escaping () -> Void) -> MockPresenting {
        mockBlue(completion)
    }
    
    func numberCoordinator(completion: @escaping () -> Void, dismiss: @escaping () -> Void) -> MockPushing {
        mockNumberCoordinator(completion, dismiss)
    }
}
