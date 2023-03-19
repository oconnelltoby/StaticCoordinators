import XCTest
import NavigationMocks
import AnalyticsMocks
@testable import Initial

class InitialCoordinatorTests: XCTestCase {
    var screenBuilder: MockInitialScreenBuilding!
    var navigationController: MockNavigationControlling!
    var configuration: InitialCoordinator<MockNavigationControlling, MockViewControlling, MockInitialScreenBuilding>.Configuration!
    var analyticsTracker: MockAnalyticsTracking!
    
    override func setUp() {
        navigationController = .init()
        screenBuilder = .init()
        analyticsTracker = .init()
        configuration = .init(navigationController: navigationController, screenBuilder: screenBuilder, analyticsTracker: analyticsTracker)
    }

    func testStart() {
        // Given
        let screen = MockViewControlling()
        var pushedScreen: MockViewControlling?
        
        screenBuilder.mockAlphabetCoordinator = { _, _ in
            screen
        }
        
        navigationController.mockPushViewController = { screen, presented in
            pushedScreen = screen
        }
        
        // When
        InitialCoordinator.start(configuration: configuration)
        
        // Then
        XCTAssertEqual(screen, pushedScreen)
    }
    
    func testAlphabetCompletionShowsColorCoordinator() {
        // Given
        var didBuildColorCoordinator: Bool?
        
        let alphabetCompletion = setupAlphabetCompletion()
        
        screenBuilder.mockColorCoordinator = { _, _ in
            didBuildColorCoordinator = true
        }
        
        navigationController.mockPushViewController = { _, _ in }
        
        // When
        InitialCoordinator.start(configuration: configuration)
        alphabetCompletion()
        
        // Then
        XCTAssertEqual(didBuildColorCoordinator, true)
    }
}

extension InitialCoordinatorTests {
    func setupAlphabetCompletion() -> () -> Void {
        var completion: (() -> Void)?
        
        screenBuilder.mockAlphabetCoordinator = { _, mockCompletion in
            completion = mockCompletion
            return MockViewControlling()
        }
        
        return { completion?() }
    }
}
