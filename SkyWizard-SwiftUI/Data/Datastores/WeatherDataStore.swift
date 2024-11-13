//
//  WeatherDataStore.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import CoreLocation
import OSLog
import Combine

final class WeatherDataStore: @unchecked Sendable, ObservableObject {
    @Published var currentTemperature: Int = 0
    @Published var realFeel: Int = 0
    @Published var currentCity: String = ""
    @Published var currentWeatherType: CurrentWeatherType = .day_sunny
    @Published var hourlyWeatherData: [HourlyWeatherData] = .init()
    @Published var dailyWeatherData: [DailyWeatherData] = .init()
    @Published var error: Swift.Error?
    @Published var loading: Bool = false
    var currentWeatherTask: Task<WeatherData, Error>?
    var currentGeocodingTask: Task<GeocodeData, Error>?
    var locationResultCancellable: AnyCancellable?
    
    var weatherTypeResource: WeatherTypeResource {
        currentWeatherType.getWeatherTypeResource()
    }
    
    let weatherService: WeatherService
    let geocodingService: GeocodingService
    var locationService: LocationService?
    
    init(weatherService: WeatherService, geocodingService: GeocodingService) {
        self.weatherService = weatherService
        self.geocodingService = geocodingService
        self.locationService = LocationService()
        locationService?.start()
    }
    
    func startLoadingWeather() {
        locationResultCancellable = locationService?.locationResult
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] result in
                if case let .failure(error) = result {
                    self?.error = error
                    return
                }
                
                guard case let .success(result) = result else { return }
                Task {
                    await self?.loadWeatherData(for: result)
                    await self?.geocodeLocation(with: result)
                }
            })
    }
    
    private func loadWeatherData(for coordinate: CLLocationCoordinate2D) async {
        do {
            self.currentWeatherTask = try await weatherService.fetchWeather(for: coordinate)
            let data = try await currentWeatherTask!.value
            
            await updateData(from: data)
        } catch {
            await MainActor.run {
                self.error = error
            }
        }
    }
    
    private func geocodeLocation(with coordinates: CLLocationCoordinate2D) async {
        Logger.statistics.info("Location changed to : \(coordinates.latitude), \(coordinates.longitude)")
        
        do {
            self.currentGeocodingTask = try await geocodingService.geocode(with: coordinates)
            
            let location = try await currentGeocodingTask?.value
            guard let location else { return }
            
            await MainActor.run {
                Logger.statistics.info("Geocoded location: \(location.city)")
                self.currentCity = location.city
            }
        } catch {
            await MainActor.run {
                self.error = error
            }
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
        currentWeatherTask?.cancel()
        currentGeocodingTask?.cancel()
        locationResultCancellable?.cancel()
    }
}
