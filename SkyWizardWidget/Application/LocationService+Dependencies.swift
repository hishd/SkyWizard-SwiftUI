//
//  LocationService+Dependencies.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 13/11/2024.
//

import Foundation
import SkyWizardService
import Factory

extension Container {
    var locationServiceGps: Factory<LocationService> {
        Factory(self) {
            LocationServiceGps()
        }
    }
}
