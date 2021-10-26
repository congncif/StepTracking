//
//  AnalyticsBridge.swift
//  StepTracking
//
//  Created by NGUYEN CHI CONG on 10/30/20.
//  Copyright © 2020 [iF] Solution. All rights reserved.
//

import Foundation

public protocol AnalyticsStepTracking: AnalyticsTracking, TrackingStepsTraceable {}

public final class AnalyticsCenter {
    private(set) var internalTracker: AnalyticsTracking
    private let internalStepsTracker: TrackingStepsTraceable

    public init(stepsTracker: TrackingStepsTraceable, initialTracker: AnalyticsTracking) {
        internalStepsTracker = stepsTracker
        internalTracker = initialTracker
    }

    public convenience init() {
        self.init(stepsTracker: StepsTracker(), initialTracker: DefaultAnalyticsTracker())
    }

    /// Provide an unique tracker for centralized management and can be appended
    public static let shared = AnalyticsCenter()

    /// Append a tracker of a tracking service provided by a tracking agency such as Firebase, Mixpanel, Facebook, etc.
    @discardableResult
    public func appended(tracker trackingAgent: AnalyticsTracking) -> Self {
        internalTracker = internalTracker.combined(trackingAgent)
        return self
    }
}

extension AnalyticsCenter: AnalyticsStepTracking {
    public var steps: [Trackable] {
        return internalStepsTracker.steps
    }

    public func onStep(_ step: Trackable) {
        internalStepsTracker.onStep(step)
    }

    /// Send a tracking event to trackers of the appended agencies.
    /// - Warning: The sending operation will be dispatched on background thread.
    public func sendEvent(_ event: AnalyticsEvent) {
        DispatchQueue(label: "analytics.tracking", qos: .background).async { [weak self] in
            guard let self = self else { return }
            let defaultParams = self.internalStepsTracker.synthesizedParameters + event.customParams
            let wrappedEvent = TrackingEvent(name: event.name, trackableParameters: defaultParams)

            self.internalTracker.sendEvent(wrappedEvent)
        }
    }
}
