import Foundation

protocol AnalyticsEventProtocol {
    associatedtype Properties: Encodable
    
    var name: String { get }
    var properties: Properties { get }
}

protocol AnalyticsTracking {
    func track<Event: AnalyticsEventProtocol>(event: Event)
}
