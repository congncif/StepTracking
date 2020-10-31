//
//  DefaultTrackerFactory.swift
//  StepTracking
//
//  Created by NGUYEN CHI CONG on 10/30/20.
//  Copyright © 2020 [iF] Solution. All rights reserved.
//

import Foundation

final class DefaultTracker {
    static let shared: AnalyticsTracking = DefaultAnalyticsTracker()
}

public final class DefaultTrackerFactory: AnalyticsTrackingManufacturing {
    public init() {}

    public func getAnalyticsTracker() -> AnalyticsTracking {
        return DefaultTracker.shared
    }
}
