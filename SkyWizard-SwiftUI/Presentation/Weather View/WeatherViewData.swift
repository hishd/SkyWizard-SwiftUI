//
//  WeatherViewData.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 05/11/2024.
//

import Foundation

class WeatherViewData: ObservableObject {
    @Published var currentTemperature: Int = 20
    @Published var highestTemp: Int = 24
    @Published var lowestTemp: Int = 18
    @Published var currentCity: String = "Northampton"
    @Published var currentWeatherType: WeatherType = .day_sunny
    @Published var hourlyWeatherData: [HourlyWeatherData] = (0...10).map { _ in
            .sample
    }
    @Published var dailyWeatherData: [DailyWeatherData] = (0..<5).map { _ in
            .sample
    }
    
    func toggleWeatherType() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
            let type: WeatherType = WeatherType.allCases.randomElement()!
            self.currentWeatherType = type
        }
    }
}
