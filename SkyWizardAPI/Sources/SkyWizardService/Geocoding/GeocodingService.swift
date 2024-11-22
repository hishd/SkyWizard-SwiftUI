//
//  GeocodingService.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import CoreLocation
import SkyWizardModel

#if !os(macOS)
public protocol GeocodingService {
    typealias TaskType = Task<GeocodeData, Error>
    func geocode(with location: CLLocationCoordinate2D) async throws -> TaskType
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
#endif
