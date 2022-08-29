import Foundation

struct NumberScreenEvent: AnalyticsEventProtocol, Equatable {
    struct Properties: Encodable, Equatable {
        var title: String
        var number: Int
    }
    
    let name: String = "Number Screen Viewed"
    var properties: Properties
}
