//
//  TrackingEvent.swift
//  StepTracking
//
//  Created by NGUYEN CHI CONG on 10/30/20.
//  Copyright © 2020 [iF] Solution. All rights reserved.
//

import Foundation

public protocol TrackableEvent: TrackingEncodable {
    var type: String { get }
    var name: String { get }
    var customParams: [TrackingEncodable] { get }
}

public typealias AnalyticsEvent = TrackableEvent

extension TrackableEvent {
    public var parameters: [String: Any] {
        return customParams.reduce([:]) { (result, item) -> [String: Any] in
            result.merging(item.parameters, uniquingKeysWith: { $1 })
        }
    }
}

public struct TrackingType {
    public static let `default` = "default"
}

public struct TrackingEvent: TrackableEvent {
    public let type: String
    public let name: String
    public let customParams: [TrackingEncodable]

    public init(type: String = TrackingType.default,
                name: String,
                trackableParameters: [TrackingEncodable] = []) {
        self.type = type
        self.name = name
        self.customParams = trackableParameters
    }
}

extension TrackableEvent {
    public func bundled(with event: TrackableEvent) -> [TrackableEvent] {
        return [self, event]
    }
}

extension Array where Element == TrackableEvent {
    public func bundled(with event: TrackableEvent) -> [TrackableEvent] {
        return self + [event]
    }
}

extension Array where Element: TrackableEvent {
    public func bundled(with event: TrackableEvent) -> [TrackableEvent] {
        return self + [event]
    }
}

extension TrackableEvent {
    public func converted(by transform: (TrackableEvent) -> TrackableEvent) -> TrackableEvent {
        transform(self)
    }
}
