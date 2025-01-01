//
//  WeatherDataService.swift
//  SkyWizardWidgetExtension
//
//  Created by Hishara Dilshan on 01/01/2025.
//

import Foundation

enum WeatherServiceError: Error {
    case error(message: String)
    case dataUnavailable
}

protocol WeatherDataService {
    func getWeatherData() throws(WeatherServiceError) -> WeatherEntry
}
