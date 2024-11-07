//
//  GeocodeResultDTO.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation

struct GeocodeResultDTO: Decodable {
    let features: [FeatureNode]
}

extension GeocodeResultDTO {
    struct FeatureNode: Decodable {
        let properties: PropertiesNode
    }
}

extension GeocodeResultDTO {
    struct PropertiesNode: Decodable {
        let country: String
        let city: String
    }
}

extension GeocodeResultDTO {
    func mapToGeocodeResult() throws -> GeocodeResult {
        guard let feature = features.first else {
            throw GeoCodeMappingError.invalidResponse(message: "No feature found in the response")
        }
        
        return .init(country: feature.properties.country, city: feature.properties.city)
    }
}

enum GeoCodeMappingError: Error {
    case invalidResponse(message: String)
}
