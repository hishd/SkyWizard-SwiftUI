//
//  HourlyWeatherData.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 05/11/2024.
//

import Foundation

struct HourlyWeatherData: Identifiable {
    let id: UUID = .init()
    let timeText: String
    let imageName: String
    let temperature: Int
    
    #if DEBUG
    static let sample: HourlyWeatherData = .init(
        timeText: "10 am",
        imageName: "forecast_ic_sunny",
        temperature: 20
    )
    #endif
}
