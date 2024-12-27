//
//  DailyWeatherData.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 05/11/2024.
//

import Foundation
import SkyWizardEnum

public struct DailyWeatherData: Identifiable {
    public let id: UUID = UUID()
    public let dateString: String
    public let tempHigh: Int
    public let tempLow: Int
    public let weatherType: DailyWeatherType
    
    #if DEBUG
    public static let sample: Self = .init(dateString: "12 Oct, Friday", tempHigh: 24, tempLow: 18, weatherType: .sunny)
    #endif
    
    public init(dateString: String, tempHigh: Int, tempLow: Int, weatherType: DailyWeatherType) {
        self.dateString = dateString
        self.tempHigh = tempHigh
        self.tempLow = tempLow
        self.weatherType = weatherType
    }
}

extension DailyWeatherData {
    public var icon: String {
        switch weatherType {
        case .sunny: return "forecast_ic_sunny"
        case .cloudy: return "forecast_ic_cloudy"
        case .rainy: return "forecast_ic_rainy"
        case .snow: return "forecast_ic_snow"
        case .undefined: return "forecast_ic_sunny"
        }
    }
}
