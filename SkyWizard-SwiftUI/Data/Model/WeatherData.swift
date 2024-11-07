//
//  WeatherResult.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation

struct WeatherData: Decodable {
    let latitude: Double
    let longitude: Double
    let current: CurrentWeatherData
    let hourly: HourlyWeatherData
    let daily: DailyWeatherData
}

extension WeatherData {
    struct HourlyWeatherData: Decodable {
        let time: [String]
        let temperature_2m: [Double]
        let weather_code: [Int]
    }
}

extension WeatherData {
    struct DailyWeatherData: Decodable {
        let time: [String]
        let temperature_2m_max: [Double]
        let temperature_2m_min: [Double]
        let weather_code: [Int]
    }
}

extension WeatherData.DailyWeatherData {
    var weatherType: CurrentWeatherType? {
        switch weather_code {
        case let code where (0...3).contains(code):
            .day_sunny
        case let code where (45...48).contains(code):
            .day_cloudy
        case let code where ((51...67).contains(code) || (80...82).contains(code) || (95...99).contains(code)):
            .day_rainy
        case let code where (0...3).contains(code):
            .day_sunny
        case let code where (45...48).contains(code):
            .day_cloudy
        case let code where ((51...67).contains(code) || (80...82).contains(code) || (95...99).contains(code)):
            .day_rainy
        case let code where (71...77).contains(code) || (85...86).contains(code):
            .snow
        default:
            nil
        }
    }
}

extension WeatherData {
    struct CurrentWeatherData: Decodable {
        let temperature_2m: Double
        let apparent_temperature: Double
        let weather_code: Int
        let is_day: Bool
    }
}

extension WeatherData.CurrentWeatherData {
    var weatherType: CurrentWeatherType? {
        switch weather_code {
        case let code where (0...3).contains(code) && is_day:
            .day_sunny
        case let code where (45...48).contains(code) && is_day:
            .day_cloudy
        case let code where ((51...67).contains(code) || (80...82).contains(code) || (95...99).contains(code)) && is_day:
            .day_rainy
        case let code where (0...3).contains(code) && !is_day:
            .day_sunny
        case let code where (45...48).contains(code) && !is_day:
            .day_cloudy
        case let code where ((51...67).contains(code) || (80...82).contains(code) || (95...99).contains(code)) && !is_day:
            .day_rainy
        case let code where (71...77).contains(code) || (85...86).contains(code):
            .snow
        default:
            nil
        }
    }
}


extension WeatherData {
    #if DEBUG
    static var sample: Self {
        let hourlySample: HourlyWeatherData = .init(
            time: (0...5).map { "\($0):00" },
            temperature_2m: (0...5).map { Double($0) },
            weather_code: (0...5).map { $0 }
        )
        
        let dailySample: DailyWeatherData = .init(
            time: (0...5).map { "\($0):00" },
            temperature_2m_max: (0...5).map { Double($0) },
            temperature_2m_min: (0...5).map { Double($0) },
            weather_code: (0...5).map { $0 }
        )
        
        let currentSample: CurrentWeatherData = .init(
            temperature_2m: 20.0,
            apparent_temperature: 12.0,
            weather_code: 3,
            is_day: true
        )
        
        return .init(latitude: 52.52, longitude: 13.41, current: currentSample, hourly: hourlySample, daily: dailySample)
    }
    #endif
}
