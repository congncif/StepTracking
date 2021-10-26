//
//  Tracker.swift
//  StepTracking
//
//  Created by NGUYEN CHI CONG on 10/30/20.
//  Copyright © 2020 [iF] Solution. All rights reserved.
//

import Foundation

final class CombineAnalyticsTracker: AnalyticsTracking {
    private var trackers: [AnalyticsTracking]

    init(trackers: [AnalyticsTracking]) {
        self.trackers = trackers
    }

    func append(_ tracker: AnalyticsTracking) {
        self.trackers.append(tracker)
    }

    func sendEvent(_ event: AnalyticsEvent) {
        self.trackers.forEach {
            $0.sendEvent(event)
        }
    }
}

extension AnalyticsTracking {
    func combined(_ other: AnalyticsTracking) -> AnalyticsTracking {
        if let source = self as? CombineAnalyticsTracker {
            source.append(other)
            return source
        } else {
            return CombineAnalyticsTracker(trackers: [self, other])
        }
    }
}
