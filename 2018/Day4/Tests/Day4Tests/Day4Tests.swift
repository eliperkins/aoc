import XCTest
@testable import Day4

final class Day4Tests: XCTestCase {
    func testExample() {
let testInput = """
[1518-11-01 00:00] Guard #10 begins shift
[1518-11-01 00:05] falls asleep
[1518-11-01 00:25] wakes up
[1518-11-01 00:30] falls asleep
[1518-11-01 00:55] wakes up
[1518-11-01 23:58] Guard #99 begins shift
[1518-11-02 00:40] falls asleep
[1518-11-02 00:50] wakes up
[1518-11-03 00:05] Guard #10 begins shift
[1518-11-03 00:24] falls asleep
[1518-11-03 00:29] wakes up
[1518-11-04 00:02] Guard #99 begins shift
[1518-11-04 00:36] falls asleep
[1518-11-04 00:46] wakes up
[1518-11-05 00:03] Guard #99 begins shift
[1518-11-05 00:45] falls asleep
[1518-11-05 00:55] wakes up
"""
        let answer = Day4.parse(testInput)
        XCTAssertEqual(answer.guardId, 10)
        XCTAssertEqual(answer.minute, 24)
        XCTAssertEqual(answer.answer, 240)
    }

    func testDay4Part1() {
        let answer = Day4.parse(Day4TestInput)
        XCTAssertEqual(answer.guardId, 3023)
        XCTAssertEqual(answer.minute, 33)
        XCTAssertEqual(answer.answer, 99759)
    }

    static var allTests = [
        ("testDay4Part1", testDay4Part1),
    ]
}
