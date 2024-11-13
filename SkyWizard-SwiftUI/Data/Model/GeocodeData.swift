//
//  GeocodeResult.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation

struct GeocodeData {
    let country: String
    let city: String
}

extension GeocodeData: Codable {
    #if DEBUG
    static let sample: Self = .init(country: "United Kingdom", city: "Northampton")
    #endif
}
