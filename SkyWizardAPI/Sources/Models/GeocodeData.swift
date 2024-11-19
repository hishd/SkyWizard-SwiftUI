//
//  GeocodeResult.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation

public struct GeocodeData : Sendable {
    public let country: String
    public let city: String
    
    public init(country: String, city: String) {
        self.country = country
        self.city = city
    }
}

extension GeocodeData: Codable {
    #if DEBUG
    static let sample: Self = .init(country: "United Kingdom", city: "Northampton")
    #endif
}
