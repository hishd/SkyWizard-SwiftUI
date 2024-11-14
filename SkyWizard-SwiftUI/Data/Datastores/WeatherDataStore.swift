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
    @Published var currentCity: String = "Location"
    @Published var currentWeatherType: CurrentWeatherType = .day_sunny
    @Published var hourlyWeatherData: [HourlyWeatherData] = .init()
    @Published var dailyWeatherData: [DailyWeatherData] = .init()
    @Published var error: Swift.Error?
    @Published var weatherLoading: Bool = true
    @Published var isOffline: Bool = false
    var currentWeatherTask: Task<WeatherData, Error>?
    var currentGeocodingTask: Task<GeocodeData, Error>?
    var cancelable: Set<AnyCancellable> = .init()
    
    var weatherTypeResource: WeatherTypeResource {
        currentWeatherType.getWeatherTypeResource()
    }
    
    let weatherService: WeatherService
    let geocodingService: GeocodingService
    let locationService: LocationService
    let reachabilityService: ReachabilityService
    
    init(weatherService: WeatherService, geocodingService: GeocodingService, locationService: LocationService, reachabilityService: ReachabilityService) {
        self.weatherService = weatherService
        self.geocodingService = geocodingService
        self.locationService = locationService
        self.reachabilityService = reachabilityService
        startMonitoringForReachability()
        locationService.start()
    }
    
    func startLoadingWeather() {
        locationService.locationResult
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] result in
                if case let .failure(error) = result {
                    self?.weatherLoading = false
                    self?.error = error
                    return
                }
                
                guard case let .success(result) = result else { return }
                Task {
                    await self?.loadWeatherData(for: result)
                    await self?.geocodeLocation(with: result)
                }
            })
            .store(in: &cancelable)
    }
    
    private func startMonitoringForReachability() {
        reachabilityService
            .isReachable
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isOnline in
                if !isOnline {
                    guard let weatherTask = self?.currentWeatherTask, let geocodingTask = self?.currentGeocodingTask else { return }
                    weatherTask.cancel()
                    geocodingTask.cancel()
                    self?.isOffline = true
                    return
                }
                
                self?.isOffline = false
                self?.startLoadingWeather()
            })
            .store(in: &cancelable)
    }
    
    private func loadWeatherData(for coordinate: CLLocationCoordinate2D) async {
        do {
            self.currentWeatherTask = try await weatherService.fetchWeather(for: coordinate)
            let data = try await currentWeatherTask!.value
            
            await updateData(from: data)
        } catch {
            await MainActor.run {
                self.weatherLoading = false
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
                self.weatherLoading = false
                self.currentCity = location.city
            }
        } catch {
            await MainActor.run {
                self.weatherLoading = false
                self.error = error
            }
        }
    }
    
    @MainActor
    private func updateData(from weather: WeatherData) {
        do {
            self.weatherLoading = false
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
        cancelable.removeAll()
    }
}
