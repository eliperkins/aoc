import Foundation

struct Day1 {
    static private func parse(_ input: String) -> Array<Int> {
        return input.replacingOccurrences(of: " ", with: "")
          .replacingOccurrences(of: "\n", with: ",") // this wasn't in the puzzle description, but in the puzzle input
          .split(separator: ",")
          .map(String.init)
          .compactMap(Int.init)
    }

    static func day1(_ input: String) -> Int {
        return parse(input).reduce(0, +)
    }
    
    static func day1PartTwo(_ input: String) -> Int {
        let changes = parse(input)
        var seenFreqs = Set<Int>([0])
        func walk(_ vals: Array<Int>, startingFreq: Int = 0) -> Int {
            var resultingFreq = startingFreq
            for change in vals {
                resultingFreq += change
                if seenFreqs.contains(resultingFreq) {
                    return resultingFreq
                }
                seenFreqs.insert(resultingFreq)
            }
            return walk(changes, startingFreq: resultingFreq)
        }
        return walk(changes)
    }
}

