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
        XCTAssertEqual(Day1.day1(Day1Input), 574)
    }

    func testDay1PartTwo() {
        XCTAssertEqual(Day1.day1PartTwo("+1, -1"), 0)
        XCTAssertEqual(Day1.day1PartTwo("+3, +3, +4, -2, -4"), 10)
        XCTAssertEqual(Day1.day1PartTwo("-6, +3, +8, +5, -6"), 5)
        XCTAssertEqual(Day1.day1PartTwo("+7, +7, -2, -7, -4"), 14)
    }

    func testDay1bAnswer() {
        XCTAssertEqual(Day1.day1PartTwo(Day1Input), 452)
    }

    static var allTests = [
        ("testDay1", testDay1),
        ("testDay1Answer", testDay1Answer)
    ]
}
