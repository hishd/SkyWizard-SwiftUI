//
//  GeocodingService+Dependencies.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import NetworkingService
import SkyWizardService
import Factory

extension Container {
    var geoCodingServiceRemote: Factory<GeocodingService> {
        Factory(self) {
            GeocodingServiceRemote(dataTransferService: self.dataTransferServiceGeocoding())
        }
    }
}
