//
//  WeatherDataStore+Dependencies.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 12/11/2024.
//

import Foundation
import DependencyInjector

fileprivate final class WeatherDataStoreInjectableDependency: InjectableDependency {
    @Injectable(\.weatherServiceRemote) private static var weatherService: WeatherService
    @Injectable(\.geoCodingServiceRemote) private static var geocodingService: GeocodingService
    static var dependency: WeatherDataStore = .init(weatherService: weatherService, geocodingService: geocodingService)
}

extension InjectableValues {
    var weatherDataStore: WeatherDataStore {
        get {
            WeatherDataStoreInjectableDependency.dependency
        }
    }
}
