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
            return .init(country: "United Kingdom", city: "Northampton")
        }
    }
    
    public init() {}
}
