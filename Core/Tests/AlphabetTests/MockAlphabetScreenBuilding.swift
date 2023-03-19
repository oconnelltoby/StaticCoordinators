import Alphabet
import Analytics
import NavigationMocks

class MockAlphabetScreenBuilding: AlphabetScreenBuilding {
    var mockAlphabetA: ((AnalyticsTracking, @escaping () -> Void) -> MockViewControlling)!
    var mockAlphabetB: ((AnalyticsTracking, @escaping () -> Void) -> MockViewControlling)!
    var mockAlphabetC: ((AnalyticsTracking, @escaping () -> Void) -> MockViewControlling)!

    
    func alphabetA(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> MockViewControlling {
        mockAlphabetA(analyticsTracker, completion)
    }
    
    func alphabetB(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> MockViewControlling {
        mockAlphabetB(analyticsTracker, completion)
    }
    
    func alphabetC(analyticsTracker: AnalyticsTracking, completion: @escaping () -> Void) -> MockViewControlling {
        mockAlphabetC(analyticsTracker, completion)
    }
}
