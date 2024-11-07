//
//  GeocodingService.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import CoreLocation

protocol GeocodingService {
    typealias TaskType = Task<GeocodeData, Error>
    func geocode(with location: CLLocationCoordinate2D) async throws -> TaskType
}

enum GeocodingServiceError: Error {
    case invalidAddress(message: String)
    case noResponse(message: String)
    case invalidResponse(message: String)
}
