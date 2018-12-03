import Foundation
import XCTest
@testable import Day1

final class Day1Tests: XCTestCase {
    func testDay1() {
        XCTAssertEqual(Day1.day1("+1, +1, +1"), 3)
        XCTAssertEqual(Day1.day1("+1, +1, -2"), 0)
        XCTAssertEqual(Day1.day1("-1, -2, -3"), -6)
    }

    func testDay1Answer() {
        XCTAssertEqual(Day1.day1(TestString), 574)
    }

    static var allTests = [
        ("testDay1", testDay1),
        ("testDay1Answer", testDay1Answer)
    ]
}
