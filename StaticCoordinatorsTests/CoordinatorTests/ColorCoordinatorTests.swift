import XCTest
@testable import StaticCoordinators

class ColorCoordinatorTests: XCTestCase {
    var screenFactory: MockColorScreenFactoryProtocol!
    var navigationController: MockNavigationControlling!
    var configuration: ColorCoordinator<MockNavigationControlling, MockViewControlling, MockColorScreenFactoryProtocol>.Configuration!
    var analyticsTracker: MockAnalyticsTracking!
    
    override func setUp() {
        navigationController = .init()
        screenFactory = .init()
        analyticsTracker = .init()
        configuration = .init(navigationController: navigationController, screenFactory: screenFactory, analyticsTracker: analyticsTracker)
    }

    func testRed() {
        // Given
        let testScreen = MockViewControlling()
        var screen: MockViewControlling?

        screenFactory.mockRed = { _, _ in testScreen }
        navigationController.mockPushViewController = { mockScreen, _ in screen = mockScreen }

        // When
        ColorCoordinator.start(configuration: configuration)

        // Then
        XCTAssertEqual(screen, testScreen)
    }
    
    func testGreen() {
        // Given
        let testScreen = MockViewControlling()
        var screen: MockViewControlling?
        let completeRed = setupRedCompletion()
        
        screenFactory.mockGreen = { _, _ in testScreen }
        navigationController.mockPushViewController = { mockScreen, _ in screen = mockScreen }

        // When
        ColorCoordinator.start(configuration: configuration)
        completeRed()

        // Then
        XCTAssertEqual(screen, testScreen)
    }

    func testBlue() {
        // Given
        let testScreen = MockViewControlling()
        var screen: MockViewControlling?
        let completeRed = setupRedCompletion()
        let completeGreen = setupGreenCompletion()
        
        screenFactory.mockBlue = { _, _ in testScreen }
        navigationController.mockPushViewController = { mockScreen, _ in screen = mockScreen }

        // When
        ColorCoordinator.start(configuration: configuration)
        completeRed()
        completeGreen()
        
        // Then
        XCTAssertEqual(screen, testScreen)
    }

    func testNumberCoordinator() {
        // Given
        let presentingScreen = MockViewControlling()
        let presentedScreen = MockViewControlling()
        var screen: MockViewControlling?
        let completeRed = setupRedCompletion()
        let completeGreen = setupGreenCompletion()
        let completeBlue = setupBlueCompletion(with: presentingScreen)

        navigationController.mockPushViewController = { _, _ in }
        screenFactory.mockNumberCoordinator = { _, _, _ in presentedScreen }
        presentingScreen.mockPresent = { mockScreen, _, _ in screen = mockScreen }

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
        let presentingScreen = MockViewControlling()
        let completeRed = setupRedCompletion()
        let completeGreen = setupGreenCompletion()
        let completeBlue = setupBlueCompletion(with: presentingScreen)
        let completeNumberCoordinator = setupNumberCoordinatorCompletion()
        var poppedToRoot = false
        var dismissed = false
        var dismissalCompleted: (() -> Void)?

        navigationController.mockPushViewController = { _, _ in }
        presentingScreen.mockPresent = { _, _, _ in }
        presentingScreen.mockDismiss = { _, completion in
            dismissalCompleted = completion
            dismissed = true
        }
        navigationController.mockPopToRootViewController = { _ in
            poppedToRoot = true
            return nil
        }

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
        let presentingScreen = MockViewControlling()
        let completeRed = setupRedCompletion()
        let completeGreen = setupGreenCompletion()
        let completeBlue = setupBlueCompletion(with: presentingScreen)
        let dismissNumberCoordinator = setupNumberCoordinatorDismiss()
        var dismissed = false

        navigationController.mockPushViewController = { _, _ in }
        presentingScreen.mockPresent = { _, _, _ in }
        presentingScreen.mockDismiss = { _, _ in dismissed = true  }

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
            return MockViewControlling()
        }
        
        return { completion?() }
    }
    
    private func setupGreenCompletion() -> () -> Void {
        var completion: (() -> Void)?
        
        screenFactory.mockGreen = { _, mockCompletion in
            completion = mockCompletion
            return MockViewControlling()
        }
        
        return { completion?() }
    }
    
    private func setupBlueCompletion(with presenting: MockViewControlling = .init()) -> () -> Void {
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
            return MockViewControlling()
        }
        
        return { completion?() }
    }
    
    private func setupNumberCoordinatorDismiss() -> () -> Void {
        var dismiss: (() -> Void)?
        
        screenFactory.mockNumberCoordinator = { _, _, mockDismiss in
            dismiss = mockDismiss
            return MockViewControlling()
        }
        
        return { dismiss?() }
    }
}
