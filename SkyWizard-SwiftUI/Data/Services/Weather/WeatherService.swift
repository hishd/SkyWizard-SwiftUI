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
    func getWeatherType(for current: WeatherData.CurrentWeatherData) -> CurrentWeatherType
    func getWeather(for daily: WeatherData.DailyWeatherData) throws -> [DailyWeatherData]
    func getWeather(for hourly: WeatherData.HourlyWeatherData) throws -> [HourlyWeatherData]
}

enum WeatherServiceError: LocalizedError {
    case invalidResponse(message: String)
    case invalidData(message: String)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse(let message):
          return message
        case .invalidData(let message):
            return message
        }
    }
}
