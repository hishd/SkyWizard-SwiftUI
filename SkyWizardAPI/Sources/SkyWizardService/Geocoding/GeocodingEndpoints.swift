//
//  GeocodingEndpoints.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import NetworkingService

enum GeocodingEndpoints {
    static func getGeocoding(latitude: Double, longitude: Double) -> ApiEndpoint<GeocodeResultDTO> {
        var queryParams: [String: Any] = [:]
        queryParams["lon"] = longitude
        queryParams["lat"] = latitude
        
        return .init(path: .path("reverse"), method: .get, queryParameters: queryParams)
    }
}
