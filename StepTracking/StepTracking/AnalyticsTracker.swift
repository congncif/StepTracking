//
//  Tracker.swift
//  StepTracking
//
//  Created by NGUYEN CHI CONG on 10/30/20.
//  Copyright © 2020 [iF] Solution. All rights reserved.
//

import Foundation

public final class AnalyticsTracker: AnalyticsTracking {
    private var trackers: [AnalyticsTracking]

    public init(trackers: [AnalyticsTracking]) {
        self.trackers = trackers
    }

    func append(_ tracker: AnalyticsTracking) {
        self.trackers.append(tracker)
    }

    public func sendEvent(_ event: AnalyticsEvent) {
        self.trackers.forEach {
            $0.sendEvent(event)
        }
    }
}

final class AnalyticsTrackerNotSet: AnalyticsTracking {
    func sendEvent(_ event: AnalyticsEvent) {
        assertionFailure("AnalyticsTrackerNotSet")
    }
}

extension AnalyticsTracking {
    public func combined(_ other: AnalyticsTracking) -> AnalyticsTracking {
        if let source = self as? AnalyticsTracker {
            source.append(other)
            return source
        } else {
            return AnalyticsTracker(trackers: [self, other])
        }
    }

    /// To avoid dealing with Optional, use .notSet as a placeholder of AnalyticsTracking's declaration.
    public static var notSet: AnalyticsTracking {
        AnalyticsTrackerNotSet()
    }
}
