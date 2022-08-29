import Foundation

struct ColorScreenEvent: AnalyticsEventProtocol, Equatable {
    struct Properties: Encodable, Equatable {
        var title: String
        var red: Double
        var green: Double
        var blue: Double
    }
    
    let name: String = "Color Screen Viewed"
    var properties: Properties
}
