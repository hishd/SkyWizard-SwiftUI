//
//  LocationServiceMock.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 13/11/2024.
//

import Foundation
import Combine
import CoreLocation

public final class LocationServiceMock: LocationService, @unchecked Sendable {
    public let locationResult: PassthroughSubject<LocationResult, Never> = .init()
    
    public func start() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            self.locationResult.send(.success(.init(latitude: 0, longitude: 0)))
        }
    }
    
    public func getLastKnownLocation() -> CLLocationCoordinate2D? {
        .init(latitude: 0, longitude: 0)
    }
    
    public init() {}
}
