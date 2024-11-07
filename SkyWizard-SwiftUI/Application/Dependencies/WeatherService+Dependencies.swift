//
//  Dependencies.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import DependencyInjector
import NetworkingService

fileprivate final class WeatherServiceRemoteDependency: InjectableDependency {
    @Injectable(\.dataTransferServiceWeather) static var dataTransferService: NetworkDataTransferService
    static var dependency: WeatherService = WeatherServiceRemote(dataTransferService: dataTransferService)
}

fileprivate final class WeatherServiceMockDependency: InjectableDependency {
    static var dependency: WeatherService = WeatherServiceMock()
}

extension InjectableValues {
    var weatherServiceRemote: WeatherService {
        get {
            Self[WeatherServiceRemoteDependency.self]
        }
    }
    
    var weatherServiceMock: WeatherService {
        get {
            Self[WeatherServiceMockDependency.self]
        }
    }
}
