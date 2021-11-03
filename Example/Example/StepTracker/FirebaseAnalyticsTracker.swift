//
//  FirebaseAnalyticsTracker.swift
//  StepTracking
//
//  Created by NGUYEN CHI CONG on 10/30/20.
//  Copyright © 2020 [iF] Solution. All rights reserved.
//

import Firebase
import Foundation
import StepTracking

final class FirebaseAnalyticsTracker: AnalyticsTracking {
    func isTrackingEnabled(event: AnalyticsEvent) -> Bool {
        event.type == TrackingType.default
    }

    func sendEvent(_ event: AnalyticsEvent) {
        Analytics.logEvent(event.name, parameters: event.parameters)
    }

    func setUserID(_ userID: String?) {
        Analytics.setUserID(userID)
    }
}
