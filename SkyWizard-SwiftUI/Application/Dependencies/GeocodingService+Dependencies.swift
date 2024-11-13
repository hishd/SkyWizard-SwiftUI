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
    @Injectable(\.dataTransferServiceGeocoding) static var dataTransferService: NetworkDataTransferService
    static var dependency: GeocodingService = GeocodingServiceRemote(dataTransferService: dataTransferService)
}

fileprivate final class GeocodingServiceMockDependency: InjectableDependency {
    static var dependency: GeocodingService = GeocodingServiceMock()
}

extension InjectableValues {
    var geoCodingServiceRemote: GeocodingService {
        get {
            Self[GeocodingServiceRemoteDependency.self]
        }
    }
    
    var geoCodingServiceMock: GeocodingService {
        get {
            Self[GeocodingServiceMockDependency.self]
        }
    }
}
