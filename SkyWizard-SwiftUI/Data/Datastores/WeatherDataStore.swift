//
//  WeatherDataStore.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import CoreLocation

class WeatherDataStore: ObservableObject {
    @Published var currentTemperature: Int = 20
    @Published var realFeel: Int = 10
    @Published var currentCity: String = "Northampton"
    @Published var currentWeatherType: CurrentWeatherType = .day_sunny
    @Published var hourlyWeatherData: [HourlyWeatherData] = .init()
    @Published var dailyWeatherData: [DailyWeatherData] = .init()
    @Published var error: Swift.Error?
    var currentTask: Task<WeatherData, Error>?
    
    var currentLocation: CLLocationCoordinate2D?
    let weatherService: WeatherService
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    func loadWeatherData() async {
        guard let currentLocation else { return }
        
        do {
            self.currentTask = try await weatherService.fetchWeather(for: currentLocation)
            let data = try await currentTask!.value
            
            self.currentTemperature = Int(data.current.temperature_2m)
            self.realFeel = Int(data.current.apparent_temperature)
            
            if let weatherType = data.current.weatherType {
                self.currentWeatherType = weatherType
            } else {
                error = WeatherServiceError.invalidData(message: "Could not find weather type for the given wmo code.")
            }

        } catch {
            self.error = error
        }
    }
    
    func cancelCurrentTask() {
        currentTask?.cancel()
    }
}
