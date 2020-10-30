//
//  Tracking.swift
//  StepTracking
//
//  Created by NGUYEN CHI CONG on 10/30/20.
//  Copyright © 2020 [iF] Solution. All rights reserved.
//

import Foundation
import StepTracking

final class DefaultAnalyticsTracker: AnalyticsTracking {
    func sendEvent(_ event: AnalyticsEvent) {
        #if DEBUG
        print("👉 \(String(describing: Self.self)) sent event with name `\(event.name)` and parameters \(event.parameters)")
        #endif
    }
}
