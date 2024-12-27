//
//  GeocodingServiceTests.swift
//  SkyWizard-SwiftUITests
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import Testing
import CoreLocation
import SkyWizardService
import NetworkingService

struct GeocodingServiceTests {
    let sut: GeocodingService = {
        let networkConfig: ApiNetworkConfig = {
            guard let url = URL(string: "https://photon.komoot.io") else {
                fatalError("Could not create URL from string: https://photon.komoot.io")
            }
            return .init(baseUrl: url)
        }()
        
        let networkService: NetworkService = DefaultNetworkService.init(networkConfig: networkConfig, sessionManagerType: .defaultType, loggerType: .defaultType)
        let dataTransferService: NetworkDataTransferService = DefaultNetworkDataTransferService(networkService: networkService, logger: DefaultNetworkDataTransferErrorLogger())
        
        return GeocodingServiceRemote(dataTransferService: dataTransferService)
    }()
    
    let testingLatitude: Double = 52.253643
    let testingLongitude: Double = -0.862097
    
    @Test
    func geocode() async throws {
        let result = try await sut.geocode(with: CLLocationCoordinate2D(latitude: testingLatitude, longitude: testingLongitude))
        
        let expectedCountry: String = "United Kingdom"
        let expectedCity: String = "Northampton"
        
        #expect(result.country == expectedCountry)
        #expect(result.city == expectedCity)
    }
}
