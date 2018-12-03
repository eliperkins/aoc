import Foundation

struct Day1 {
    static func day1(_ input: String) -> Int {
        return input.replacingOccurrences(of: " ", with: "")
          .replacingOccurrences(of: "\n", with: ",") // this wasn't in the puzzle description, but in the puzzle input
          .split(separator: ",")
          .map(String.init)
          .compactMap(Int.init)
          .reduce(0, +)
    }
}

