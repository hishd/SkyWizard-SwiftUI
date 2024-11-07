//
//  GeocodingServiceRemote.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import NetworkingService
import CoreLocation

final class GeocodingServiceRemote: GeocodingService {
    
    let dataTransferService: NetworkDataTransferService
    
    init(dataTransferService: NetworkDataTransferService) {
        self.dataTransferService = dataTransferService
    }
    
    func geocode(with location: CLLocationCoordinate2D) async throws -> TaskType {
        let task = Task {
            let task = await dataTransferService.request(with: GeocodingEndpoints.getGeocoding(latitude: location.latitude, longitude: location.longitude))
            let value: GeocodeResult = try await task.value.mapToGeocodeResult()
            return value
        }
        
        return task
    }
}