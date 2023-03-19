import XCTest
import AnalyticsMocks
@testable import Number

class NumberViewModelTests: XCTestCase {
    var analyticsTracker: MockAnalyticsTracking!
    
    override func setUp() {
        analyticsTracker = .init()
    }
    
    func testOne() {
        let viewModel = NumberViewModel(number: 1, analyticsTracker: analyticsTracker, completion: {}, dismiss: {})
        XCTAssertEqual(viewModel.label, "1")
        XCTAssertEqual(viewModel.title, "One")
    }
    
    func testTwo() {
        let viewModel = NumberViewModel(number: 2, analyticsTracker: analyticsTracker, completion: {}, dismiss: {})
        XCTAssertEqual(viewModel.label, "2")
        XCTAssertEqual(viewModel.title, "Two")
    }
    
    func testThree() {
        let viewModel = NumberViewModel(number: 3, analyticsTracker: analyticsTracker, completion: {}, dismiss: {})
        XCTAssertEqual(viewModel.label, "3")
        XCTAssertEqual(viewModel.title, "Three")
    }
    
    func testScreenEvent() {
        let viewModel = NumberViewModel(number: 1, analyticsTracker: analyticsTracker, completion: {}, dismiss: {})
        
        var event: NumberScreenEvent?
        analyticsTracker.mockTrack = { event = $0 as? NumberScreenEvent }
         
        viewModel.screenViewed()

        let expectedEvent = NumberScreenEvent(properties: .init(title: "One", number: 1))
        XCTAssertEqual(expectedEvent, event)
    }
}
