import Foundation

struct DateHelper {
    static func timeDifference(targetDate: Date, now: Date = Date()) -> (dateComponents: DateComponents, isFuture: Bool) {
        let calendar = Calendar.current
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let dateComponents = calendar.dateComponents(components, from: targetDate, to: now)
        return (dateComponents, ((dateComponents.minute ?? 0) + (dateComponents.second ?? 0)) < 0)
    }
    
    static func differenceString(from: DateComponents, for isFuture: Bool) -> String {
        var result: String = String()
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
        return (isFuture ? "Remaining: " : "Elapsed: ") + (!result.isEmpty ? result : "0 s.")
    }
}
