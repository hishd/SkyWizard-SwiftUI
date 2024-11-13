//
//  GeocodingServiceMock.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import CoreLocation

class GeocodingServiceMock: GeocodingService {
    func geocode(with location: CLLocationCoordinate2D) async throws -> TaskType {
        return Task {
            .sample
        }
    }
}
