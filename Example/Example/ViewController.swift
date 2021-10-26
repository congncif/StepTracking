//
//  ViewController.swift
//  Example
//
//  Created by NGUYEN CHI CONG on 10/30/20.
//  Copyright © 2020 [iF] Solution. All rights reserved.
//

import StepTracking
import UIKit

extension TrackingType {
    static let facebook = "facebook"
}

class ViewController: UIViewController {
    lazy var tracker: AnalyticsStepTracking = AnalyticsCenter.shared
        .appended(tracker: FirebaseAnalyticsTracker())

    override func viewDidLoad() {
        super.viewDidLoad()

        let event = TrackingEvent(name: "Test tracking event")
        let events = event.bundled(with: event.converted(by: {
            TrackingEvent(type: TrackingType.facebook, name: $0.name + ".converted")
        }))
        
        tracker.sendEvents(events)
    }
}
