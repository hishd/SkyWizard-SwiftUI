//
//  WeatherServiceTests.swift
//  SkyWizard-SwiftUITests
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Testing
import NetworkingService
import CoreLocation
import SkyWizardService
import SkyWizardModel
import SkyWizardEnum

struct WeatherServiceTests {
    let sut: WeatherService = {
        let networkConfig: ApiNetworkConfig = {
            guard let url = URL(string: "https://api.open-meteo.com/v1") else {
                fatalError("Could not create URL from string: https://api.open-meteo.com/v1")
            }
            return .init(baseUrl: url)
        }()
        
        let networkService: NetworkService = DefaultNetworkService.init(networkConfig: networkConfig, sessionManagerType: .defaultType, loggerType: .defaultType)
        let dataTransferService: NetworkDataTransferService = DefaultNetworkDataTransferService(networkService: networkService, logger: DefaultNetworkDataTransferErrorLogger())
        
        return WeatherServiceRemote(dataTransferService: dataTransferService)
    }()
    
    let testingLatitude: Double = 52.253643
    let testingLongitude: Double = -0.862097
    
    @Test
    func test_whether_result_for_location() async throws {
        let result = try await sut.fetchWeather(for: .init(latitude: testingLatitude, longitude: testingLongitude))
        
        #expect(result.latitude.rounded() == self.testingLatitude.rounded())
        #expect(result.longitude.rounded() == self.testingLongitude.rounded())
        #expect(!result.hourly.temperature_2m.isEmpty)
        #expect(!result.hourly.weather_code.isEmpty)
        #expect(!result.daily.weather_code.isEmpty)
        #expect(!result.daily.temperature_2m_max.isEmpty)
        #expect(!result.daily.temperature_2m_min.isEmpty)
    }
    
    @Test
    func test_get_current_weather_type() async throws {
        let result = try await sut.fetchWeather(for: .init(latitude: testingLatitude, longitude: testingLongitude))
        
        let current = result.current
        let currentType: CurrentWeatherType = sut.getWeatherType(for: current)
        #expect(currentType != CurrentWeatherType.undefined)
    }
    
    @Test
    func test_get_hourly_weather() async throws {
        let result = try await sut.fetchWeather(for: .init(latitude: testingLatitude, longitude: testingLongitude))
        
        let hourly = result.hourly
        let hourlyWeather: [HourlyWeatherData] = try sut.getWeather(for: hourly)
        print(hourlyWeather)
        #expect(!hourlyWeather.isEmpty)
    }
    
    @Test
    func test_get_daily_weather() async throws {
        let result = try await sut.fetchWeather(for: .init(latitude: testingLatitude, longitude: testingLongitude))
        
        let daily = result.daily
        let dailyWeather: [DailyWeatherData] = try sut.getWeather(for: daily)
        print(dailyWeather)
        #expect(!dailyWeather.isEmpty)
    }
}
