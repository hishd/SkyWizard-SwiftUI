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
    public func fetchWeather(for location: CLLocationCoordinate2D) async throws -> WeatherData {
        .sample
    }
    
    public func getWeatherType(for current: WeatherData.CurrentWeatherData) -> CurrentWeatherType {
        .night_clear
    }
    
    public func getWeather(for daily: WeatherData.DailyWeatherData) throws -> [DailyWeatherData] {
        let dayName: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
        var startDay: Int = 22
        return (0...4).map { index in
            startDay += 1
            return DailyWeatherData(
                dateString: "\(startDay) Nov, \(dayName[index])",
                tempHigh: Int.random(in: 20...25),
                tempLow: Int.random(in: 10...20),
                weatherType: DailyWeatherType.allCases.randomElement()!
            )
        }
    }
    
    public func getWeather(for hourly: WeatherData.HourlyWeatherData) throws -> [HourlyWeatherData] {
        return (16...20).map { index in
            return HourlyWeatherData(timeText: "\(index) PM", weatherType: .night_clear, temperature: Int.random(in: 20...25))
        }
    }
    
    public init() {}
}
#endif
