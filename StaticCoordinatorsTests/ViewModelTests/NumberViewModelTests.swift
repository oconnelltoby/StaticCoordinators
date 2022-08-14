import XCTest
@testable import StaticCoordinators

class NumberViewModelTests: XCTestCase {
    func testOne() {
        let viewModel = NumberViewModel(number: 1, completion: {}, dismiss: {})
        XCTAssertEqual(viewModel.label, "1")
        XCTAssertEqual(viewModel.title, "One")
    }
    
    func testTwo() {
        let viewModel = NumberViewModel(number: 2, completion: {}, dismiss: {})
        XCTAssertEqual(viewModel.label, "2")
        XCTAssertEqual(viewModel.title, "Two")
    }
    
    func testThree() {
        let viewModel = NumberViewModel(number: 3, completion: {}, dismiss: {})
        XCTAssertEqual(viewModel.label, "3")
        XCTAssertEqual(viewModel.title, "Three")
    }
}
