import Analytics

public class MockAnalyticsTracking: AnalyticsTracking {
    public init() {}
    
    public var mockTrack: ((Any) -> Void)?
    
    public func track<Event>(event: Event) where Event: AnalyticsEventProtocol {
        mockTrack?(event)
    }
}
