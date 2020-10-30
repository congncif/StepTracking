//
//  RxTracking.swift
//  StepTracking
//
//  Created by NGUYEN CHI CONG on 10/30/20.
//  Copyright © 2020 [iF] Solution. All rights reserved.
//

import Foundation
import RxSwift

extension AnalyticsTracking {
    public var rx: Reactive<AnalyticsTracking> {
        return Reactive(AnalyticsBridge.shared.inject(tracker: self))
    }

    public var rxStepTracker: Reactive<TrackingStepsTraceable> {
        return Reactive(AnalyticsBridge.shared.inject(tracker: self))
    }
}

extension Reactive where Base == AnalyticsTracking {
    public var trackingEvent: AnyObserver<AnalyticsEvent> {
        return AnyObserver<AnalyticsEvent> { [weak base] event in
            guard let trackingEvent = event.element else { return }
            base?.sendEvent(trackingEvent)
        }
    }

    public var trackingEvents: AnyObserver<[AnalyticsEvent]> {
        return AnyObserver<[AnalyticsEvent]> { [weak base] event in
            guard let trackingEvents = event.element else { return }
            base?.sendEvents(trackingEvents)
        }
    }
}

extension Reactive where Base: AnalyticsTracking {
    public var trackingEvent: AnyObserver<AnalyticsEvent> {
        return AnyObserver<AnalyticsEvent> { [weak base] event in
            guard let trackingEvent = event.element else { return }
            base?.sendEvent(trackingEvent)
        }
    }

    public var trackingEvents: AnyObserver<[AnalyticsEvent]> {
        return AnyObserver<[AnalyticsEvent]> { [weak base] event in
            guard let trackingEvents = event.element else { return }
            base?.sendEvents(trackingEvents)
        }
    }
}

extension Reactive where Base == TrackingStepsTraceable {
    public var nextStep: AnyObserver<Trackable> {
        return AnyObserver<Trackable> { [weak base] event in
            guard let step = event.element else { return }
            base?.onStep(step)
        }
    }
}

extension Reactive where Base: TrackingStepsTraceable {
    public var nextStep: AnyObserver<Trackable> {
        return AnyObserver<Trackable> { [weak base] event in
            guard let step = event.element else { return }
            base?.onStep(step)
        }
    }
}
