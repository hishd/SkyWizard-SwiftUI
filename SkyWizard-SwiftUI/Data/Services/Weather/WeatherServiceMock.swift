//
//  WeatherServiceMock.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import CoreLocation

#if DEBUG
class WeatherServiceMock: WeatherService {
    func fetchWeather(for location: CLLocationCoordinate2D) async throws -> TaskType {
        return Task {
            .sample
        }
    }
    
    func getWeatherType(for current: WeatherData.CurrentWeatherData) -> CurrentWeatherType {
        .day_sunny
    }
    
    func getWeather(for daily: WeatherData.DailyWeatherData) throws -> [DailyWeatherData] {
        return (0...4).map { _ in
                .sample
        }
    }
    
    func getWeather(for hourly: WeatherData.HourlyWeatherData) throws -> [HourlyWeatherData] {
        return (0...12).map { _ in
                .sample
        }
    }
}
#endif
