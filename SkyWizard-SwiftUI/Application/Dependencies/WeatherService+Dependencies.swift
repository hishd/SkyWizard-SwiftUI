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
    static var dependency: WeatherService = WeatherServiceRemote(dataTransferService: Application.Networking.dataTransferServiceWeather)
}

extension InjectableValues {
    var weatherService: WeatherService {
        get {
            Self[WeatherServiceRemoteDependency.self]
        }
    }
}
