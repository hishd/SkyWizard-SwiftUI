//
//  WeatherServiceMock.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import CoreLocation

class WeatherServiceMock: WeatherService {
    func fetchWeather(for location: CLLocationCoordinate2D) async throws -> TaskType {
        return Task {
            .sample
        }
    }
}
