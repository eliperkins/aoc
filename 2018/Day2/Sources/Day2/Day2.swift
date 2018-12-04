struct Day2 {
    struct Counts {
        let twos: Int
        let threes: Int
    }

    private static func counts(for line: String) -> Counts {
        let xs = Dictionary(grouping: line, by: { $0 })
        let hasTwo = xs.contains(where: { (_, value) in value.count == 2 })
        let hasThree = xs.contains(where: { (_, value) in value.count == 3 })
        return Counts(
            twos: hasTwo ? 1 : 0,
            threes: hasThree ? 1 : 0
        )
    }

    static func checksumInputs(_ input: String) -> Counts {
        let initialValue = Counts(twos: 0, threes: 0)
        return input.split(separator: "\n")
            .map(String.init)
            .map(counts(for:))
            .reduce(initialValue, { acc, next in
                return Counts(
                    twos: acc.twos + next.twos,
                    threes: acc.threes + next.threes
                )                
            })
    }

    static func checksum(_ input: String) -> Int {
        let counts = checksumInputs(input)
        return counts.twos * counts.threes
    }

    private static func findDiffCount(_ lhs: String, _ rhs: String) -> Int {
        return lhs.enumerated().reduce(0, { (acc, next) in
            return next.element == rhs[rhs.index(rhs.startIndex, offsetBy: next.offset)] ? acc : acc + 1
        })
    }

    private static func removeMissing(_ lhs: String, _ rhs: String) -> String {
        return lhs.enumerated().reduce("", { (acc, next) in
            return next.element == rhs[rhs.index(rhs.startIndex, offsetBy: next.offset)] ? 
                acc + String(next.element) : 
                acc
        })
    }

    static func findCommon(_ input: String) -> String {
        let vals = input.split(separator: "\n").map(String.init)
        assert(vals.count > 2, "Not enough values to compare!")
        return vals.permutations()
            .map { ($0.0, $0.1, findDiffCount($0.0, $0.1)) }
            .sorted(by: { $0.2 < $1.2 })
            .first
            .map { removeMissing($0.0, $0.1) }
            ?? "wat"
    }
}

extension Array {
    public func permutations() -> [(Element, Element)] {
        var xs = [(Element, Element)]()
        if let head = self.first {
            let remaining = self.dropFirst()
            xs += zip(Array(repeating: head, count: remaining.count), remaining)
            xs += Array(remaining).permutations()
        }
        return xs
    }
}
