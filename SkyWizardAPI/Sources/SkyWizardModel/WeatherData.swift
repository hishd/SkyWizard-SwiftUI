//
//  WeatherResult.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation

public struct WeatherData: Sendable, Decodable {
    public let latitude: Double
    public let longitude: Double
    public let current: CurrentWeatherData
    public let hourly: HourlyWeatherData
    public let daily: DailyWeatherData
}

extension WeatherData {
    public struct HourlyWeatherData: Decodable, Sendable {
        public let time: [String]
        public let temperature_2m: [Double]
        public let weather_code: [Int]
        public let is_day: [Int]
    }
}

extension WeatherData {
    public struct DailyWeatherData: Decodable, Sendable {
        public let time: [String]
        public let temperature_2m_max: [Double]
        public let temperature_2m_min: [Double]
        public let weather_code: [Int]
    }
}

extension WeatherData {
    public struct CurrentWeatherData: Decodable, Sendable {
        public let temperature_2m: Double
        public let apparent_temperature: Double
        public let weather_code: Int
        public let is_day: Int
    }
}


extension WeatherData {
    #if DEBUG
    public static var sample: Self {
        let hourlySample: HourlyWeatherData = .init(
            time: (0...5).map { "\($0):00" },
            temperature_2m: (0...5).map { Double($0) },
            weather_code: (0...5).map { $0 },
            is_day: (0...5).map{ $0.isMultiple(of: 2) ? 1 : 0 }
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
            is_day: 0
        )
        
        return .init(latitude: 52.52, longitude: 13.41, current: currentSample, hourly: hourlySample, daily: dailySample)
    }
    #endif
}
