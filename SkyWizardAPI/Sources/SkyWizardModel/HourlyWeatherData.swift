//
//  HourlyWeatherData.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 05/11/2024.
//

import Foundation
import SkyWizardEnum

public struct HourlyWeatherData: Identifiable, @unchecked Sendable {
    public let id: UUID = .init()
    public let timeText: String
    public let weatherType: CurrentWeatherType
    public let temperature: Int
    
    public init(timeText: String, weatherType: CurrentWeatherType, temperature: Int) {
        self.timeText = timeText
        self.weatherType = weatherType
        self.temperature = temperature
    }
    
    #if DEBUG
    public static let sample: HourlyWeatherData = .init(
        timeText: "10 am",
        weatherType: .day_sunny,
        temperature: 20
    )
    #endif
}

extension HourlyWeatherData {
    public var imageName: String {
        return switch weatherType
        {
        case .day_sunny:
            "forecast_ic_sunny"
        case .day_cloudy:
            "forecast_ic_cloudy"
        case .day_rainy:
            "forecast_ic_rainy"
        case .night_clear:
            "forecast_ic_night"
        case .night_cloudy:
            "forecast_ic_night_cloudy"
        case .night_rainy:
            "forecast_ic_night_rainy"
        case .snow:
            "forecast_ic_snow"
        case .undefined:
            "weather_unknown"
        }
    }
}
