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
    let is_day: Bool
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

extension WeatherData {
    struct CurrentWeatherData: Decodable {
        let temperature_2m: Double
        let apparent_temperature: Double
        let weather_code: Int
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
            weather_code: 3
        )
        
        return .init(latitude: 52.52, longitude: 13.41, is_day: true, current: currentSample, hourly: hourlySample, daily: dailySample)
    }
    #endif
}
