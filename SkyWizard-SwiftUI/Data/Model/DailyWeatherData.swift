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
    let icon: String
    let tempHigh: Int
    let tempLow: Int
    
    #if DEBUG
    static let sample: Self = .init(dateString: "12 Oct, Friday", icon: "forecast_ic_sunny", tempHigh: 24, tempLow: 18)
    #endif
}
