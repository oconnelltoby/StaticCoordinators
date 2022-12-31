import XCTest
@testable import StaticCoordinators

class ColorCoordinatorTests: XCTestCase {
    var screenFactory: MockColorScreenFactoryProtocol!
    var pusher: MockPushing!
    var configuration: ColorCoordinator<MockPushing, MockPresenting, MockColorScreenFactoryProtocol>.Configuration!
    var analyticsTracker: MockAnalyticsTracking!
    
    override func setUp() {
        pusher = .init()
        screenFactory = .init()
        analyticsTracker = .init()
        configuration = .init(pusher: pusher, screenFactory: screenFactory, analyticsTracker: analyticsTracker)
    }

    func testRed() {
        // Given
        let testScreen = MockPresenting()
        var screen: MockPresenting?

        screenFactory.mockRed = { _, _ in testScreen }
        pusher.mockPush = { mockScreen, _ in screen = mockScreen }

        // When
        ColorCoordinator.start(configuration: configuration)

        // Then
        XCTAssertEqual(screen, testScreen)
    }
    
    func testGreen() {
        // Given
        let testScreen = MockPresenting()
        var screen: MockPresenting?
        let completeRed = setupRedCompletion()
        
        screenFactory.mockGreen = { _, _ in testScreen }
        pusher.mockPush = { mockScreen, _ in screen = mockScreen }

        // When
        ColorCoordinator.start(configuration: configuration)
        completeRed()

        // Then
        XCTAssertEqual(screen, testScreen)
    }

    func testBlue() {
        // Given
        let testScreen = MockPresenting()
        var screen: MockPresenting?
        let completeRed = setupRedCompletion()
        let completeGreen = setupGreenCompletion()
        
        screenFactory.mockBlue = { _, _ in testScreen }
        pusher.mockPush = { mockScreen, _ in screen = mockScreen }

        // When
        ColorCoordinator.start(configuration: configuration)
        completeRed()
        completeGreen()
        
        // Then
        XCTAssertEqual(screen, testScreen)
    }

    func testNumberCoordinator() {
        // Given
        let presentingScreen = MockPresenting()
        let presentedScreen = MockPushing()
        var screen: MockPushing?
        let completeRed = setupRedCompletion()
        let completeGreen = setupGreenCompletion()
        let completeBlue = setupBlueCompletion(with: presentingScreen)

        pusher.mockPush = { _, _ in }
        screenFactory.mockNumberCoordinator = { _, _, _ in presentedScreen }
        presentingScreen.mockPresentPusher = { mockScreen, _ in screen = mockScreen }

        // When
        ColorCoordinator.start(configuration: configuration)
        completeRed()
        completeGreen()
        completeBlue()

        // Then
        XCTAssertEqual(screen, presentedScreen)
    }
    
    func testNumberCoordinatorCompletion() {
        // Given
        let presentingScreen = MockPresenting()
        let completeRed = setupRedCompletion()
        let completeGreen = setupGreenCompletion()
        let completeBlue = setupBlueCompletion(with: presentingScreen)
        let completeNumberCoordinator = setupNumberCoordinatorCompletion()
        var poppedToRoot = false
        var dismissed = false
        var dismissalCompleted: (() -> Void)?

        pusher.mockPush = { _, _ in }
        presentingScreen.mockPresentPusher = { _, _ in }
        presentingScreen.mockDismiss = {
            dismissalCompleted = $0
            dismissed = true
        }
        pusher.mockPopToRoot = { _ in poppedToRoot = true }

        // When
        ColorCoordinator.start(configuration: configuration)
        completeRed()
        completeGreen()
        completeBlue()
        completeNumberCoordinator()
        dismissalCompleted?()

        // Then
        XCTAssertTrue(dismissed)
        XCTAssertTrue(poppedToRoot)
    }
    
    func testNumberCoordinatorDismiss() {
        // Given
        let presentingScreen = MockPresenting()
        let completeRed = setupRedCompletion()
        let completeGreen = setupGreenCompletion()
        let completeBlue = setupBlueCompletion(with: presentingScreen)
        let dismissNumberCoordinator = setupNumberCoordinatorDismiss()
        var dismissed = false

        pusher.mockPush = { _, _ in }
        presentingScreen.mockPresentPusher = { _, _ in }
        presentingScreen.mockDismiss = { _ in dismissed = true  }

        // When
        ColorCoordinator.start(configuration: configuration)
        completeRed()
        completeGreen()
        completeBlue()
        dismissNumberCoordinator()

        // Then
        XCTAssertTrue(dismissed)
    }
}

extension ColorCoordinatorTests {
    private func setupRedCompletion() -> () -> Void {
        var completion: (() -> Void)?
        
        screenFactory.mockRed = { _, mockCompletion in
            completion = mockCompletion
            return MockPresenting()
        }
        
        return { completion?() }
    }
    
    private func setupGreenCompletion() -> () -> Void {
        var completion: (() -> Void)?
        
        screenFactory.mockGreen = { _, mockCompletion in
            completion = mockCompletion
            return MockPresenting()
        }
        
        return { completion?() }
    }
    
    private func setupBlueCompletion(with presenting: MockPresenting = .init()) -> () -> Void {
        var completion: (() -> Void)?
        
        screenFactory.mockBlue = { _, mockCompletion in
            completion = mockCompletion
            return presenting
        }
        
        return { completion?() }
    }
    
    private func setupNumberCoordinatorCompletion() -> () -> Void {
        var completion: (() -> Void)?
        
        screenFactory.mockNumberCoordinator = { _, mockCompletion, _ in
            completion = mockCompletion
            return MockPushing()
        }
        
        return { completion?() }
    }
    
    private func setupNumberCoordinatorDismiss() -> () -> Void {
        var dismiss: (() -> Void)?
        
        screenFactory.mockNumberCoordinator = { _, _, mockDismiss in
            dismiss = mockDismiss
            return MockPushing()
        }
        
        return { dismiss?() }
    }
}
