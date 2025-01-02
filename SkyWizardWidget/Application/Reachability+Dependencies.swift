//
//  Reachability+Dependencies.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 14/11/2024.
//

import Foundation
import SkyWizardService
import Factory

extension Container {
    var networkReachabilityService: Factory<ReachabilityService> {
        Factory(self) {
            NetworkReachabilityService()
        }
    }
}
