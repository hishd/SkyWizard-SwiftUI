//
//  GeocodingServiceRemote.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import CoreLocation
import NetworkingService
import SkyWizardModel

public final class GeocodingServiceRemote: GeocodingService {
    
    let dataTransferService: NetworkDataTransferService
    
    public init(dataTransferService: NetworkDataTransferService) {
        self.dataTransferService = dataTransferService
    }
    
    public func geocode(with location: CLLocationCoordinate2D) async throws -> GeocodeData {
        let task = await dataTransferService.request(with: GeocodingEndpoints.getGeocoding(latitude: location.latitude, longitude: location.longitude))
        let value: GeocodeData = try await task.value.mapToGeocodeResult()
        return value
    }
}
