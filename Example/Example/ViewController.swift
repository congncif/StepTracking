//
//  ViewController.swift
//  Example
//
//  Created by NGUYEN CHI CONG on 10/30/20.
//  Copyright © 2020 [iF] Solution. All rights reserved.
//

import RxCocoa
import RxSwift
import StepTracking
import UIKit

extension TrackingType {
    static let facebook = "facebook"
}

class ViewController: UIViewController {
    lazy var tracker: AnalyticsTracking = AnalyticsTrackerFactory().getAnalyticsTracker()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let event = TrackingEvent(name: "Test tracking event")
        let events = event.bundled(with: event.converted(by: {
            TrackingEvent(type: TrackingType.facebook, name: $0.name + ".converted")
        }))
        Observable.just(events)
            .bind(to: tracker.rx.trackingEvents)
            .disposed(by: disposeBag)
    }
}
