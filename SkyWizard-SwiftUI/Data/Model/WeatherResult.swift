//
//  WeatherResult.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation

struct WeatherResult: Decodable {
    let latitude: Double
    let longitude: Double
    let current: CurrentWeatherResponse
    let hourly: HourlyWeatherResponse
    let daily: DailyWeatherResponse
}

extension WeatherResult {
    struct HourlyWeatherResponse: Decodable {
        let time: [String]
        let temperature_2m: [Double]
        let weather_code: [Int]
    }
}

extension WeatherResult {
    struct DailyWeatherResponse: Decodable {
        let time: [String]
        let temperature_2m_max: [Double]
        let temperature_2m_min: [Double]
        let weather_code: [Int]
    }
}

extension WeatherResult {
    struct CurrentWeatherResponse: Decodable {
        let temperature_2m: Double
        let apparent_temperature: Double
        let weather_code: Int
    }
}

extension WeatherResult {
    #if DEBUG
    static var sample: Self {
        let hourlySample: HourlyWeatherResponse = .init(
            time: (0...5).map { "\($0):00" },
            temperature_2m: (0...5).map { Double($0) },
            weather_code: (0...5).map { $0 }
        )
        
        let dailySample: DailyWeatherResponse = .init(
            time: (0...5).map { "\($0):00" },
            temperature_2m_max: (0...5).map { Double($0) },
            temperature_2m_min: (0...5).map { Double($0) },
            weather_code: (0...5).map { $0 }
        )
        
        let currentSample: CurrentWeatherResponse = .init(
            temperature_2m: 20.0,
            apparent_temperature: 12.0,
            weather_code: 3
        )
        
        return .init(latitude: 52.52, longitude: 13.41, current: currentSample, hourly: hourlySample, daily: dailySample)
    }
    #endif
}
