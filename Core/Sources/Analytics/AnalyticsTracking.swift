import Foundation

public protocol AnalyticsEventProtocol {
    associatedtype Properties: Encodable
    
    var name: String { get }
    var properties: Properties { get }
}

public protocol AnalyticsTracking {
    func track<Event: AnalyticsEventProtocol>(event: Event)
}
