//
//  WeatherDataStore+Dependencies.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 12/11/2024.
//

import Foundation
import DependencyInjector

fileprivate final class WeatherDataStoreInjectableDependency: InjectableDependency {
    @Injectable(\.locationServiceGps) private static var locationService: LocationService
    @Injectable(\.weatherServiceRemote) private static var weatherService: WeatherService
    @Injectable(\.geoCodingServiceRemote) private static var geocodingService: GeocodingService
    @Injectable(\.networkReachabilityService) private static var reachabilityService: ReachabilityService
    static var dependency: WeatherDataStore = .init(
        weatherService: weatherService,
        geocodingService: geocodingService,
        locationService: locationService,
        reachabilityService: reachabilityService
    )
}

fileprivate final class WeatherDataStoreMockInjectableDependency: InjectableDependency {
    @Injectable(\.locationServiceMock) private static var locationService: LocationService
    @Injectable(\.weatherServiceMock) private static var weatherService: WeatherService
    @Injectable(\.geoCodingServiceMock) private static var geocodingService: GeocodingService
    @Injectable(\.reachabilityServiceMock) private static var reachabilityService: ReachabilityService
    static var dependency: WeatherDataStore = .init(
        weatherService: weatherService,
        geocodingService: geocodingService,
        locationService: locationService,
        reachabilityService: reachabilityService
    )
}

extension InjectableValues {
    var weatherDataStore: WeatherDataStore {
        get {
            WeatherDataStoreInjectableDependency.dependency
        }
    }
    
    var weatherDataStoreMock: WeatherDataStore {
        get {
            WeatherDataStoreMockInjectableDependency.dependency
        }
    }
}
