//
//  WeatherService.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import CoreLocation

protocol WeatherService {
    typealias TaskType = Task<WeatherData, Error>
    func fetchWeather(for location: CLLocationCoordinate2D) async throws -> TaskType
}

enum WeatherServiceError: Error {
    case invalidResponse(message: String)
    case invalidData(message: String)
}
