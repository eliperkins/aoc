public struct Day5 {
    static func isEqualAndOppositePolarity(_ lhs: Character, _ rhs: Character) -> Bool {
        if lhs == rhs {
            return false
        }

        return String(lhs).uppercased() == String(rhs) ||
            String(lhs) == String(rhs).uppercased()
    }

    static func bad_react(_ input: String) -> String {
        struct Accu {
            let lastChar: Character?
            let returnVal: String
            let didRemoval: Bool
        }

        let initial = Accu(lastChar: nil, returnVal: "", didRemoval: false)
        return input.reduce(initial, { (acc, next) in
            if acc.didRemoval {
                return Accu(lastChar: next, returnVal: acc.returnVal + String(next), didRemoval: acc.didRemoval)
            }
            let returnVal: String
            var didRemoval = false
            if let lastChar = acc.lastChar, isEqualAndOppositePolarity(lastChar, next) {
                returnVal = String(acc.returnVal.dropLast())
                didRemoval = true
            } else {
                returnVal = acc.returnVal + String(next)
            }
            return Accu(lastChar: next, returnVal: returnVal, didRemoval: didRemoval)
        })
        .returnVal
    }

    static func stillbad_react(_ input: String) -> String {   
        var returnVal: Array<Character> = []         
        var lastChar: Character? = nil
        for (index, next) in input.enumerated() {
            if let lastChar = lastChar, isEqualAndOppositePolarity(lastChar, next) {
                return String(returnVal.dropLast()) + input[input.index(input.startIndex, offsetBy: index + 1)...]
            }
            returnVal += String(next)
            lastChar = next
        }
        return String(returnVal)
    }


    static func react(_ input: String, removing: Set<Character> = []) -> String {   
        var returnVal: Array<Character> = []         
        for (index, next) in input.enumerated() {
            guard !removing.contains(next) else { continue }
            if index == 0 {
                returnVal.append(next)
            } else if let lastChar = returnVal.last, isEqualAndOppositePolarity(next, lastChar) {
                returnVal.removeLast()
            } else {
                returnVal.append(next)
            }
        }
        return String(returnVal)
    }
    
    public static func computeReaction(from polymer: String) -> String {
        let reduced = react(polymer)
        if polymer == reduced {
            return reduced
        }
        return computeReaction(from: reduced)
    }

    public static func computeShortest(from polymer: String) -> Int {
        let alphabet = "abcdefghijklmnopqrstuvwxyz"
        return alphabet.map(String.init)
            .map { [$0.first!, $0.uppercased().first!] }
            .map { react(polymer, removing: $0).count }
            .min()!
    }
}
