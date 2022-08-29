import Foundation

struct AnalyticsPrinter: AnalyticsTracking {
    func track<Event>(event: Event) where Event: AnalyticsEventProtocol {
        if let data = try? JSONEncoder().encode(event.properties), let string = String(data: data, encoding: .utf8) {
            print(event.name, string)
        } else {
            print(event.name)
        }
    }
}
