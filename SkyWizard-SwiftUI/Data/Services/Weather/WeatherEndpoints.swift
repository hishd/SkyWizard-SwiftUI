//
//  WeatherEndpoints.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import NetworkingService

enum WeatherEndpoints {
    static func getWeather(latitude: Double, longitude: Double) -> ApiEndpoint<WeatherData> {
        var queryParams: [String: Any] = [:]
        queryParams["latitude"] = latitude
        queryParams["longitude"] = longitude
        queryParams["current"] = "temperature_2m,apparent_temperature,weather_code,is_day"
        queryParams["hourly"] = "temperature_2m,weather_code"
        queryParams["daily"] = "weather_code,temperature_2m_max,temperature_2m_min"
        queryParams["timezone"] = TimeZone.current.identifier
        return .init(path: .path("forecast"), method: .get, queryParameters: queryParams)
    }
}
