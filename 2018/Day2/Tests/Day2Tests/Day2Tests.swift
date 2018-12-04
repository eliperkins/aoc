import XCTest
@testable import Day2

final class Day2Tests: XCTestCase {
    func testDay2Example() {
        let testInput = """
abcdef
bababc
abbcde
abcccd
aabcdd
abcdee
ababab
"""
        let checksum = Day2.checksum(testInput)
        XCTAssertEqual(checksum, 12)
    }

    func testDay2Input() {
        XCTAssertEqual(Day2.checksum(Day2Input), 9633)
    }

    func testDay2b() {
        let testString = """
abcde
fghij
klmno
pqrst
fguij
axcye
wvxyz
"""
        XCTAssertEqual(Set(Day2.findCommon(testString)), Set("fgij"))
    }

    func testDay2bAnswer() {
        XCTAssertEqual(Day2.findCommon(Day2Input), "lujnogabetpmsydyfcovzixaw")
    }

    func testPermutations() {
        let xs = [1, 2, 3]
        let permutations = xs.permutations()

        XCTAssertEqual(permutations.count, 3)

        XCTAssertEqual(permutations[0].0, 1)
        XCTAssertEqual(permutations[0].1, 2)

        XCTAssertEqual(permutations[1].0, 1)
        XCTAssertEqual(permutations[1].1, 3)

        XCTAssertEqual(permutations[2].0, 2)
        XCTAssertEqual(permutations[2].1, 3)
    }

    static var allTests = [
        ("testDay2Example", testDay2Example),
        ("testDay2Input", testDay2Input),
        ("testPermutations", testPermutations),
        ("testDay2b", testDay2b)
    ]
}
