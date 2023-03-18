import XCTest
@testable import StaticCoordinators

class AlphabetCoordinatorTests: XCTestCase {
    var screenBuilder: MockAlphabetScreenBuilding!
    var tabBarController: MockTabBarControlling!
    var configuration: AlphabetCoordinator<MockTabBarControlling, MockViewControlling, MockAlphabetScreenBuilding>.Configuration!
    var analyticsTracker: MockAnalyticsTracking!
    var completion: (() -> Void)!

    override func setUp() {
        tabBarController = .init()
        screenBuilder = .init()
        analyticsTracker = .init()
        configuration = .init(
            tabBarController: tabBarController,
            screenBuilder: screenBuilder,
            analyticsTracker: analyticsTracker,
            completion: { [unowned self] in self.completion() }
        )
    }
    
    func testStart() {
        // Given
        let aScreen = MockViewControlling()
        let bScreen = MockViewControlling()
        let cScreen = MockViewControlling()
        var setViewControllers: [MockViewControlling]??

        screenBuilder.mockAlphabetA = { _, _ in aScreen }
        screenBuilder.mockAlphabetB = { _, _ in bScreen }
        screenBuilder.mockAlphabetC = { _, _ in cScreen }
        
        tabBarController.mockSetViewControllers = { viewControllers, _ in
            setViewControllers = viewControllers
        }
        
        // When
        AlphabetCoordinator.start(configuration: configuration)
        
        // Then
        XCTAssertEqual(setViewControllers, [aScreen, bScreen, cScreen])
    }

    func testACompletion() {
        // Given
        let aCompletion = setupACompletion()
        let bScreen = MockViewControlling()
        let cScreen = MockViewControlling()
        var completed: Bool?
        
        screenBuilder.mockAlphabetB = { _, _ in bScreen }
        screenBuilder.mockAlphabetC = { _, _ in cScreen }
        
        completion = { completed = true }
        
        tabBarController.mockSetViewControllers = { _, _ in }
        
        // When
        AlphabetCoordinator.start(configuration: configuration)
        aCompletion()
        
        // Then
        XCTAssertEqual(completed, true)
    }
    
    func testBCompletion() {
        // Given
        let aScreen = MockViewControlling()
        let bCompletion = setupBCompletion()
        let cScreen = MockViewControlling()
        var completed: Bool?
        
        screenBuilder.mockAlphabetA = { _, _ in aScreen }
        screenBuilder.mockAlphabetC = { _, _ in cScreen }
        
        completion = { completed = true }
        
        tabBarController.mockSetViewControllers = { _, _ in }
        
        // When
        AlphabetCoordinator.start(configuration: configuration)
        bCompletion()
        
        // Then
        XCTAssertEqual(completed, true)
    }
    
    func testCCompletion() {
        // Given
        let aScreen = MockViewControlling()
        let bScreen = MockViewControlling()
        let cCompletion = setupCCompletion()
        var completed: Bool?
        
        screenBuilder.mockAlphabetA = { _, _ in aScreen }
        screenBuilder.mockAlphabetB = { _, _ in bScreen }
        
        completion = { completed = true }
        
        tabBarController.mockSetViewControllers = { _, _ in }
        
        // When
        AlphabetCoordinator.start(configuration: configuration)
        cCompletion()
        
        // Then
        XCTAssertEqual(completed, true)
    }
}

extension AlphabetCoordinatorTests {
    private func setupACompletion() -> () -> Void {
        var completion: (() -> Void)?

        screenBuilder.mockAlphabetA = { _, mockCompletion in
            completion = mockCompletion
            return MockViewControlling()
        }

        return { completion?() }
    }
    
    private func setupBCompletion() -> () -> Void {
        var completion: (() -> Void)?

        screenBuilder.mockAlphabetB = { _, mockCompletion in
            completion = mockCompletion
            return MockViewControlling()
        }

        return { completion?() }
    }
    
    private func setupCCompletion() -> () -> Void {
        var completion: (() -> Void)?

        screenBuilder.mockAlphabetC = { _, mockCompletion in
            completion = mockCompletion
            return MockViewControlling()
        }

        return { completion?() }
    }
}
