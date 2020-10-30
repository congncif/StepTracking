//
//  AnalyticsBridge.swift
//  StepTracking
//
//  Created by NGUYEN CHI CONG on 10/30/20.
//  Copyright © 2020 [iF] Solution. All rights reserved.
//

import Foundation

final class AnalyticsBridge {
    private(set) weak var internalTracker: AnalyticsTracking?
    private let internalStepsTracker: TrackingStepsTraceable

    init(stepsTracker: TrackingStepsTraceable) {
        internalStepsTracker = stepsTracker
    }

    static let shared = AnalyticsBridge(stepsTracker: StepsTracker())

    func inject(tracker: AnalyticsTracking) -> Self {
        internalTracker = tracker
        return self
    }
}

extension AnalyticsBridge: AnalyticsTracking, TrackingStepsTraceable {
    var steps: [Trackable] {
        return internalStepsTracker.steps
    }

    func onStep(_ step: Trackable) {
        internalStepsTracker.onStep(step)
    }

    func sendEvent(_ event: AnalyticsEvent) {
        DispatchQueue(label: "analytics.tracking", qos: .background).async { [unowned self] in
            let defaultParams = self.internalStepsTracker.synthesizedParameters + event.customParams
            let wrappedEvent = TrackingEvent(name: event.name, trackableParameters: defaultParams)

            self.internalTracker?.sendEvent(wrappedEvent)
        }
    }
}
