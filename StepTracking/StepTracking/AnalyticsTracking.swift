//
//  Tracking.swift
//  StepTracking
//
//  Created by NGUYEN CHI CONG on 10/30/20.
//  Copyright © 2020 [iF] Solution. All rights reserved.
//

import Foundation

public protocol AnalyticsTracking: AnyObject {
    func isTrackingEnabled(event: AnalyticsEvent) -> Bool
    func sendEvent(_ event: AnalyticsEvent)
}

extension AnalyticsTracking {
    public func isTrackingEnabled(event: AnalyticsEvent) -> Bool { true }

    public func sendEvents(_ events: [AnalyticsEvent]) {
        events.forEach { [unowned self] in
            self.sendEvent($0)
        }
    }
}

public protocol AnalyticsTrackingManufacturing {
    func getAnalyticsTracker() -> AnalyticsTracking
}
