//
//  Trackable.swift
//  StepTracking
//
//  Created by NGUYEN CHI CONG on 10/30/20.
//  Copyright © 2020 [iF] Solution. All rights reserved.
//

import Foundation

public protocol TrackingEncodable {
    var parameters: [String: Any] { get }
}

public enum ParametersScenario {
    case keepPrevious
    case clearPrevious
}

public protocol Trackable {
    var trackId: String { get }
    var trackParameters: [TrackingEncodable] { get }
    var parametersScenario: ParametersScenario { get }
}

public struct TrackingStep: Trackable {
    public let trackId: String
    public let trackParameters: [TrackingEncodable]
    public let parametersScenario: ParametersScenario

    public init(id: String, parameters: [TrackingEncodable] = [], parametersScenario: ParametersScenario = .keepPrevious) {
        self.trackId = id
        self.trackParameters = parameters
        self.parametersScenario = parametersScenario
    }
}

public protocol TrackingStepsTraceable: AnyObject {
    var steps: [Trackable] { get }

    func onStep(_ step: Trackable)
}

extension TrackingStepsTraceable {
    public var synthesizedParameters: [TrackingEncodable] {
        var parameters: [TrackingEncodable] = []
        for step in steps {
            switch step.parametersScenario {
            case .keepPrevious:
                parameters += step.trackParameters
            case .clearPrevious:
                parameters = step.trackParameters
            }
        }
        return parameters
    }
}

public final class StepsTracker: TrackingStepsTraceable {
    public private(set) var steps: [Trackable] = []

    public func onStep(_ step: Trackable) {
        let preSteps = steps.prefix { $0.trackId != step.trackId }
        steps = preSteps + [step]
    }
}
