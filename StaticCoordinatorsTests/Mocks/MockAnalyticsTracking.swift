@testable import StaticCoordinators
import Foundation

class MockAnalyticsTracking: AnalyticsTracking {
    var mockTrack: ((Any) -> Void)?
    
    func track<Event>(event: Event) where Event: AnalyticsEventProtocol {
        mockTrack?(event)
    }
}
