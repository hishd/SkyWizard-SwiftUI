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

#if DEBUG
fileprivate final class WeatherServiceMockDependency: InjectableDependency {
    static var dependency: WeatherService = WeatherServiceMock()
}
#endif

extension InjectableValues {
    var weatherServiceRemote: WeatherService {
        get {
            Self[WeatherServiceRemoteDependency.self]
        }
    }
    
    #if DEBUG
    var weatherServiceMock: WeatherService {
        get {
            Self[WeatherServiceMockDependency.self]
        }
    }
    #endif
}
