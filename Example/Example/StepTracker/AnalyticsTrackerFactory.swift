//
//  AnalyticsTrackerFactory.swift
//  StepTracking
//
//  Created by NGUYEN CHI CONG on 10/30/20.
//  Copyright © 2020 [iF] Solution. All rights reserved.
//

import Foundation
import StepTracking

final class AnalyticsSingleton {
    static let tracker: AnalyticsTracking = DefaultAnalyticsTracker()
        .combined(FirebaseAnalyticsTracker())
}

public final class AnalyticsTrackerFactory: AnalyticsTrackingManufacturing {
    public init() {}

    public func getAnalyticsTracker() -> AnalyticsTracking {
        return AnalyticsSingleton.tracker
    }
}
