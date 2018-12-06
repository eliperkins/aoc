import XCTest
@testable import Day5

final class Day5Tests: XCTestCase {
    func testExample() {
        XCTAssertEqual(Day5.computeReaction(from: "aA"), "")
        XCTAssertEqual(Day5.computeReaction(from: "abBA"), "")
        XCTAssertEqual(Day5.computeReaction(from: "abAB"), "abAB")
        XCTAssertEqual(Day5.computeReaction(from: "aabAAB"), "aabAAB")
        XCTAssertEqual(Day5.computeReaction(from: "dabAcCaCBAcCcaDA"), "dabCBAcaDA")
    }

    func testDay5Answer() {
        XCTAssertEqual(Day5.computeReaction(from: TestInput).count, 11814)
    }

    func testDay5PartTwoAnswer() {
        XCTAssertEqual(Day5.computeShortest(from: TestInput), 4282)
    }

    static var allTests = [
        ("testExample", testExample),
        ("testDay5Answer", testDay5Answer)
    ]
}
