//
//  WeatherServiceMock.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import CoreLocation
import SkyWizardEnum
import SkyWizardModel

#if DEBUG
public class WeatherServiceMock: WeatherService {
    public func fetchWeather(for location: CLLocationCoordinate2D) async throws -> TaskType {
        return Task {
            .sample
        }
    }
    
    public func getWeatherType(for current: WeatherData.CurrentWeatherData) -> CurrentWeatherType {
        .day_sunny
    }
    
    public func getWeather(for daily: WeatherData.DailyWeatherData) throws -> [DailyWeatherData] {
        return (0...4).map { _ in
                .sample
        }
    }
    
    public func getWeather(for hourly: WeatherData.HourlyWeatherData) throws -> [HourlyWeatherData] {
        return (0...12).map { _ in
                .sample
        }
    }
    
    public init() {}
}
#endif
