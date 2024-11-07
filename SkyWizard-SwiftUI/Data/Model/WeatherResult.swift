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
    let hourly: HourlyWeatherResponse
    let daily: DailyWeatherResponse
    
    struct HourlyWeatherResponse: Decodable {
        let time: [String]
        let temperature_2m: [Double]
        let weather_code: [Int]
    }
    
    struct DailyWeatherResponse: Decodable {
        let time: [String]
        let temperature_2m_max: [Double]
        let temperature_2m_min: [Double]
        let weather_code: [Int]
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
        
        return .init(latitude: 52.52, longitude: 13.41, hourly: hourlySample, daily: dailySample)
    }
    #endif
}
