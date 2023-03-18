import XCTest
@testable import StaticCoordinators

class AlphabetViewModelTests: XCTestCase {
    var analyticsTracker: MockAnalyticsTracking!
    
    override func setUp() {
        analyticsTracker = .init()
    }
    
    func testA() {
        let viewModel = AlphabetViewModel(character: "A", analyticsTracker: analyticsTracker, completion: {})
        XCTAssertEqual(viewModel.label, "A")
        XCTAssertEqual(viewModel.title, "A")
    }
    
    func testB() {
        let viewModel = AlphabetViewModel(character: "B", analyticsTracker: analyticsTracker, completion: {})
        XCTAssertEqual(viewModel.label, "B")
        XCTAssertEqual(viewModel.title, "B")
    }
    
    func testC() {
        let viewModel = AlphabetViewModel(character: "C", analyticsTracker: analyticsTracker, completion: {})
        XCTAssertEqual(viewModel.label, "C")
        XCTAssertEqual(viewModel.title, "C")
    }
    
    func testScreenEvent() {
        let viewModel = AlphabetViewModel(character: "A", analyticsTracker: analyticsTracker, completion: {})
        
        var event: AlphabetScreenEvent?
        analyticsTracker.mockTrack = { event = $0 as? AlphabetScreenEvent }
         
        viewModel.screenViewed()

        let expectedEvent = AlphabetScreenEvent(properties: .init(character: "A"))
        XCTAssertEqual(expectedEvent, event)
    }
}
