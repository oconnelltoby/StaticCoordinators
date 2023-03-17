import XCTest
@testable import StaticCoordinators

class NumberCoordinatorTests: XCTestCase {
    var screenFactory: MockNumberScreenFactoryProtocol!
    var navigationController: MockNavigationControlling!
    var configuration: NumberCoordinator<MockNavigationControlling, MockViewControlling, MockNumberScreenFactoryProtocol>.Configuration!
    var analyticsTracker: MockAnalyticsTracking!
    var completion: (() -> Void)!
    var dismiss: (() -> Void)!

    override func setUp() {
        navigationController = .init()
        screenFactory = .init()
        analyticsTracker = .init()
        
        configuration = .init(
            navigationController: navigationController,
            screenFactory: screenFactory,
            analyticsTracker: analyticsTracker,
            completion: { [unowned self] in self.completion() },
            dismiss: { [unowned self] in self.dismiss() }
        )
    }

    func testOne() {
        // Given
        let testScreen = MockViewControlling()
        var screen: MockViewControlling?

        screenFactory.mockOne = { _, _, _ in testScreen }
        navigationController.mockPushViewController = { mockScreen, _ in screen = mockScreen }

        // When
        NumberCoordinator.start(configuration: configuration)

        // Then
        XCTAssertEqual(screen, testScreen)
    }
    
    func testOneDismiss() {
        // Given
        var dismiss: (() -> Void)?
        var dismissed = false

        screenFactory.mockOne = { _, _, mockDismiss in
            dismiss = mockDismiss
            return MockViewControlling()
        }
        
        self.dismiss = { dismissed = true }
        navigationController.mockPushViewController = { _, _ in }

        // When
        NumberCoordinator.start(configuration: configuration)
        dismiss?()

        // Then
        XCTAssertTrue(dismissed)
    }
    
    func testTwo() {
        // Given
        let testScreen = MockViewControlling()
        var screen: MockViewControlling?
        let completeOne = setupOneCompletion()

        screenFactory.mockTwo = { _, _, _ in testScreen }
        navigationController.mockPushViewController = { mockScreen, _ in screen = mockScreen }

        // When
        NumberCoordinator.start(configuration: configuration)
        completeOne()

        // Then
        XCTAssertEqual(screen, testScreen)
    }
    
    func testTwoDismiss() {
        // Given
        var dismiss: (() -> Void)?
        var dismissed = false
        let completeOne = setupOneCompletion()

        screenFactory.mockTwo = { _, _, mockDismiss in
            dismiss = mockDismiss
            return MockViewControlling()
        }
        
        self.dismiss = { dismissed = true }
        navigationController.mockPushViewController = { _, _ in }

        // When
        NumberCoordinator.start(configuration: configuration)
        completeOne()
        dismiss?()

        // Then
        XCTAssertTrue(dismissed)
    }

    func testThree() {
        // Given
        let testScreen = MockViewControlling()
        var screen: MockViewControlling?
        let completeOne = setupOneCompletion()
        let completeTwo = setupTwoCompletion()

        screenFactory.mockThree = { _, _, _ in testScreen }
        navigationController.mockPushViewController = { mockScreen, _ in screen = mockScreen }

        // When
        NumberCoordinator.start(configuration: configuration)
        completeOne()
        completeTwo()

        // Then
        XCTAssertEqual(screen, testScreen)
    }
    
    func testThreeDismiss() {
        // Given
        var dismiss: (() -> Void)?
        var dismissed = false
        let completeOne = setupOneCompletion()
        let completeTwo = setupTwoCompletion()

        screenFactory.mockThree = { _, _, mockDismiss in
            dismiss = mockDismiss
            return MockViewControlling()
        }
        
        self.dismiss = { dismissed = true }
        navigationController.mockPushViewController = { _, _ in }

        // When
        NumberCoordinator.start(configuration: configuration)
        completeOne()
        completeTwo()
        dismiss?()

        // Then
        XCTAssertTrue(dismissed)
    }
    
    func testCompletionAlert() {
        // Given
        let presentingScreen = MockViewControlling()
        let testScreen = MockViewControlling()
        var screen: MockViewControlling?
        let completeOne = setupOneCompletion()
        let completeTwo = setupTwoCompletion()
        let completeThree = setupThreeCompletion(with: presentingScreen)

        screenFactory.mockCompletionAlert = { _ in testScreen }
        navigationController.mockPushViewController = { _, _ in }
        presentingScreen.mockPresent = { mockScreen, _, _ in screen = mockScreen }

        // When
        NumberCoordinator.start(configuration: configuration)
        completeOne()
        completeTwo()
        completeThree()

        // Then
        XCTAssertEqual(screen, testScreen)
    }
    
    func testCompletionAlertCompletion() {
        // Given
        let presentingScreen = MockViewControlling()
        var completion: (() -> Void)?
        var completed = false
        let completeOne = setupOneCompletion()
        let completeTwo = setupTwoCompletion()
        let completeThree = setupThreeCompletion(with: presentingScreen)

        screenFactory.mockCompletionAlert = { mockCompletion in
            completion = mockCompletion
            return MockViewControlling()
        }
        
        self.completion = { completed = true }
        navigationController.mockPushViewController = { _, _ in }
        presentingScreen.mockPresent = { _, _, _ in }

        // When
        NumberCoordinator.start(configuration: configuration)
        completeOne()
        completeTwo()
        completeThree()
        completion?()

        // Then
        XCTAssertTrue(completed)
    }
}

extension NumberCoordinatorTests {
    private func setupOneCompletion() -> () -> Void {
        var completion: (() -> Void)?

        screenFactory.mockOne = { _, mockCompletion, _ in
            completion = mockCompletion
            return MockViewControlling()
        }

        return { completion?() }
    }
    
    private func setupTwoCompletion() -> () -> Void {
        var completion: (() -> Void)?

        screenFactory.mockTwo = { _, mockCompletion, _ in
            completion = mockCompletion
            return MockViewControlling()
        }

        return { completion?() }
    }
    
    private func setupThreeCompletion(with viewController: MockViewControlling = .init()) -> () -> Void {
        var completion: (() -> Void)?

        screenFactory.mockThree = { _, mockCompletion, _ in
            completion = mockCompletion
            return viewController
        }

        return { completion?() }
    }
}
