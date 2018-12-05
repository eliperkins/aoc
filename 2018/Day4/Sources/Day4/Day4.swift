import Foundation

struct Day4 {
    struct Solution {
        let guardId: Int
        let minute: Int
        let answer: Int
        let part2Answer: Int
    }

    enum EventType {
        case shiftStart(Int)
        case fallsAsleep
        case wakesUp
    }

    struct Event {
        let timestamp: Date
        let minutes: Int
        let type: EventType

        private static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            return formatter
        }()

        init?(line: String) {
            guard let timestampClosingBracketIndex = line.firstIndex(of: "]") else { fatalError("bum timestamp") }
            let timestampRange = line.index(after: line.startIndex)..<timestampClosingBracketIndex
            let timestampString = String(line[timestampRange])
            guard let timestamp = Event.dateFormatter.date(from: timestampString) else { fatalError("bum date") }
            self.timestamp = timestamp
            self.minutes = Int(timestampString.split(separator: " ")[1].split(separator: ":")[1])!

            let remainder = String(line[line.index(after: timestampClosingBracketIndex)...])
                .trimmingCharacters(in: .whitespacesAndNewlines)

            switch remainder {
                case "falls asleep":
                    self.type = .fallsAsleep
                case "wakes up":
                    self.type = .wakesUp
                default:
                    guard let idMarkerIndex = remainder.firstIndex(of: "#"),
                        let idEndMarkerIndex = remainder.firstIndex(of: "b")
                        else { fatalError("bum guard id") }

                    let omgSwiftIndexesSuck = remainder.index(after: idMarkerIndex)
                    let seriously = remainder.index(before: idEndMarkerIndex)

                    guard let guardId = Int(remainder[omgSwiftIndexesSuck..<seriously])
                        else { fatalError("fuck string manipulation")}
                    self.type = .shiftStart(guardId)
            }
        }
    }

    private static func calcSleepingMinutes(from fellAsleep: Date, to wakesUp: Date) -> Array<Int> {
        let calendar = Calendar.current
        guard let sleepingMinute = calendar.dateComponents([.minute], from: fellAsleep).minute,
            let wakingMinute = calendar.dateComponents([.minute], from: wakesUp).minute
            else { return Array(repeating: 0, count: 60) }
        return Array(repeating: 0, count: 60)
            .enumerated()
            .map { (index, min) in
                return (sleepingMinute <= index) && (index < wakingMinute) ? 1 : 0
            }
    }

    static func parse(_ input: String) -> Solution {
        let events = input.trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: "\n")
            .map(String.init)
            .compactMap(Event.init)
            .sorted(by: { $0.timestamp < $1.timestamp })

        var sleepingMinutes = Dictionary<Int, Array<Int>>()
        var currentId: Int?
        var fellAsleepAt: Date?
        for event in events {
            switch event.type {
                case .shiftStart(let id):
                    currentId = id
                    fellAsleepAt = nil
                case .fallsAsleep:
                    fellAsleepAt = event.timestamp
                case .wakesUp:
                    guard let currentId = currentId else { fatalError("no guard on duty") }
                    guard let sleepDate = fellAsleepAt else { fatalError("woke up from no sleep") }
                    let min = calcSleepingMinutes(from: sleepDate, to: event.timestamp)
                    let currentCount = sleepingMinutes[currentId] ?? Array(repeating: 0, count: 60)
                    sleepingMinutes[currentId] = zip(currentCount, min).map { $0.0 + $0.1 }
                    fellAsleepAt = nil
            }
        }
        let guardWithMostSleepingMin = sleepingMinutes
            .map { (key, value) in return (key, value.reduce(0, +)) }
            .max(by: { $0.1 < $1.1 })?
            .0
        guard let id = guardWithMostSleepingMin else { fatalError("no guard???") }
        guard let sleepiestMin = sleepingMinutes[id]?.enumerated()
            .max(by: { (a, b) in
                return a.element < b.element
            })?
            .offset 
            else { fatalError("no sleepy guards") }
        
        let xs: Array<(guardId: Int, min: Int, count: Int)> = sleepingMinutes.map { (guardId, mins) in 
            guard let maxMin = mins.enumerated().max(by: { $0.element < $1.element }) else { fatalError() }
            return (guardId: guardId, min: maxMin.offset, count: maxMin.element)
        }
        guard let sleepiest = xs.max(by: { $0.count < $1.count }) else { fatalError() }

        // let (guardId, index, count) = sleepingMinutes.map { (entry: (Int, Array<Int>)) in
        //     let guardId: Int = entry.0
        //     let minutes: Array<Int> = entry.1
        //     let (index, count) = minutes.enumerated().max(by: { $0.element < $1.element }) ?? (0, 0)
        //     print("\(guardId) max min was \(index) with \(count)" )
        //     return (guardId, index, count)
        // }.max(by: { (a, b) in 
        //     a.2 > b.2
        // })!
        return Solution(guardId: id, minute: sleepiestMin, answer: id * sleepiestMin, part2Answer: sleepiest.guardId * sleepiest.min)
    }
}
