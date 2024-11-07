//
//  Dependencies.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import DependencyInjector
import NetworkingService

fileprivate class WeatherServiceRemoteDependency: InjectableDependency {
    static var dependency: WeatherService = WeatherServiceRemote(dataTransferService: Application.Networking.dataTransferService)
}

extension InjectableValues {
    var weatherService: WeatherService {
        get {
            Self[WeatherServiceRemoteDependency.self]
        }
        set {
            Self[WeatherServiceRemoteDependency.self] = newValue
        }
    }
}
