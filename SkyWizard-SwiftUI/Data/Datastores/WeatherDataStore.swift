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
import SkyWizardModel
import SkyWizardEnum

final class WeatherDataStore: @unchecked Sendable, ObservableObject {
    @Published var currentTemperature: Int = 0
    @Published var realFeel: Int = 0
    @Published var currentCity: String = "No Location"
    @Published var currentWeatherType: CurrentWeatherType = .day_sunny
    @Published var hourlyWeatherData: [HourlyWeatherData] = .init()
    @Published var dailyWeatherData: [DailyWeatherData] = .init()
    @Published var error: Swift.Error?
    @Published var weatherLoading: Bool = true
    @Published var isOnline: Bool = true
    @Published var greetingMessage: String = .init()
    private var currentWeatherTask: Task<WeatherData, Error>?
    private var currentGeocodingTask: Task<GeocodeData, Error>?
    private var cancelable: Set<AnyCancellable> = .init()
    private var isLocationLoadingStarted: Bool = false
    private var isMonitoringForReachabilityStarted: Bool = false
    
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
    }
    
    func loadWeather() {
        if !isLocationLoadingStarted {
            startLoadingLocation()
        }
        
        if !isMonitoringForReachabilityStarted {
            startMonitoringForReachability()
        }
    }
    
    func reloadWeather() {
        guard let location = locationService.getLastKnownLocation() else {
            self.error = WeatherDataStoreError.locationError
            return
        }
        
        Task {
            await loadWeatherData(for: location)
            await geocodeLocation(with: location)
        }
    }
    
    private func startLoadingLocation() {
        self.isLocationLoadingStarted = true
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
        locationService.start()
    }
    
    private func startMonitoringForReachability() {
        self.isMonitoringForReachabilityStarted = true
        reachabilityService
            .isReachable
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isOnline in
                let lastOnline = self?.isOnline
                self?.isOnline = isOnline
                
                if !isOnline { return }
                
                guard lastOnline != isOnline else {
                    Logger.viewCycle.info("Reachability hasn't changed. Returning")
                    return
                }
                
                Logger.viewCycle.info("Reachability changed to \(isOnline). Reloading weather data.")
                self?.reloadWeather()
            })
            .store(in: &cancelable)
    }
    
    private func loadWeatherData(for coordinate: CLLocationCoordinate2D) async {
        self.currentWeatherTask?.cancel()
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
        self.currentGeocodingTask?.cancel()
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
            
            Task {
                try? await Task.sleep(for: .seconds(1))
                self.greetingMessage = currentWeatherType.greeting
            }
        } catch {
            self.error = error
        }
    }
    
    func cancelCurrentTask() {
        currentWeatherTask?.cancel()
        currentGeocodingTask?.cancel()
        cancelable.removeAll()
    }
    
    #if DEBUG
    func changeWeatherType() {
        let type = CurrentWeatherType.allCases.randomElement()!
        self.currentWeatherType = type
        self.greetingMessage = type.greeting
    }
    #endif
}

enum WeatherDataStoreError: LocalizedError {
    case locationError
}

extension WeatherDataStoreError {
    var errorDescription: String? {
        switch self {
        case .locationError:
            return "Could not load location. Please try again later."
        }
    }
}
