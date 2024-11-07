//
//  GeocodingServiceTests.swift
//  SkyWizard-SwiftUITests
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import Testing
import DependencyInjector
import CoreLocation

@testable import SkyWizard_SwiftUI

struct GeocodingServiceTests {
    @Injectable(\.geoCodingService) var sut: GeocodingService
    let testingLatitude: Double = 52.253643
    let testingLongitude: Double = -0.862097
    
    @Test
    func geocode() async throws {
        let result = try await sut.geocode(with: CLLocationCoordinate2D(latitude: testingLatitude, longitude: testingLongitude))
        let value = try await result.value
        
        let expectedCountry: String = "United Kingdom"
        let expectedCity: String = "Northampton"
        
        #expect(value.country == expectedCountry)
        #expect(value.city == expectedCity)
    }
}
