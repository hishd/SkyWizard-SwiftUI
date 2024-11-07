//
//  GeocodingService+Dependencies.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import NetworkingService
import DependencyInjector

fileprivate final class GeocodingServiceRemoteDependency: InjectableDependency {
    static var dependency: GeocodingService = GeocodingServiceRemote(dataTransferService: Application.Networking.dataTransferService)
}

extension InjectableValues {
    var geoCodingService: GeocodingService {
        get {
            Self[GeocodingServiceRemoteDependency.self]
        }
    }
}
