//
//  WeatherServiceRemote.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import CoreLocation
import NetworkingService

final class WeatherServiceRemote: WeatherService {
    let dataTransferService: NetworkDataTransferService
    
    init(dataTransferService: NetworkDataTransferService) {
        self.dataTransferService = dataTransferService
    }
    
    func fetchWeather(for location: CLLocationCoordinate2D) async throws -> TaskType {
        let task = Task {
            let task = await dataTransferService.request(with: WeatherEndpoints.getWeather(latitude: location.latitude, longitude: location.longitude))
            let value: WeatherData = try await task.value
            return value
        }
        
        return task
    }
}
