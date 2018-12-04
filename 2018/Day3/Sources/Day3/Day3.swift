import Foundation

struct Day3 {
    struct Position: Equatable, Hashable {
        let x: Int
        let y: Int
    }
    struct Claim {
        let id: String
        let x: Int
        let y: Int
        let width: Int
        let height: Int
        let positions: Set<Position>

        init(line: String) {
            // #1 @ 1,3: 4x4
            // "#1", "@", "1,3:", "4x4"
            let parts = line.split(separator: " ")
            let xy = parts[2].replacingOccurrences(of: ":", with: "").split(separator: ",")
            let x = Int(xy[0]) ?? 0
            let y = Int(xy[1]) ?? 0
            let wh = parts[3].split(separator: "x")
            let width = Int(wh[0]) ?? 0
            let height = Int(wh[1]) ?? 0

            self.id = String(parts[0])
            self.x = x
            self.y = y
            self.width = width
            self.height = height
        }
    }

    struct Grid {
        enum Status: Equatable {
            case none
            case one(String)
            case many(Set<String>)
        }

        private let _grid: [[Status]]
        private let _overlapping: Set<String>

        init(width: Int, height: Int) {
            self._grid = Array(repeating: Array(repeating: .none, count: width), count: height)
            self._overlapping = Set([])
        }

        //  LOL why am i doing this and not using mutating funcs
        private init(_grid: [[Status]], _overlapping: Set<String>) {
            self._grid = _grid
            self._overlapping = _overlapping
        }

        func claiming(_ claim: Claim) -> Grid {
            var newGrid = _grid
            var newOverlapping = _overlapping
            for column in claim.x..<claim.x + claim.width {
                for row in claim.y..<claim.y + claim.height {
                    let currentValue = newGrid[row][column]
                    switch currentValue {
                        case .none:
                            newGrid[row][column] = .one(claim.id)
                        case .one(let id):
                            // This is double entry
                            newOverlapping.insert(id)
                            newOverlapping.insert(claim.id)
                            let set = Set([id, claim.id])
                            newGrid[row][column] = .many(set)
                        case .many(let prevSet):
                            newOverlapping.insert(claim.id)
                            let set = prevSet.union([claim.id])
                            newGrid[row][column] = .many(set)
                    }
                }
            }
            return Grid(_grid: newGrid, _overlapping: newOverlapping)
        }

        var claimed: Int {
            return _grid.reduce(0, { acc, next in
                return acc + next.filter({ 
                    switch $0 {
                        case .many: return true
                        default: return false
                    }
                }).count
            })
        }

        var uncuttable: Set<String> {
            return _overlapping
        }

        var debugDescription: String {
            return _grid.map { row in
                return row.map { cell in 
                    switch cell {
                        case .none: return "."
                        case .one(let id): return String(id[id.index(before: id.endIndex)])
                        case .many: return "X"
                    }
                }
                .joined()
            }.joined(separator: "\n")
        }
    }

    static func parse(_ input: String) -> [Claim] {
        return input.split(separator: "\n").compactMap { Claim(line: String($0)) }
    }

    static func calculateGrid(from claims: [Claim], width: Int, height: Int) -> Grid {
        return claims.reduce(Grid(width: width, height: height), { acc, next in acc.claiming(next)})
    }

    static func calculateIntersect(from input: String, width: Int, height: Int) -> Int {
        let claims = parse(input)
        let grid = calculateGrid(from: claims, width: width, height: height)
        return grid.claimed
    }

    static func calculateCuttableClaim(from input: String, width: Int, height: Int) -> String {
        let claims = parse(input)
        let grid = calculateGrid(from: claims, width: width, height: height)
        let totalSet = Set(claims.map { $0.id })
        let cuttable = totalSet.subtracting(grid.uncuttable)
        print(cuttable.count)
        return cuttable.first ?? "wat"
    }
}

func == (_ lhs: Day3.Grid.Status, _ rhs: Day3.Grid.Status) -> Bool {
    switch (lhs, rhs) {
        case (.none, .none):
            return true
        case (.many(let lhsId), .many(let rhsId)):
            return lhsId == rhsId
        case (.one(let lhsId), .one(let rhsId)):
            return lhsId == rhsId
        default:
            return false
    }
}
