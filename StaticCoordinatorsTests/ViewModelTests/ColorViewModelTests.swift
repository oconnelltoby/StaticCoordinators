import XCTest
@testable import StaticCoordinators

class ColorViewModelTests: XCTestCase {
    func testRed() {
        let viewModel = ColorViewModel(style: .red, completion: {})
        XCTAssertEqual(viewModel.color, .systemRed)
        XCTAssertEqual(viewModel.title, "Red")
    }
    
    func testGreen() {
        let viewModel = ColorViewModel(style: .green, completion: {})
        XCTAssertEqual(viewModel.color, .systemGreen)
        XCTAssertEqual(viewModel.title, "Green")
    }
    
    func testBlue() {
        let viewModel = ColorViewModel(style: .blue, completion: {})
        XCTAssertEqual(viewModel.color, .systemBlue)
        XCTAssertEqual(viewModel.title, "Blue")
    }
}
