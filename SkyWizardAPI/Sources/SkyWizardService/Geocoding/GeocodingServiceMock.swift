//
//  GeocodingServiceMock.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import CoreLocation

public class GeocodingServiceMock: GeocodingService {
    public func geocode(with location: CLLocationCoordinate2D) async throws -> TaskType {
        return Task {
            throw GeocodingServiceError.invalidAddress(message: "Invalid address")
        }
    }
    
    public init() {}
}
