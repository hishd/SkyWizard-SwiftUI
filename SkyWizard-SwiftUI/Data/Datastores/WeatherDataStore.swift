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
            async let data = currentTask!.value
            
            await updateData(from: try data)
        } catch {
            self.error = error
        }
    }
    
    @MainActor
    private func updateData(from weather: WeatherData) {
        do {
            self.currentTemperature = Int(weather.current.temperature_2m)
            self.realFeel = Int(weather.current.apparent_temperature)
            self.currentWeatherType = weatherService.getWeatherType(for: weather.current)
            self.hourlyWeatherData = try weatherService.getWeather(for: weather.hourly)
            self.dailyWeatherData = try weatherService.getWeather(for: weather.daily)
        } catch {
            self.error = error
        }
    }
    
    func cancelCurrentTask() {
        currentTask?.cancel()
    }
}
