import XCTest
@testable import StaticCoordinators

class NumberCoordinatorTests: XCTestCase {
    var screenBuilder: MockNumberScreenBuilding!
    var navigationController: MockNavigationControlling!
    var configuration: NumberCoordinator<MockNavigationControlling, MockViewControlling, MockNumberScreenBuilding>.Configuration!
    var analyticsTracker: MockAnalyticsTracking!
    var completion: (() -> Void)!
    var dismiss: (() -> Void)!

    override func setUp() {
        navigationController = .init()
        screenBuilder = .init()
        analyticsTracker = .init()
        
        configuration = .init(
            navigationController: navigationController,
            screenBuilder: screenBuilder,
            analyticsTracker: analyticsTracker,
            completion: { [unowned self] in self.completion() },
            dismiss: { [unowned self] in self.dismiss() }
        )
    }

    func testOne() {
        // Given
        let testScreen = MockViewControlling()
        var screen: MockViewControlling?

        screenBuilder.mockOne = { _, _, _ in testScreen }
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

        screenBuilder.mockOne = { _, _, mockDismiss in
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

        screenBuilder.mockTwo = { _, _, _ in testScreen }
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

        screenBuilder.mockTwo = { _, _, mockDismiss in
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

        screenBuilder.mockThree = { _, _, _ in testScreen }
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

        screenBuilder.mockThree = { _, _, mockDismiss in
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

        screenBuilder.mockCompletionAlert = { _ in testScreen }
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

        screenBuilder.mockCompletionAlert = { mockCompletion in
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

        screenBuilder.mockOne = { _, mockCompletion, _ in
            completion = mockCompletion
            return MockViewControlling()
        }

        return { completion?() }
    }
    
    private func setupTwoCompletion() -> () -> Void {
        var completion: (() -> Void)?

        screenBuilder.mockTwo = { _, mockCompletion, _ in
            completion = mockCompletion
            return MockViewControlling()
        }

        return { completion?() }
    }
    
    private func setupThreeCompletion(with viewController: MockViewControlling = .init()) -> () -> Void {
        var completion: (() -> Void)?

        screenBuilder.mockThree = { _, mockCompletion, _ in
            completion = mockCompletion
            return viewController
        }

        return { completion?() }
    }
}
