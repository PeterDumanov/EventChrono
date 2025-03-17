import Foundation

struct DateHelper {
    static func timeDifference(targetDate: Date, now: Date = Date()) -> DateComponents {
        let calendar = Calendar.current
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        return calendar.dateComponents(components, from: targetDate, to: now)
    }
    
    static func differenceString(from: DateComponents) -> String {
        var result: String = ""
        guard let years = from.year, let months = from.month, let days = from.day, let hours = from.hour, let minutes = from.minute, let seconds = from.second
        else {
            return result
        }
        let metrics: [(unit: String, value: Int)] = [
            ("yr.", years),
            ("mo.", months),
            ("d.", days),
            ("h.", hours),
            ("min.", minutes),
            ("s.", seconds)
        ]
        result += metrics
            .compactMap { $0.value != 0 ? "\(abs($0.value)) \($0.unit)" : nil }
            .joined(separator: ", ")
        return (seconds < 0 ? "Remaining: " : "Elapsed: ") + result
    }
}
