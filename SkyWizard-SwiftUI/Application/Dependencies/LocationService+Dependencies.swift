//
//  LocationService+Dependencies.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 13/11/2024.
//

import Foundation
import DependencyInjector

final class LocationServiceMockDependency: InjectableDependency {
    static var dependency: LocationService = LocationServiceMock()
}

final class LocationServiceGpsDependency: InjectableDependency {
    static var dependency: LocationService = LocationServiceGps()
}

extension InjectableValues {
    var locationServiceMock: LocationService {
        get {
            LocationServiceMockDependency.dependency
        }
    }
    
    var locationServiceGps: LocationService {
        get {
            LocationServiceGpsDependency.dependency
        }
    }
}
