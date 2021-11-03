//
//  DefaultAnalyticsTracker.swift
//  StepTracking
//
//  Created by NGUYEN CHI CONG on 10/30/20.
//  Copyright © 2020 [iF] Solution. All rights reserved.
//

import Foundation

final class DebugConsoleTracker: AnalyticsTracking {
    private(set) var userID: String?

    func setUserID(_ userID: String?) {
        self.userID = userID
        #if DEBUG
        print("⚓️ \(String(describing: Self.self)) set `userID` to \(String(describing: userID))")
        #endif
    }

    func sendEvent(_ event: AnalyticsEvent) {
        #if DEBUG
        if let userID = userID {
            print("👀 \(String(describing: Self.self)) with userID \(userID) sent an event with name `\(event.name)` and parameters \(event.parameters)")
        } else {
            print("👀 \(String(describing: Self.self)) sent an event with name `\(event.name)` and parameters \(event.parameters)")
        }
        #endif
    }
}
