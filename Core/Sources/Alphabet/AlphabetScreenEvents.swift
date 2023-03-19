import Analytics
import Foundation

struct AlphabetScreenEvent: AnalyticsEventProtocol, Equatable {
    struct Properties: Encodable, Equatable {
        var character: String
    }
    
    let name: String = "Alphabet Screen Viewed"
    var properties: Properties
}
