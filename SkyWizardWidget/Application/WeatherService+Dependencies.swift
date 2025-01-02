//
//  Dependencies.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import NetworkingService
import SkyWizardService
import Factory

extension Container {
    var weatherServiceRemote: Factory<WeatherService> {
        Factory(self) {
            WeatherServiceRemote(dataTransferService: self.dataTransferServiceWeather())
        }
    }
}
