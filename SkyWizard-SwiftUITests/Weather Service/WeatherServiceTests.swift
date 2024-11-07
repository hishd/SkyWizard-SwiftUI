//
//  WeatherServiceTests.swift
//  SkyWizard-SwiftUITests
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Testing
import DependencyInjector
import NetworkingService
import CoreLocation
@testable import SkyWizard_SwiftUI

struct WeatherServiceTests {
    @Injectable(\.weatherService) var sut: WeatherService
    
    let testingLatitude: Double = 52.253643
    let testingLongitude: Double = -0.862097
    
    @Test
    func test_whether_result_for_location() async throws {
        let task = try await sut.fetchWeather(for: .init(latitude: testingLatitude, longitude: testingLongitude))
        let value = try await task.value
        
        #expect(value.latitude.rounded() == self.testingLatitude.rounded())
        #expect(value.longitude.rounded() == self.testingLongitude.rounded())
        #expect(!value.hourly.temperature_2m.isEmpty)
        #expect(!value.hourly.weather_code.isEmpty)
        #expect(!value.daily.weather_code.isEmpty)
        #expect(!value.daily.temperature_2m_max.isEmpty)
        #expect(!value.daily.temperature_2m_min.isEmpty)
    }
}
