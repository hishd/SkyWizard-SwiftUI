//
//  DailyWeatherData.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 05/11/2024.
//

import Foundation

struct DailyWeatherData: Identifiable {
    let id: UUID = UUID()
    let dateString: String
    let tempHigh: Int
    let tempLow: Int
    let weatherType: DailyWeatherType
    
    #if DEBUG
    static let sample: Self = .init(dateString: "12 Oct, Friday", tempHigh: 24, tempLow: 18, weatherType: .sunny)
    #endif
}

extension DailyWeatherData {
    var icon: String {
        switch weatherType {
        case .sunny: return "forecast_ic_sunny"
        case .cloudy: return "forecast_ic_cloudy"
        case .rainy: return "forecast_ic_rainy"
        case .snow: return "forecast_ic_snow"
        case .undefined: return "forecast_ic_sunny"
        }
    }
}
