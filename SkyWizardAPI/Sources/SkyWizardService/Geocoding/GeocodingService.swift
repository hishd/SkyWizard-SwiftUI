//
//  GeocodingService.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import CoreLocation
import SkyWizardModel

public protocol GeocodingService {
    func geocode(with location: CLLocationCoordinate2D) async throws -> GeocodeData
}

public enum GeocodingServiceError: LocalizedError {
    case invalidAddress(message: String)
    case noResponse(message: String)
    case invalidResponse(message: String)
    
    public var errorDescription: String? {
        switch self {
        case .invalidAddress(let message):
            return message
        case .noResponse(let message):
            return message
        case .invalidResponse(let message):
            return message
        }
    }
}
