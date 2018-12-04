import XCTest
@testable import Day3

final class Day3Tests: XCTestCase {
    func testExample() {
        let testInput = """
#1 @ 1,3: 4x4
#2 @ 3,1: 4x4
#3 @ 5,5: 2x2
"""
        XCTAssertEqual(Day3.calculateIntersect(from: testInput, width: 8, height: 8), 4)
    }

    func testDay3Input() {
        XCTAssertEqual(Day3.calculateIntersect(from: Day3Input, width: 1000, height: 1000), 109143)
    }

    func testDay3bInput() {
        XCTAssertEqual(Day3.calculateCuttableClaim(from: Day3Input, width: 1000, height: 1000), "#506")
    }

    static var allTests = [
        ("testExample", testExample),
        ("testDay3Input", testDay3Input),
        ("testDay3bInput", testDay3bInput)
    ]
}
