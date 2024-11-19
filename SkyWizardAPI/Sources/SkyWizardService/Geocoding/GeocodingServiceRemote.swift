//
//  GeocodingServiceRemote.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import NetworkingService
import CoreLocation
import SkyWizardModel

public final class GeocodingServiceRemote: GeocodingService, @unchecked Sendable {
    
    let dataTransferService: NetworkDataTransferService
    
    public init(dataTransferService: NetworkDataTransferService) {
        self.dataTransferService = dataTransferService
    }
    
    public func geocode(with location: CLLocationCoordinate2D) async throws -> TaskType {
        Task {
            let task = await dataTransferService.request(with: GeocodingEndpoints.getGeocoding(latitude: location.latitude, longitude: location.longitude))
            let value: GeocodeData = try await task.value.mapToGeocodeResult()
            return value
        }
    }
}
