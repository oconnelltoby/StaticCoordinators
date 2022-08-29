import XCTest
@testable import StaticCoordinators

class ColorViewModelTests: XCTestCase {
    var analyticsTracker: MockAnalyticsTracking!
    
    override func setUp() {
        analyticsTracker = .init()
    }
    
    func testRed() {
        let viewModel = ColorViewModel(style: .red, analyticsTracker: analyticsTracker, completion: {})
        XCTAssertEqual(viewModel.color, .systemRed)
        XCTAssertEqual(viewModel.title, "Red")
    }
    
    func testGreen() {
        let viewModel = ColorViewModel(style: .green, analyticsTracker: analyticsTracker, completion: {})
        XCTAssertEqual(viewModel.color, .systemGreen)
        XCTAssertEqual(viewModel.title, "Green")
    }
    
    func testBlue() {
        let viewModel = ColorViewModel(style: .blue, analyticsTracker: analyticsTracker, completion: {})
        XCTAssertEqual(viewModel.color, .systemBlue)
        XCTAssertEqual(viewModel.title, "Blue")
    }
    
    func testScreenEvent() {
        let viewModel = ColorViewModel(style: .red, analyticsTracker: analyticsTracker, completion: {})

        var event: Any?
        analyticsTracker.mockTrack = { event = $0 }
         
        viewModel.screenViewed()

        let color = CIColor(color: UIColor.systemRed)
        let properties = ColorScreenEvent.Properties(title: "Red", red: color.red, green: color.green, blue: color.blue)
        let expectedEvent = ColorScreenEvent(properties: properties)
        XCTAssertEqual(expectedEvent, event as? ColorScreenEvent)
    }
}
